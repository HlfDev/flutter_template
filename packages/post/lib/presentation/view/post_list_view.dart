import 'dart:async';

import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:post/post.dart';

class PostListView extends StatefulWidget {
  const PostListView({super.key});

  @override
  State<PostListView> createState() => PostListViewState();
}

class PostListViewState extends State<PostListView> {
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<bool> _showClearButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _showClearButton.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _showClearButton.value = _searchController.text.isNotEmpty;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1500), () {
      context.read<PostBloc>().add(FetchPosts(query: _searchController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DSLabel.titleLarge(text: context.l10n.title),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(DSSizes.spacingS),
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
                        context.read<PostBloc>().add(const FetchPosts());
                      },
                    );
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DSSizes.radiusXL),
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
        padding: const EdgeInsets.all(DSSizes.spacingM),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            return switch (state) {
              PostInitial() => const SizedBox.shrink(),
              PostLoading() => const PostListShimmer(),
              PostEmpty() => const PostListEmpty(),
              PostLoaded() => PostListList(
                posts: state.posts,
                onEdit: (post) => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (modalContext) => UpdatePostModal(
                    post: post,
                    postBloc: context.read<PostBloc>(),
                  ),
                ),
                onDelete: (id) => showModalBottomSheet(
                  context: context,
                  builder: (modalContext) => DeletePostModal(
                    postId: id,
                    postBloc: context.read<PostBloc>(),
                  ),
                ),
              ),
              PostError() => PostListRetry(
                onRetry: () => context.read<PostBloc>().add(const FetchPosts()),
              ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (modalContext) =>
              CreatePostModal(postBloc: context.read<PostBloc>()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
