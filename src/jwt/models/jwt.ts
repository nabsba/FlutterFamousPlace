import { ERROR_MESSAGES, logErrorAsyncMessage, logMessage } from '../../common';
import prismaClientDB from '../../lib/prismadb';
import { returnToken } from '../services/function';
import { ReturnTokenArgs } from '../types/types';

const handleRefreshToken = async (data: ReturnTokenArgs) => {
  try {
    const token = returnToken(data);
    await prismaClientDB.account.update({
      where: {
        provider_providerAccountId: {
          provider: data.provider,
          providerAccountId: data.providerAccountId,
          userId: data.id
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

export { handleRefreshToken };
