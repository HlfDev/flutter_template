import 'dart:io';

import 'package:core/core.dart';
import 'package:post/post.dart';

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

  Future<Result<Post>> createPost(Post post) async {
    try {
      final response = await _httpClient.post('/posts', post.toJson());

      if (response.statusCode != HttpStatus.created) throw Exception();

      final createdPost = Post.fromJson(response.data);

      return Result.ok(createdPost);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  Future<Result<Post>> updatePost(Post post) async {
    try {
      final response = await _httpClient.put(
        '/posts/${post.id}',
        post.toJson(),
      );

      if (response.statusCode != HttpStatus.ok) throw Exception();

      final updatedPost = Post.fromJson(response.data);

      return Result.ok(updatedPost);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  Future<Result<void>> deletePost(String id) async {
    try {
      final response = await _httpClient.delete('/posts/$id');

      if (response.statusCode != HttpStatus.ok) throw Exception();

      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }
}
