import 'package:flutter_template/features/post/post.dart';
import 'package:flutter_template/core/core.dart';

class PostListViewModel {
  final PostRepository _postRepository;

  PostListViewModel({required PostRepository postRepository})
      : _postRepository = postRepository;

  late final fetchPostList = Command1<List<Post>, String?>(_fetchPostList);
  late final createPost = Command1<Post, Post>(_createPost);
  late final updatePost = Command1<Post, Post>(_updatePost);
  late final deletePost = Command1<void, String>(_deletePost);

  Future<Result<List<Post>>> _fetchPostList([String? query]) async {
    final result = await _postRepository.getPostsList();

    return switch (result) {
      Ok<List<Post>>() => Result.ok(
          query != null && query.isNotEmpty
              ? result.value
                  .where((post) =>
                      post.title.toLowerCase().contains(query.toLowerCase()) ||
                      post.body.toLowerCase().contains(query.toLowerCase()))
                  .toList()
              : result.value,
        ),
      Error() => Result.error(result.error),
    };
  }

  Future<Result<Post>> _createPost(Post post) async {
    final result = await _postRepository.createPost(post);

    return switch (result) {
      Ok<Post>() => Result.ok(result.value),
      Error() => Result.error(result.error),
    };
  }

  Future<Result<Post>> _updatePost(Post post) async {
    final result = await _postRepository.updatePost(post);

    return switch (result) {
      Ok<Post>() => Result.ok(result.value),
      Error() => Result.error(result.error),
    };
  }

  Future<Result<void>> _deletePost(String id) async {
    final result = await _postRepository.deletePost(id);

    return switch (result) {
      Ok() => const Result.ok(null),
      Error() => Result.error(result.error),
    };
  }
}
