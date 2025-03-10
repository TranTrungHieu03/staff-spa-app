import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
      levelEmojis: {
        Level.verbose: '📝',
        Level.debug: '🐛 👻',
        Level.info: 'ℹ️ 🚀',
        Level.warning: '⚠️ ',
        Level.error: '🚨',
        Level.wtf: '🤷‍♂️ 🤷‍♀️ ',
      },
    ),
  );

  // Log thông tin thông thường
  static void info(dynamic message) {
    _logger.i(message);
  }

  // Log thông tin debug
  static void debug(dynamic message) {
    _logger.d(message);
  }

  // Log cảnh báo
  static void warning(dynamic message) {
    _logger.w(message);
  }

  // Log lỗi
  static void error(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  // Log thông tin verbose
  static void verbose(dynamic message) {
    _logger.v(message);
  }

  // Log thông tin wtf (What a Terrible Failure)
  static void wtf(dynamic message) {
    _logger.wtf(message);
  }
}
