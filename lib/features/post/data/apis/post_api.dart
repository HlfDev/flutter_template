import 'dart:io';

import 'package:flutter_template/core/core.dart';
import 'package:flutter_template/features/post/post.dart';

class PostApi {
  final HttpClient _httpClient;

  PostApi({required HttpClient httpClient}) : _httpClient = httpClient;

  Future<Result<List<Post>>> getPostsList() async {
    try {
      final response = await _httpClient.get('/posts');

      if (response.statusCode != HttpStatus.ok) throw Exception();
      final list = response.data as List<dynamic>;

      final posts = list.map((post) => Post.fromJson(post)).toList();

      return Result.ok(posts);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }
}
