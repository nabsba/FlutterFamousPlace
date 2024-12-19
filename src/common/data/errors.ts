const ERROR_MESSAGES = {
  LOGIN: 'Login failed. Please check your credentials and try again.',
  REGISTER_USER: 'Registration failed. Please ensure all fields are correct.',
  REGISTER_USER_WITH_COOKIE: 'Failed to register with the provided cookie. Please try again.',
  REFRESH_TOKEN: 'Refresh token failed.',
};

const ERROR_MESSAGES_KEYS = {
  LOGIN: 'login',
  REGISTER_USER: 'registerUser',
  REGISTER_USER_WITH_COOKIE: 'registerUserWithCookie',
  REFRESH_TOKEN: 'refreshToken',
};


const STATUS_SERVER = {
  SERVER_ERROR: 500,
  NOT_FOUND: 404,
  UNAUTHORIZED: 401,
  FORBIDDEN: 403,
  BAD_REQUEST: 400,
  OK: 200,
  CREATED: 201,
  ACCEPTED: 202,
  NO_CONTENT: 204,
};

export {ERROR_MESSAGES,ERROR_MESSAGES_KEYS, STATUS_SERVER }