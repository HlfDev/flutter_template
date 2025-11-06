import 'package:core/core.dart';
import 'package:post/data/models/post.dart';
import 'package:post/data/sources/post_api.dart';

abstract class PostRepository {
  Future<Result<List<Post>>> getPostsList();
  Future<Result<Post>> createPost(Post post);
  Future<Result<Post>> updatePost(Post post);
  Future<Result<void>> deletePost(String id);
}

class PostRepositoryImpl implements PostRepository {
  final PostApi _postApi;

  PostRepositoryImpl({required PostApi postApi}) : _postApi = postApi;

  @override
  Future<Result<List<Post>>> getPostsList() async {
    return await _postApi.getPostsList();
  }

  @override
  Future<Result<Post>> createPost(Post post) async {
    return await _postApi.createPost(post);
  }

  @override
  Future<Result<Post>> updatePost(Post post) async {
    return await _postApi.updatePost(post);
  }

  @override
  Future<Result<void>> deletePost(String id) async {
    return await _postApi.deletePost(id);
  }
}
