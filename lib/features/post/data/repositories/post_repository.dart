import 'package:flutter_template/features/post/post.dart';
import 'package:flutter_template/core/core.dart';

class PostRepository {
  final PostApi _postApi;

  PostRepository({required PostApi postApi}) : _postApi = postApi;

  Future<Result<List<Post>>> getPostsList() async {
    return await _postApi.getPostsList();
  }
}
