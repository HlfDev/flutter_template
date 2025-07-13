import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_template/core/core.dart';
import 'package:flutter_template/features/post/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostRepository extends Mock implements PostRepository {}

class FakePost extends Fake implements Post {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakePost());
  });
  group('PostBloc', () {
    late PostRepository postRepository;
    late PostBloc postBloc;

    setUp(() {
      postRepository = MockPostRepository();
      postBloc = PostBloc(postRepository: postRepository);
    });

    test('initial state is PostInitial', () {
      expect(postBloc.state, PostInitial());
    });

    blocTest<PostBloc, PostState>(
      'emits [PostLoading, PostLoaded] when FetchPosts is added',
      build: () {
        when(() => postRepository.getPostsList()).thenAnswer(
          (_) async => const Result.ok([]),
        );
        return postBloc;
      },
      act: (bloc) => bloc.add(const FetchPosts()),
      expect: () => <PostState>[
        PostLoading(),
        const PostLoaded([]),
      ],
    );

    blocTest<PostBloc, PostState>(
      'emits [PostLoading, PostError] when FetchPosts fails',
      build: () {
        when(() => postRepository.getPostsList()).thenAnswer(
          (_) async => Result.error(Exception('error')),
        );
        return postBloc;
      },
      act: (bloc) => bloc.add(const FetchPosts()),
      expect: () => <PostState>[
        PostLoading(),
        const PostError('Exception: error'),
      ],
    );

    blocTest<PostBloc, PostState>(
      'emits [PostLoading, PostLoaded] when CreatePost is added',
      build: () {
        when(() => postRepository.createPost(any())).thenAnswer(
          (_) async => const Result.ok(Post(id: '1', title: 'title', body: 'body')),
        );
        when(() => postRepository.getPostsList()).thenAnswer(
          (_) async => const Result.ok([]),
        );
        return postBloc;
      },
      act: (bloc) => bloc.add(const CreatePost(Post(id: '1', title: 'title', body: 'body'))),
      expect: () => <PostState>[
        PostLoading(),
        const PostLoaded([]),
      ],
    );

    blocTest<PostBloc, PostState>(
      'emits [PostError] when CreatePost fails',
      build: () {
        when(() => postRepository.createPost(any())).thenAnswer(
          (_) async => Result.error(Exception('error')),
        );
        return postBloc;
      },
      act: (bloc) => bloc.add(const CreatePost(Post(id: '1', title: 'title', body: 'body'))),
      expect: () => <PostState>[
        const PostError('Exception: error'),
      ],
    );

    blocTest<PostBloc, PostState>(
      'emits [PostLoading, PostLoaded] when UpdatePost is added',
      build: () {
        when(() => postRepository.updatePost(any())).thenAnswer(
          (_) async => const Result.ok(Post(id: '1', title: 'title', body: 'body')),
        );
        when(() => postRepository.getPostsList()).thenAnswer(
          (_) async => const Result.ok([]),
        );
        return postBloc;
      },
      act: (bloc) => bloc.add(const UpdatePost(Post(id: '1', title: 'title', body: 'body'))),
      expect: () => <PostState>[
        PostLoading(),
        const PostLoaded([]),
      ],
    );

    blocTest<PostBloc, PostState>(
      'emits [PostError] when UpdatePost fails',
      build: () {
        when(() => postRepository.updatePost(any())).thenAnswer(
          (_) async => Result.error(Exception('error')),
        );
        return postBloc;
      },
      act: (bloc) => bloc.add(const UpdatePost(Post(id: '1', title: 'title', body: 'body'))),
      expect: () => <PostState>[
        const PostError('Exception: error'),
      ],
    );

    blocTest<PostBloc, PostState>(
      'emits [PostLoading, PostLoaded] when DeletePost is added',
      build: () {
        when(() => postRepository.deletePost(any())).thenAnswer(
          (_) async => const Result.ok(null),
        );
        when(() => postRepository.getPostsList()).thenAnswer(
          (_) async => const Result.ok([]),
        );
        return postBloc;
      },
      act: (bloc) => bloc.add(const DeletePost('1')),
      expect: () => <PostState>[
        PostLoading(),
        const PostLoaded([]),
      ],
    );

    blocTest<PostBloc, PostState>(
      'emits [PostError] when DeletePost fails',
      build: () {
        when(() => postRepository.deletePost(any())).thenAnswer(
          (_) async => Result.error(Exception('error')),
        );
        return postBloc;
      },
      act: (bloc) => bloc.add(const DeletePost('1')),
      expect: () => <PostState>[
        const PostError('Exception: error'),
      ],
    );
  });
}
