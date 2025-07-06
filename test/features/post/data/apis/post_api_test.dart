import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_template/features/post/post.dart';
import 'package:flutter_template/core/http/http_client.dart';
import 'package:flutter_template/core/helpers/result.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  group('PostApi', () {
    late PostApi postApi;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      postApi = PostApi(httpClient: mockHttpClient);
    });

    test('getPostsList returns a list of posts on success', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/posts'),
        statusCode: 200,
        data: [
          {'userId': 1, 'id': 1, 'title': 'Test Post 1', 'body': 'Body 1'},
          {'userId': 1, 'id': 2, 'title': 'Test Post 2', 'body': 'Body 2'},
        ],
      );

      when(
        () => mockHttpClient.get('/posts'),
      ).thenAnswer((_) async => mockResponse);

      final result = await postApi.getPostsList();

      expect(result, isA<Ok<List<Post>>>());
      expect(result.value, isA<List<Post>>());
      expect(result.value?.length, 2);
      expect(result.value?[0].title, 'Test Post 1');
    });

    test('getPostsList returns an error on failure', () async {
      when(
        () => mockHttpClient.get('/posts'),
      ).thenThrow(Exception('Network error'));

      final result = await postApi.getPostsList();

      expect(result, isA<Error<List<Post>>>());
      expect(result.error, isA<Exception>());
    });

    test('getPostsList returns an error on non-200 status code', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/posts'),
        statusCode: 404,
        data: {},
      );

      when(
        () => mockHttpClient.get('/posts'),
      ).thenAnswer((_) async => mockResponse);

      final result = await postApi.getPostsList();

      expect(result, isA<Error<List<Post>>>());
      expect(result.error, isA<Exception>());
    });
  });
}
