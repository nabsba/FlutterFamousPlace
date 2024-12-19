// Success message keys
const Map<String, String> successMessagesKeys = {
  'LOGIN': 'login',
  'REGISTER_USER': 'registerUser',
  'REGISTER_USER_WITH_COOKIE': 'registerUserWithCookie',
  'REFRESH_TOKEN': 'refreshToken',
  'TOKEN': 'token',
};

// Success status codes
const Map<String, int> successStatus = {
  'OK': 200, // Success status code
  'CREATED': 201, // Resource created successfully
  'ACCEPTED': 202, // Request accepted but processing not yet completed
  'NO_CONTENT': 204, // No content in the response
  'PARTIAL_CONTENT': 206, // Partial content returned
};
