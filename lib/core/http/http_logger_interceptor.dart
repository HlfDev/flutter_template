import 'package:flutter_template/app/app_packages.dart';
import 'package:flutter_template/core/core.dart';

class HttpLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.d(
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
    AppLogger.d(
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
    AppLogger.e(
      'HTTP',
      'DIO Error: '
          '${err.requestOptions.method} '
          '${err.requestOptions.uri} '
          'Status: ${err.response?.statusCode}'
          '\nError: ${err.error}'
          '\nResponse Data: ${err.response?.data}',
      err,
      err.stackTrace,
    );
    super.onError(err, handler);
  }
}
