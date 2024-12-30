import jwt from 'jsonwebtoken';
import { logErrorAsyncMessage, logMessage } from '../../common';
import { ReturnTokenArgs } from '../types/types';

const returnToken = (data: ReturnTokenArgs): string | null => {
  try {
    const { id, email, userName, provider, providerAccountId } = data;
    const jwtSecretKey = process.env.JWT_SECRET_KEY;
    if (!jwtSecretKey) {
      throw new Error('Missing JWT_SECRET_KEY');
    }

    const payload = {
      time: new Date().toISOString(),
      id,
      email,
      userName,
      provider,
      providerAccountId,
    };

    const token = jwt.sign({ exp: Math.floor(Date.now() / 1000) + 864000, payload }, jwtSecretKey);
    return token;
  } catch (error: any) {
    logMessage(`${logErrorAsyncMessage('jwt/services/function', `Error generating JWT token`)},
    ${error.message}`);
    throw new Error(`Error generating JWT token:', ${error.message}`);
  }
};
const verifyToken = (token: string): jwt.JwtPayload | null => {
  try {
    const jwtSecretKey = process.env.JWT_SECRET_KEY;
    if (!jwtSecretKey) {
      throw new Error('JWT secret key is not defined in environment variables.');
    }
    const verified = jwt.verify(token, jwtSecretKey) as jwt.JwtPayload;
    return verified;
  } catch (error: any) {
    logMessage(`${logErrorAsyncMessage('jwt/services/function', `Error verifying token:`)},
    ${error.message}`);
    throw new Error(`Error verifying token:', ${error.message}`);
  }
};

export { returnToken, verifyToken };
