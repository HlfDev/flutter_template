import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required String id,
    required String title,
    required String body,
  }) = _Post;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}
