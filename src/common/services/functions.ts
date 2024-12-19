const logMessage = (message: string): void => {
  if (process.env.NEXT_PUBLIC_DEVELOPMENT == 'true') console.error(message);
};
const logErrorAsyncMessage = (path: string, method: string): string => `*** file: ${path}, method: ${method} `;

export { logMessage, logErrorAsyncMessage };
