import { logErrorAsyncMessage, logMessage } from '../../common';

const register = async (): Promise<void> => {
  try {
  } catch (error: unknown) {
    if (error instanceof Error) {
      logMessage(`${logErrorAsyncMessage('auth/services/authentifications', `Error register:`)},
      ${error.message}`);
      throw new Error(`Error webAuthorization', ${error.message}`);
    } else {
      logMessage(`${logErrorAsyncMessage('auth/services/authentifications', `Unknown error`)}`);
     throw new Error(`auth/services/authentifications',  unknown error`);
    }
 
  }
};

const login = async (): Promise<void> => {
  try {
  } catch (error: unknown) {
    if (error instanceof Error) {
      logMessage(`${logErrorAsyncMessage('auth/services/authentifications', `login:`)},
      ${error.message}`);
      throw new Error(`Error webAuthorization', ${error.message}`);
    } else {
      logMessage(`${logErrorAsyncMessage('auth/services/authentifications', `Unknown error`)}`);
     throw new Error(`auth/services/authentifications',  unknown error`);
    }
  }
};

const logout = async (): Promise<void> => {
  try {
  } catch (error: unknown) {
    if (error instanceof Error) {
      logMessage(`${logErrorAsyncMessage('auth/services/authentifications', `logout:`)},
      ${error.message}`);
      throw new Error(`Error logout', ${error.message}`);
    } else {
      logMessage(`${logErrorAsyncMessage('autlogout/services/authentifications', `Unknown error`)}`);
     throw new Error(`auth/services/authentifications',  unknown error`);
    }
 
  }
};

const isAuthenticated = async (): Promise<void> => {
  try {
  } catch (error: unknown) {
    if (error instanceof Error) {
      logMessage(`${logErrorAsyncMessage('auth/services/authentifications', `isAuthenticated:`)},
      ${error.message}`);
      throw new Error(`Error logout', ${error.message}`);
    } else {
      logMessage(`${logErrorAsyncMessage('autlogout/services/authentifications', `Unknown error`)}`);
     throw new Error(`auth/services/authentifications',  isAuthenticated unknown error`);
    }
 
  }
};

const resetPassword = async (): Promise<void> => {
  try {
  } catch (error: unknown) {
    if (error instanceof Error) {
      logMessage(`${logErrorAsyncMessage('auth/services/authentifications', `resetPassword:`)},
      ${error.message}`);
      throw new Error(`Error logout', ${error.message}`);
    } else {
      logMessage(`${logErrorAsyncMessage('autlogout/services/authentifications', `Unknown error`)}`);
     throw new Error(`auth/services/authentifications',  resetPassword unknown error`);
    }
 
  }
};

const updatePassword = async (): Promise<void> => {
  try {
  } catch (error: unknown) {
    if (error instanceof Error) {
      logMessage(`${logErrorAsyncMessage('auth/services/authentifications', `resetPassword:`)},
      ${error.message}`);
      throw new Error(`Error logout', ${error.message}`);
    } else {
      logMessage(`${logErrorAsyncMessage('autlogout/services/authentifications', `Unknown error`)}`);
     throw new Error(`auth/services/authentifications',  updatePassword unknown error`);
    }
 
  }
};

export { register, login, logout, isAuthenticated, resetPassword, updatePassword };
