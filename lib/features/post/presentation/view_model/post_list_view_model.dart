import 'package:flutter_template/features/post/post.dart';
import 'package:flutter_template/core/core.dart';

class PostListViewModel {
  final PostRepository _postRepository;

  PostListViewModel({required PostRepository postRepository})
    : _postRepository = postRepository {
    fetchPostList.execute();
  }

  late final fetchPostList = Command0(_fetchPostList);

  Future<Result<List<Post>>> _fetchPostList() async {
    final result = await _postRepository.getPostsList();

    return switch (result) {
      Ok<List<Post>>() => Result.ok(result.value),
      Error() => Result.error(result.error),
    };
  }
}
