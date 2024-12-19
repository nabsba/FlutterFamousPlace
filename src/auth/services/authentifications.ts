import { logErrorAsyncMessage, logMessage } from '../../common';

const register = async (body: any): Promise<void> => {
  try {
  } catch (error: any) {
    logMessage(`${logErrorAsyncMessage('security/bcrypt', 'bcryptHash')},
			${error}`);
  }
};

const login = async (body: any): Promise<void> => {
  try {
  } catch (error: any) {
    logMessage(`${logErrorAsyncMessage('security/bcrypt', 'bcryptHash')},
			${error}`);
  }
};

const logout = async (body: any): Promise<void> => {
  try {
  } catch (error: any) {
    logMessage(`${logErrorAsyncMessage('security/bcrypt', 'bcryptHash')},
			${error}`);
  }
};

const isAuthenticated = async (body: any): Promise<void> => {
  try {
  } catch (error: any) {
    logMessage(`${logErrorAsyncMessage('security/bcrypt', 'bcryptHash')},
			${error}`);
  }
};

const resetPassword = async (body: any): Promise<void> => {
  try {
  } catch (error: any) {
    logMessage(`${logErrorAsyncMessage('security/bcrypt', 'bcryptHash')},
			${error}`);
  }
};

const updatePassword = async (body: any): Promise<void> => {
  try {
  } catch (error: any) {
    logMessage(`${logErrorAsyncMessage('security/bcrypt', 'bcryptHash')},
			${error}`);
  }
};

export { register, login, logout, isAuthenticated, resetPassword, updatePassword };
