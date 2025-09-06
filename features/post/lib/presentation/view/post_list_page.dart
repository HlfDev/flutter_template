import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:post/presentation/view/post_list_view.dart';
import 'package:post/presentation/view_model/post_bloc.dart';

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
