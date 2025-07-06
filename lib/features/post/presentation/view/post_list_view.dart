import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/core/core.dart';
import 'package:flutter_template/design_system/design_system.dart';
import 'package:flutter_template/features/post/post.dart';
import 'package:flutter_template/localization/localization.dart';

class PostListView extends StatefulWidget {
  const PostListView({super.key, required this.viewModel});

  final PostListViewModel viewModel;

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<bool> _showClearButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    widget.viewModel.fetchPostList.execute(null);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _showClearButton.value = _searchController.text.isNotEmpty;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1500), () {
      widget.viewModel.fetchPostList.execute(_searchController.text);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _showClearButton.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postList = widget.viewModel.fetchPostList;

    return Scaffold(
      appBar: AppBar(
        title: Label.titleLarge(text: context.l10n.title),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(kPadding8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: context.l10n.searchPosts,
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                ),
                suffixIcon: ValueListenableBuilder<bool>(
                  valueListenable: _showClearButton,
                  builder: (context, showClear, child) {
                    if (!showClear) return const SizedBox.shrink();
                    return IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        widget.viewModel.fetchPostList.execute(null);
                      },
                    );
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kBorderRadius24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
              ),
            ),
          ),
        ),
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
                return PostListList(
                  posts: posts,
                  onEdit: (post) => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => UpdatePostModal(
                      viewModel: widget.viewModel,
                      post: post,
                    ),
                  ),
                  onDelete: (id) => showModalBottomSheet(
                    context: context,
                    builder: (context) => DeletePostModal(
                      viewModel: widget.viewModel,
                      postId: id,
                    ),
                  ),
                );
              case CommandStatus.failure:
                return PostListRetry(
                  onRetry: () => widget.viewModel.fetchPostList.execute(null),
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => CreatePostModal(viewModel: widget.viewModel),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
