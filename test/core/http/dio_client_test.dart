import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_template/core/http/dio_client.dart';

class MockDio extends Mock implements Dio {}

class MockRequestOptions extends Mock implements RequestOptions {
  @override
  bool preserveHeaderCase = false;
}

void main() {
  group('DioHttpClient', () {
    late DioHttpClient dioHttpClient;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      dioHttpClient = DioHttpClient(baseUrl: 'http://test.com');
      // Manually inject the mock Dio instance
      dioHttpClient.dio = mockDio;
    });

    group('get', () {
      test('should return successful response for GET request', () async {
        final mockResponse = Response(
          requestOptions: MockRequestOptions(),
          statusCode: 200,
          data: {'key': 'value'},
        );
        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
            cancelToken: any(named: 'cancelToken'),
            onReceiveProgress: any(named: 'onReceiveProgress'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final response = await dioHttpClient.get('/test');

        expect(response.statusCode, 200);
        expect(response.data, {'key': 'value'});
      });

      test(
        'should throw DioException for GET request with error status',
        () async {
          when(
            () => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
              cancelToken: any(named: 'cancelToken'),
              onReceiveProgress: any(named: 'onReceiveProgress'),
            ),
          ).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: '/test'),
              response: Response(
                requestOptions: RequestOptions(path: '/test'),
                statusCode: 404,
              ),
            ),
          );

          expect(
            () => dioHttpClient.get('/test'),
            throwsA(isA<DioException>()),
          );
        },
      );

      test(
        'should throw DioException for network error on GET request',
        () async {
          when(
            () => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
              cancelToken: any(named: 'cancelToken'),
              onReceiveProgress: any(named: 'onReceiveProgress'),
            ),
          ).thenThrow(
            DioException(
              requestOptions: MockRequestOptions(),
              error: 'Network Error',
            ),
          );

          expect(
            () => dioHttpClient.get('/test'),
            throwsA(isA<DioException>()),
          );
        },
      );
    });

    group('post', () {
      test('should return successful response for POST request', () async {
        final mockResponse = Response(
          requestOptions: MockRequestOptions(),
          statusCode: 200,
          data: {'key': 'value'},
        );
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
            cancelToken: any(named: 'cancelToken'),
            onSendProgress: any(named: 'onSendProgress'),
            onReceiveProgress: any(named: 'onReceiveProgress'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final response = await dioHttpClient.post('/test', {'data': 'send'});

        expect(response.statusCode, 200);
        expect(response.data, {'key': 'value'});
      });

      test(
        'should throw DioException for POST request with error status',
        () async {
          when(
            () => mockDio.post(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
              cancelToken: any(named: 'cancelToken'),
              onSendProgress: any(named: 'onSendProgress'),
              onReceiveProgress: any(named: 'onReceiveProgress'),
            ),
          ).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: '/test'),
              response: Response(
                requestOptions: RequestOptions(path: '/test'),
                statusCode: 400,
              ),
            ),
          );

          expect(
            () => dioHttpClient.post('/test', {'data': 'send'}),
            throwsA(isA<DioException>()),
          );
        },
      );

      test(
        'should throw DioException for network error on POST request',
        () async {
          when(
            () => mockDio.post(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
              cancelToken: any(named: 'cancelToken'),
              onSendProgress: any(named: 'onSendProgress'),
              onReceiveProgress: any(named: 'onReceiveProgress'),
            ),
          ).thenThrow(
            DioException(
              requestOptions: MockRequestOptions(),
              error: 'Network Error',
            ),
          );

          expect(
            () => dioHttpClient.post('/test', {'data': 'send'}),
            throwsA(isA<DioException>()),
          );
        },
      );
    });

    group('put', () {
      test('should return successful response for PUT request', () async {
        final mockResponse = Response(
          requestOptions: MockRequestOptions(),
          statusCode: 200,
          data: {'key': 'value'},
        );
        when(
          () => mockDio.put(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
            cancelToken: any(named: 'cancelToken'),
            onSendProgress: any(named: 'onSendProgress'),
            onReceiveProgress: any(named: 'onReceiveProgress'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final response = await dioHttpClient.put('/test', {'data': 'update'});

        expect(response.statusCode, 200);
        expect(response.data, {'key': 'value'});
      });

      test(
        'should throw DioException for PUT request with error status',
        () async {
          when(
            () => mockDio.put(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
              cancelToken: any(named: 'cancelToken'),
              onSendProgress: any(named: 'onSendProgress'),
              onReceiveProgress: any(named: 'onReceiveProgress'),
            ),
          ).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: '/test'),
              response: Response(
                requestOptions: RequestOptions(path: '/test'),
                statusCode: 400,
              ),
            ),
          );

          expect(
            () => dioHttpClient.put('/test', {'data': 'update'}),
            throwsA(isA<DioException>()),
          );
        },
      );

      test(
        'should throw DioException for network error on PUT request',
        () async {
          when(
            () => mockDio.put(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
              cancelToken: any(named: 'cancelToken'),
              onSendProgress: any(named: 'onSendProgress'),
              onReceiveProgress: any(named: 'onReceiveProgress'),
            ),
          ).thenThrow(
            DioException(
              requestOptions: MockRequestOptions(),
              error: 'Network Error',
            ),
          );

          expect(
            () => dioHttpClient.put('/test', {'data': 'update'}),
            throwsA(isA<DioException>()),
          );
        },
      );
    });

    group('delete', () {
      test('should return successful response for DELETE request', () async {
        final mockResponse = Response(
          requestOptions: MockRequestOptions(),
          statusCode: 200,
          data: {'key': 'value'},
        );
        when(
          () => mockDio.delete(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final response = await dioHttpClient.delete('/test');

        expect(response.statusCode, 200);
        expect(response.data, {'key': 'value'});
      });

      test(
        'should throw DioException for DELETE request with error status',
        () async {
          when(
            () => mockDio.delete(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
              cancelToken: any(named: 'cancelToken'),
            ),
          ).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: '/test'),
              response: Response(
                requestOptions: RequestOptions(path: '/test'),
                statusCode: 400,
              ),
            ),
          );

          expect(
            () => dioHttpClient.delete('/test'),
            throwsA(isA<DioException>()),
          );
        },
      );

      test(
        'should throw DioException for network error on DELETE request',
        () async {
          when(
            () => mockDio.delete(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
              cancelToken: any(named: 'cancelToken'),
            ),
          ).thenThrow(
            DioException(
              requestOptions: MockRequestOptions(),
              error: 'Network Error',
            ),
          );

          expect(
            () => dioHttpClient.delete('/test'),
            throwsA(isA<DioException>()),
          );
        },
      );
    });
  });
}
