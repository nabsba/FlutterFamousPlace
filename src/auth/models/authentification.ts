import { ERROR_MESSAGES, logErrorAsyncMessage, logMessage } from '../../common';
import { returnToken } from '../../jwt';
import { handleRefreshToken } from '../../jwt/models/jwt';
import prismaClientDB from '../../lib/prismadb';
import { LoginArgs, registerUser } from '../types/types';

const handleLogin = async (data: LoginArgs) => {
  try {
    const { userName, password } = data;
    const result = await prismaClientDB.userAuthentification.findFirst({
      where: {
        userName,
        password,
      },
    });
  } catch (error) {
    logMessage(`${logErrorAsyncMessage('auth/models/authentification', `${ERROR_MESSAGES.LOGIN}:`)},
  ${error}`);
  }
};

const handleRegisterUser = async (data: registerUser) => {
  try {
    return await prismaClientDB.$transaction(async (tx) => {
      const account = await tx.account.findUnique({
        where: {
          provider_providerAccountId: {
            provider: data.data.providerAccountId,
            providerAccountId: data.data.providerAccountId,
            userId: data.data.id,
          },
        },
      });

      if (account) {
        return await handleRefreshToken(data.data);
      }

      const clientRole = await tx.role.findUnique({
        where: { roleName: 'client' },
      });
      if (!clientRole) {
        throw new Error('Default role "client" not found');
      }

      const token = returnToken(data.data);
      await tx.user.create({
        data: {
          id: data.data.id,
          email: data.data.email,
          name: data.data.userName, // Optional, set as per the data
          roleId: clientRole.id, // Make sure to reference a valid role ID
          accounts: {
            create: {
              type: data.data.type,
              provider: data.data.providerAccountId,
              providerAccountId: data.data.providerAccountId,
              refresh_token: token, // Optional
            },
          },
        },
      });
      return token;
    });
  } catch (error) {
    logMessage(`${logErrorAsyncMessage('auth/models/authentification', `${ERROR_MESSAGES.REGISTER_USER}:`)},
    ${error}`);
    throw new Error(ERROR_MESSAGES.REGISTER_USER);
  }
};

const handleRegisterUserWithCookie = async (data: registerUser) => {
  try {
    const result = await prismaClientDB.userAuthentification.findFirst({
      where: {
        userName: data.data.userName,
      },
    });
  } catch (error) {
    logMessage(`${logErrorAsyncMessage(
      'auth/models/authentification/',
      `${ERROR_MESSAGES.REGISTER_USER_WITH_COOKIE}:`,
    )},
    ${error}`);
  }
};

export { handleLogin, handleRegisterUser, handleRegisterUserWithCookie };
