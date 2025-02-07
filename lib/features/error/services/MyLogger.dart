import 'package:logger/logger.dart';

class MyLogger {
  // Create a logger instance
  static final Logger logger = Logger();

  // Example of logging in different levels
  static void logInfo(String message) {
    logger.i(message); // Info log
  }

  static void logDebug(String message) {
    logger.d(message); // Debug log
  }

  static void logWarning(String message) {
    logger.w(message); // Warning log
  }

  static void logError(String message,
      [dynamic error, StackTrace? stackTrace]) {
    logger.e(message, error: error, stackTrace: stackTrace); // Error log
  }
}
