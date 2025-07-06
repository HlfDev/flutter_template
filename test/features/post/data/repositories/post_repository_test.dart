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
  });
}
