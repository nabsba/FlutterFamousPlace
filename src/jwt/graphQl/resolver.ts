import { registerUser } from '../../auth/types/types';
import {
  ERROR_MESSAGES,
  ERROR_MESSAGES_KEYS,
  logErrorAsyncMessage,
  logMessage,
  STATUS_SERVER,
  SUCCESS_STATUS,
  SUCCESS_MESSAGES_KEYS,
} from '../../common';
import { handleRefreshToken } from '../models/jwt';

export const resolversJWT = {
  Mutation: {
    refreshToken: async (_: any, data: registerUser) => {
      try {
        const token = await handleRefreshToken(data.data);
        return {
          status: SUCCESS_STATUS.OK,
          isError: false,
          messageKey: SUCCESS_MESSAGES_KEYS.REFRESH_TOKEN,
          data: {
            token: token,
          },
        };
      } catch (error) {
        logMessage(`${logErrorAsyncMessage('src/JWT/graphQL/resolvers.ts', `${ERROR_MESSAGES.REGISTER_USER}:`)},
        ${error}`);

        return {
          status: STATUS_SERVER.SERVER_ERROR,
          isError: true,
          messageKey: ERROR_MESSAGES_KEYS.REFRESH_TOKEN,
        };
      }
    },
  },
};
