import 'package:core/core.dart';

class DioLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.debug(
      'HTTP',
      'DIO Request: '
          '${options.method} '
          '${options.uri}'
          '\nHeaders: ${options.headers}'
          '\nData: ${options.data}',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.debug(
      'HTTP',
      'DIO Response: '
          '${response.requestOptions.method} '
          '${response.requestOptions.uri} '
          'Status: ${response.statusCode}'
          '\nData: ${response.data}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error(
      'HTTP',
      'DIO Error: '
          '${err.requestOptions.method} '
          '${err.requestOptions.uri} '
          'Status: ${err.response?.statusCode}'
          '\nError: ${err.error}'
          '\nResponse Data: ${err.response?.data}',
      error: err,
      stackTrace: err.stackTrace,
    );
    super.onError(err, handler);
  }
}
