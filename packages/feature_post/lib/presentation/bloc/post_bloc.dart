import 'package:core/core.dart';
import 'package:feature_post/feature_post.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;

  PostBloc({required PostRepository postRepository})
    : _postRepository = postRepository,
      super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
    on<CreatePost>(_onCreatePost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final result = await _postRepository.getPostsList();

    switch (result) {
      case Ok<List<Post>>():
        if (result.value.isEmpty) emit(PostEmpty());
        if ((event.query ?? '').isNotEmpty) {
          final filteredPosts = result.value
              .where(
                (post) =>
                    post.title.toLowerCase().contains(
                      event.query!.toLowerCase(),
                    ) ||
                    post.body.toLowerCase().contains(
                      event.query!.toLowerCase(),
                    ),
              )
              .toList();

          if (filteredPosts.isEmpty) emit(PostEmpty());
          emit(PostLoaded(filteredPosts));
        } else {
          emit(PostLoaded(result.value));
        }
      case Error<List<Post>>():
        emit(PostError(result.error.toString()));
    }
  }

  Future<void> _onCreatePost(CreatePost event, Emitter<PostState> emit) async {
    final result = await _postRepository.createPost(event.post);

    switch (result) {
      case Ok<Post>():
        add(const FetchPosts());
      case Error<Post>():
        emit(PostError(result.error.toString()));
    }
  }

  Future<void> _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    final result = await _postRepository.updatePost(event.post);

    switch (result) {
      case Ok<Post>():
        add(const FetchPosts());
      case Error<Post>():
        emit(PostError(result.error.toString()));
    }
  }

  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    final result = await _postRepository.deletePost(event.id);

    switch (result) {
      case Ok<void>():
        add(const FetchPosts());
      case Error<void>():
        emit(PostError(result.error.toString()));
    }
  }
}
