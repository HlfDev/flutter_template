import 'package:flutter_template/core/helpers/result.dart';
import 'package:flutter_template/features/post/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostApi extends Mock implements PostApi {}

void main() {
  group('PostRepository', () {
    late PostRepository postRepository;
    late MockPostApi mockPostApi;

    setUp(() {
      mockPostApi = MockPostApi();
      postRepository = PostRepository(postApi: mockPostApi);
    });

    test('getPostsList returns a list of posts on success', () async {
      final mockPosts = [
        Post(id: '1', title: 'Test Post 1', body: 'Body 1'),
        Post(id: '2', title: 'Test Post 2', body: 'Body 2'),
      ];
      when(
        () => mockPostApi.getPostsList(),
      ).thenAnswer((_) async => Result.ok(mockPosts));

      final result = await postRepository.getPostsList();

      expect(result, isA<Ok<List<Post>>>());
      expect(result.value, mockPosts);
    });

    test('getPostsList returns an error on failure', () async {
      final error = Exception('Failed to fetch posts');
      when(
        () => mockPostApi.getPostsList(),
      ).thenAnswer((_) async => Result.error(error));

      final result = await postRepository.getPostsList();

      expect(result, isA<Error<List<Post>>>());
      expect(result.error, error);
    });

    test('createPost returns the created post on success', () async {
      final post = Post(id: '1', title: 'New Post', body: 'New Body');
      when(
        () => mockPostApi.createPost(post),
      ).thenAnswer((_) async => Result.ok(post));

      final result = await postRepository.createPost(post);

      expect(result, isA<Ok<Post>>());
      expect(result.value, post);
    });

    test('createPost returns an error on failure', () async {
      final post = Post(id: '1', title: 'New Post', body: 'New Body');
      final error = Exception('Failed to create post');
      when(
        () => mockPostApi.createPost(post),
      ).thenAnswer((_) async => Result.error(error));

      final result = await postRepository.createPost(post);

      expect(result, isA<Error<Post>>());
      expect(result.error, error);
    });

    test('updatePost returns the updated post on success', () async {
      final post = Post(id: '1', title: 'Updated Post', body: 'Updated Body');
      when(
        () => mockPostApi.updatePost(post),
      ).thenAnswer((_) async => Result.ok(post));

      final result = await postRepository.updatePost(post);

      expect(result, isA<Ok<Post>>());
      expect(result.value, post);
    });

    test('updatePost returns an error on failure', () async {
      final post = Post(id: '1', title: 'Updated Post', body: 'Updated Body');
      final error = Exception('Failed to update post');
      when(
        () => mockPostApi.updatePost(post),
      ).thenAnswer((_) async => Result.error(error));

      final result = await postRepository.updatePost(post);

      expect(result, isA<Error<Post>>());
      expect(result.error, error);
    });

    test('deletePost returns success', () async {
      when(
        () => mockPostApi.deletePost('1'),
      ).thenAnswer((_) async => const Result.ok(null));

      final result = await postRepository.deletePost('1');

      expect(result, isA<Ok<void>>());
    });

    test('deletePost returns an error on failure', () async {
      final error = Exception('Failed to delete post');
      when(
        () => mockPostApi.deletePost('1'),
      ).thenAnswer((_) async => Result.error(error));

      final result = await postRepository.deletePost('1');

      expect(result, isA<Error<void>>());
      expect(result.error, error);
    });
  });
}
