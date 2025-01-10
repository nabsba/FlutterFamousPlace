import jwt from 'jsonwebtoken';
import { AUTHORIZATION_HEADER_TYPE, logErrorAsyncMessage, logMessage } from '../../common';
import { ReturnTokenArgs } from '../types/types';
import { Request } from "express";

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
  } catch (error: unknown) {

    if (error instanceof Error) {
      logMessage(`${logErrorAsyncMessage('jwt/services/function', `returnToken`)},
      ${error.message}`);
      throw new Error(`Error return token:', ${error.message}`);
    } else {
      logMessage(`${logErrorAsyncMessage('jwt/services/function', `returnToken`)},
     unknown error occured`);
     throw new Error(`Error return token:',  returnToken`);
    }


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
  } catch (error: unknown) {

    if (error instanceof Error) {
      logMessage(`${logErrorAsyncMessage('jwt/services/function', `verifyToken`)},
      ${error.message}`);
      throw new Error(`Error verifyToken:', ${error.message}`);
    } else {
      logMessage(`${logErrorAsyncMessage('jwt/services/function', `verifyToken`)},
      unknown error`);
     throw new Error(`Error verifyToken:',  unknown error`);
    }
  }
};

const mobileAuthorization = (req:Request) => {
  try {
    const token = req.headers.authorization!.replace('Bearer ', '');
    verifyToken(token);
  } catch (error: unknown) {

    if (error instanceof Error) {
      logMessage(`${logErrorAsyncMessage('jwt/services/function/mobileAuthorization', `mobileAuthorization`)},
    ${error.message}`);
      throw new Error(`Error mobileAuthorization:', ${error.message}`);
    } else {
      logMessage(`${logErrorAsyncMessage('jwt/services/function', `mobileAuthorization`)},
      unknown error`);
     throw new Error(`Error mobileAuthorization:',  unknown error`);
    }
  }

 
};
const webAuthorization = (req: Request) => {
  try {
    // not yet developed
    console.log(req);
    return true;
  } catch (error: unknown) {
    if (error instanceof Error) {
      logMessage(`${logErrorAsyncMessage('jwt/services/function/webAuthorization', `Error webAuthorizationn:`)},
      ${error.message}`);
      throw new Error(`Error webAuthorization', ${error.message}`);
    } else {
      logMessage(`${logErrorAsyncMessage('jwt/services/function/webAuthorization', `Unknown error`)}`);
     throw new Error(`Error webAuthorization',  unknown error`);
    }


 
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
export { returnToken, verifyToken, handleVerifyToken };
