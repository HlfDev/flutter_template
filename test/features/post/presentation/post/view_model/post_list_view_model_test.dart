import 'package:flutter_template/core/helpers/command.dart';
import 'package:flutter_template/core/helpers/result.dart';
import 'package:flutter_template/features/post/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  group('PostListViewModel', () {
    late PostListViewModel viewModel;
    late MockPostRepository mockPostRepository;

    setUp(() {
      mockPostRepository = MockPostRepository();
    });

    test('fetchPostList populates posts on success', () async {
      final mockPosts = [
        Post(id: '1', title: 'Test Post 1', body: 'Body 1'),
        Post(id: '2', title: 'Test Post 2', body: 'Body 2'),
      ];
      when(
        () => mockPostRepository.getPostsList(),
      ).thenAnswer((_) async => Result.ok(mockPosts));

      viewModel = PostListViewModel(postRepository: mockPostRepository);
      await viewModel.fetchPostList.execute(null);
      await Future.microtask(() {}); // Allow state to update

      expect(viewModel.fetchPostList.status, CommandStatus.success);
      expect(viewModel.fetchPostList.data, mockPosts);
      expect(viewModel.fetchPostList.exception, isNull);
    });

    test('fetchPostList filters posts by title', () async {
      final mockPosts = [
        Post(id: '1', title: 'Apple', body: 'Fruit'),
        Post(id: '2', title: 'Banana', body: 'Fruit'),
        Post(id: '3', title: 'Carrot', body: 'Vegetable'),
      ];
      when(() => mockPostRepository.getPostsList())
          .thenAnswer((_) async => Result.ok(mockPosts));

      viewModel = PostListViewModel(postRepository: mockPostRepository);
      await viewModel.fetchPostList.execute('apple');
      await Future.microtask(() {});

      expect(viewModel.fetchPostList.status, CommandStatus.success);
      expect(viewModel.fetchPostList.data?.length, 1);
      expect(viewModel.fetchPostList.data?.first.title, 'Apple');
    });

    test('fetchPostList filters posts by body', () async {
      final mockPosts = [
        Post(id: '1', title: 'Apple', body: 'Red fruit'),
        Post(id: '2', title: 'Banana', body: 'Yellow fruit'),
        Post(id: '3', title: 'Carrot', body: 'Orange vegetable'),
      ];
      when(() => mockPostRepository.getPostsList())
          .thenAnswer((_) async => Result.ok(mockPosts));

      viewModel = PostListViewModel(postRepository: mockPostRepository);
      await viewModel.fetchPostList.execute('yellow');
      await Future.microtask(() {});

      expect(viewModel.fetchPostList.status, CommandStatus.success);
      expect(viewModel.fetchPostList.data?.length, 1);
      expect(viewModel.fetchPostList.data?.first.title, 'Banana');
    });

    test('fetchPostList returns empty list if no match', () async {
      final mockPosts = [
        Post(id: '1', title: 'Apple', body: 'Fruit'),
      ];
      when(() => mockPostRepository.getPostsList())
          .thenAnswer((_) async => Result.ok(mockPosts));

      viewModel = PostListViewModel(postRepository: mockPostRepository);
      await viewModel.fetchPostList.execute('xyz');
      await Future.microtask(() {});

      expect(viewModel.fetchPostList.status, CommandStatus.success);
      expect(viewModel.fetchPostList.data, isEmpty);
    });

    test('fetchPostList sets error on failure', () async {
      final error = Exception('Failed to fetch posts');
      when(() => mockPostRepository.getPostsList())
          .thenAnswer((_) async => Result.error(error));

      viewModel = PostListViewModel(postRepository: mockPostRepository);
      await viewModel.fetchPostList.execute(null);
      await Future.microtask(() {});

      expect(viewModel.fetchPostList.status, CommandStatus.failure);
      expect(viewModel.fetchPostList.exception, error);
    });

    test('clear resets the command state', () async {
      final mockPosts = [Post(id: '1', title: 'Test Post 1', body: 'Body 1')];
      when(
        () => mockPostRepository.getPostsList(),
      ).thenAnswer((_) async => Result.ok(mockPosts));

      viewModel = PostListViewModel(postRepository: mockPostRepository);
      await viewModel.fetchPostList.execute(null);
      await Future.microtask(() {});
      expect(viewModel.fetchPostList.status, CommandStatus.success);

      viewModel.fetchPostList.clear();

      expect(viewModel.fetchPostList.status, CommandStatus.initial);
      expect(viewModel.fetchPostList.data, isNull);
      expect(viewModel.fetchPostList.exception, isNull);
    });

    test('createPost succeeds', () async {
      final post = Post(id: '1', title: 'New Post', body: 'New Body');
      when(
        () => mockPostRepository.createPost(post),
      ).thenAnswer((_) async => Result.ok(post));

      viewModel = PostListViewModel(postRepository: mockPostRepository);
      await viewModel.createPost.execute(post);
      await Future.microtask(() {});

      expect(viewModel.createPost.status, CommandStatus.success);
    });

    test('createPost fails', () async {
      final post = Post(id: '1', title: 'New Post', body: 'New Body');
      final error = Exception('Failed to create post');
      when(
        () => mockPostRepository.createPost(post),
      ).thenAnswer((_) async => Result.error(error));

      viewModel = PostListViewModel(postRepository: mockPostRepository);
      await viewModel.createPost.execute(post);
      await Future.microtask(() {});

      expect(viewModel.createPost.status, CommandStatus.failure);
      expect(viewModel.createPost.exception, error);
    });

    test('updatePost succeeds', () async {
      final post = Post(id: '1', title: 'Updated Post', body: 'Updated Body');
      when(
        () => mockPostRepository.updatePost(post),
      ).thenAnswer((_) async => Result.ok(post));

      viewModel = PostListViewModel(postRepository: mockPostRepository);
      await viewModel.updatePost.execute(post);
      await Future.microtask(() {});

      expect(viewModel.updatePost.status, CommandStatus.success);
    });

    test('updatePost fails', () async {
      final post = Post(id: '1', title: 'Updated Post', body: 'Updated Body');
      final error = Exception('Failed to update post');
      when(
        () => mockPostRepository.updatePost(post),
      ).thenAnswer((_) async => Result.error(error));

      viewModel = PostListViewModel(postRepository: mockPostRepository);
      await viewModel.updatePost.execute(post);
      await Future.microtask(() {});

      expect(viewModel.updatePost.status, CommandStatus.failure);
      expect(viewModel.updatePost.exception, error);
    });

    test('deletePost succeeds', () async {
      when(
        () => mockPostRepository.deletePost('1'),
      ).thenAnswer((_) async => const Result.ok(null));

      viewModel = PostListViewModel(postRepository: mockPostRepository);
      await viewModel.deletePost.execute('1');
      await Future.microtask(() {});

      expect(viewModel.deletePost.status, CommandStatus.success);
    });

    test('deletePost fails', () async {
      final error = Exception('Failed to delete post');
      when(
        () => mockPostRepository.deletePost('1'),
      ).thenAnswer((_) async => Result.error(error));

      viewModel = PostListViewModel(postRepository: mockPostRepository);
      await viewModel.deletePost.execute('1');
      await Future.microtask(() {});

      expect(viewModel.deletePost.status, CommandStatus.failure);
      expect(viewModel.deletePost.exception, error);
    });
  });
}
