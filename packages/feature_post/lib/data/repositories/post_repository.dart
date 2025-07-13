import 'package:core/core.dart';
import 'package:feature_post/feature_post.dart';

class PostRepository {
  final PostApi _postApi;

  PostRepository({required PostApi postApi}) : _postApi = postApi;

  Future<Result<List<Post>>> getPostsList() async {
    return await _postApi.getPostsList();
  }

  Future<Result<Post>> createPost(Post post) async {
    return await _postApi.createPost(post);
  }

  Future<Result<Post>> updatePost(Post post) async {
    return await _postApi.updatePost(post);
  }

  Future<Result<void>> deletePost(String id) async {
    return await _postApi.deletePost(id);
  }
}
