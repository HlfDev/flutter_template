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
      when(
        () => mockPostRepository.getPostsList(),
      ).thenAnswer((_) async => Result.ok([])); // Default successful response
      viewModel = PostListViewModel(postRepository: mockPostRepository);
    });

    test('fetchPostList populates posts on success', () async {
      final mockPosts = [
        Post(id: '1', title: 'Test Post 1', body: 'Body 1'),
        Post(id: '2', title: 'Test Post 2', body: 'Body 2'),
      ];
      when(
        () => mockPostRepository.getPostsList(),
      ).thenAnswer((_) async => Result.ok(mockPosts));

      await viewModel.fetchPostList.execute();
      await Future.microtask(() {}); // Allow state to update

      expect(viewModel.fetchPostList.status, CommandStatus.success);
      expect(viewModel.fetchPostList.data, mockPosts);
      expect(viewModel.fetchPostList.exception, isNull);
    });

    test('fetchPostList sets error on failure', () async {
      final error = Exception('Failed to fetch posts');
      when(
        () => mockPostRepository.getPostsList(),
      ).thenAnswer((_) async => Result.error(error));

      await viewModel.fetchPostList.execute();
      await Future.microtask(() {}); // Allow state to update

      expect(viewModel.fetchPostList.status, CommandStatus.failure);
      expect(viewModel.fetchPostList.data, isNull);
      expect(viewModel.fetchPostList.exception, error);
    });

    test('clear resets the command state', () async {
      final mockPosts = [Post(id: '1', title: 'Test Post 1', body: 'Body 1')];
      when(
        () => mockPostRepository.getPostsList(),
      ).thenAnswer((_) async => Result.ok(mockPosts));

      await viewModel.fetchPostList.execute();
      await Future.microtask(() {});
      expect(viewModel.fetchPostList.status, CommandStatus.success);

      viewModel.fetchPostList.clear();

      expect(viewModel.fetchPostList.status, CommandStatus.initial);
      expect(viewModel.fetchPostList.data, isNull);
      expect(viewModel.fetchPostList.exception, isNull);
    });
  });
}
