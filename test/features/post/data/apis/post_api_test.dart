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
          {'id': '1', 'title': 'Test Post 1', 'body': 'Body 1'},
          {'id': '2', 'title': 'Test Post 2', 'body': 'Body 2'},
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

    test('createPost returns the created post on success', () async {
      final post = Post(id: '1', title: 'New Post', body: 'New Body');
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/posts'),
        statusCode: 201,
        data: post.toJson(),
      );

      when(
        () => mockHttpClient.post('/posts', post.toJson()),
      ).thenAnswer((_) async => mockResponse);

      final result = await postApi.createPost(post);

      expect(result, isA<Ok<Post>>());
      expect(result.value?.id, post.id);
      expect(result.value?.title, post.title);
      expect(result.value?.body, post.body);
    });

    test('createPost returns an error on failure', () async {
      final post = Post(id: '1', title: 'New Post', body: 'New Body');
      when(
        () => mockHttpClient.post('/posts', post.toJson()),
      ).thenThrow(Exception('Network error'));

      final result = await postApi.createPost(post);

      expect(result, isA<Error<Post>>());
      expect(result.error, isA<Exception>());
    });

    test('updatePost returns the updated post on success', () async {
      final post = Post(id: '1', title: 'Updated Post', body: 'Updated Body');
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/posts/1'),
        statusCode: 200,
        data: post.toJson(),
      );

      when(
        () => mockHttpClient.put('/posts/1', post.toJson()),
      ).thenAnswer((_) async => mockResponse);

      final result = await postApi.updatePost(post);

      expect(result, isA<Ok<Post>>());
      expect(result.value?.id, post.id);
      expect(result.value?.title, post.title);
      expect(result.value?.body, post.body);
    });

    test('updatePost returns an error on failure', () async {
      final post = Post(id: '1', title: 'Updated Post', body: 'Updated Body');
      when(
        () => mockHttpClient.put('/posts/1', post.toJson()),
      ).thenThrow(Exception('Network error'));

      final result = await postApi.updatePost(post);

      expect(result, isA<Error<Post>>());
      expect(result.error, isA<Exception>());
    });

    test('deletePost returns success on 200 status code', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/posts/1'),
        statusCode: 200,
      );

      when(
        () => mockHttpClient.delete('/posts/1'),
      ).thenAnswer((_) async => mockResponse);

      final result = await postApi.deletePost('1');

      expect(result, isA<Ok<void>>());
    });

    test('deletePost returns an error on failure', () async {
      when(
        () => mockHttpClient.delete('/posts/1'),
      ).thenThrow(Exception('Network error'));

      final result = await postApi.deletePost('1');

      expect(result, isA<Error<void>>());
      expect(result.error, isA<Exception>());
    });
  });
}