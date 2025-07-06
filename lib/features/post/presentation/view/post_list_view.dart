import 'package:flutter/material.dart';
import 'package:flutter_template/core/core.dart';
import 'package:flutter_template/design_system/design_system.dart';
import 'package:flutter_template/features/post/post.dart';
import 'package:flutter_template/localization/localization.dart';

class PostListView extends StatelessWidget {
  final PostListViewModel viewModel;

  const PostListView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final postList = viewModel.fetchPostList;

    return Scaffold(
      appBar: AppBar(
        title: Label.titleLarge(text: context.l10n.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding16),
        child: ListenableBuilder(
          listenable: postList,
          builder: (context, _) {
            switch (postList.status) {
              case CommandStatus.initial:
                return const SizedBox.shrink();
              case CommandStatus.running:
                return const PostListShimmer();
              case CommandStatus.success:
                final List<Post> posts = postList.data ?? <Post>[];
                if (posts.isEmpty) return const PostListEmpty();
                return PostListList(posts: posts);
              case CommandStatus.failure:
                return PostListRetry(
                  onRetry: () => viewModel.fetchPostList.execute(),
                );
            }
          },
        ),
      ),
    );
  }
}
