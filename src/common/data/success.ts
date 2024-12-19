const SUCCESS_MESSAGES = {
  LOGIN: 'Login successful. Welcome back!',
  REGISTER_USER: 'Registration successful. You can now log in.',
  REGISTER_USER_WITH_COOKIE: 'Successfully registered using the provided cookie.',
  REFRESH_TOKEN: 'The token has been refreshed',
};

const SUCCESS_MESSAGES_KEYS = {
  LOGIN: 'login',
  REGISTER_USER: 'registerUser',
  REGISTER_USER_WITH_COOKIE: 'registerUserWithCookie',
  REFRESH_TOKEN: 'refreshToken',
};


const SUCCESS_STATUS = {
  OK: 200, // Success status code
  CREATED: 201, // Resource created successfully
  ACCEPTED: 202, // Request accepted but processing not yet completed
  NO_CONTENT: 204, // No content in the response
  PARTIAL_CONTENT: 206, // Partial content returned
};



export {SUCCESS_MESSAGES, SUCCESS_MESSAGES_KEYS, SUCCESS_STATUS }