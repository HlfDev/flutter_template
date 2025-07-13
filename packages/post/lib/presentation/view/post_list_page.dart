import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:post/post.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (_) => GetIt.I.get<PostBloc>()..add(const FetchPosts()),
      child: const PostListView(),
    );
  }
}
