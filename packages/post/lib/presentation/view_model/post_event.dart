import 'package:equatable/equatable.dart';
import 'package:post/post.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class FetchPosts extends PostEvent {
  final String? query;

  const FetchPosts({this.query});
}

class CreatePost extends PostEvent {
  final Post post;

  const CreatePost(this.post);
}

class UpdatePost extends PostEvent {
  final Post post;

  const UpdatePost(this.post);
}

class DeletePost extends PostEvent {
  final String id;

  const DeletePost(this.id);
}
