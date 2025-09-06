part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostEmpty extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;

  const PostLoaded(this.posts);
}

class PostError extends PostState {
  final String message;

  const PostError(this.message);
}
