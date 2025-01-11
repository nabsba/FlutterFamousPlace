import { AUTHORIZATION_HEADER_TYPE, ERROR_MESSAGES, logErrorAsyncMessage, logMessage } from '../../common';
import prismaClientDB from '../../lib/prismadb';
import { mobileAuthorization, returnToken, webAuthorization } from '../services/function';
import { ReturnTokenArgs } from '../types/types';
import { Request } from 'express';
const handleRefreshToken = async (data: ReturnTokenArgs) => {
  try {
    const token = returnToken(data);
    await prismaClientDB.account.update({
      where: {
        provider_providerAccountId: {
          provider: data.provider,
          providerAccountId: data.providerAccountId,
          userId: data.id,
        },
      },
      data: {
        refresh_token: token, // Update the refreshToken field
      },
    });
    return token;
  } catch (error) {
    logMessage(`${logErrorAsyncMessage('jwt/models/jwt', `Error handling JWT token`)},
    ${error}`);
    throw new Error(ERROR_MESSAGES.REFRESH_TOKEN);
  }
};
const handleVerifyToken = (req: Request) => {
  try {
    if (req.headers && req.headers.authorization) {
      switch (req.headers.authorizationsource) {
        case AUTHORIZATION_HEADER_TYPE.MOBILE:
          return mobileAuthorization(req);
        case AUTHORIZATION_HEADER_TYPE.WEB:
          return webAuthorization(req);
        default:
          throw new Error('No authorization passed');
      }
    }
    throw new Error('No authorization passed');
  } catch (error: unknown) {
    if (error instanceof Error) {
      logMessage(`${logErrorAsyncMessage('jwt/services/function/handleVerifyToken', `handleVerifyToken`)},
      ${error.message}`);
      throw new Error(`Error verifying token:', ${error.message}`);
    } else {
      logMessage(`${logErrorAsyncMessage('jwt/services/function/handleVerifyToken', `Unknown error`)}`);
      throw new Error(`Error verifying token:', unknown error`);
    }
  }
};
export { handleRefreshToken, handleVerifyToken };
