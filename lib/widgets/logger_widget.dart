import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 75,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request => $requestPath');
    logger.d('Error: ${err.error}, Message: ${err.message}');
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request => $requestPath');

    if (options.data is FormData) {
      final formData = options.data as FormData;
      for (final entry in formData.fields) {
        logger.d('Form field: ${entry.key} = ${entry.value}');
      }
    }
    logger.d('data request data',error : options.data);

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('StatusCode: ${response.statusCode}, Data: ${response.data}');
    return super.onResponse(response, handler);
  }
}

