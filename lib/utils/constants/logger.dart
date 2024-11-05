import 'package:logger/logger.dart';

Logger logger(Level logLevel) {
  final logger = Logger(
    level: logLevel,
    filter: null,
    printer: PrettyPrinter(),
    output: null,
  );
  return logger;
}

 void debugLog(dynamic message) {
  logger(Level.debug).d(message);
}

void errorLog(dynamic message) {
  logger(Level.error).e(message);
}

void warningLog(dynamic message) {
  logger(Level.warning).w(message);
}

void infoLog(dynamic message) {
  logger(Level.info).w(message);
}
