import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:post/presentation/view/post_list_view.dart';
import 'package:post/presentation/view_model/post_bloc.dart';

class PostListPage extends StatefulWidget {
  static const path = '/post_list';

  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  late final PostBloc _viewModel;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = GetIt.I<PostBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return PostListView(viewModel: _viewModel);
  }
}
