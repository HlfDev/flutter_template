import 'package:flutter/material.dart';
import 'package:flutter_template/core/core.dart';
import 'package:flutter_template/design_system/design_system.dart';
import 'package:flutter_template/features/post/post.dart';
import 'package:flutter_template/localization/localization.dart';

class DeletePostModal extends StatelessWidget {
  const DeletePostModal({
    super.key,
    required this.viewModel,
    required this.postId,
  });

  final PostListViewModel viewModel;
  final String postId;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPadding16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.deletePost,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: kSize16),
              Text(context.l10n.deletePostConfirmation),
              const SizedBox(height: kSize16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(context.l10n.cancelButton),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await viewModel.deletePost.execute(postId);
                      if (!context.mounted) return;
                      if (viewModel.deletePost.status ==
                          CommandStatus.success) {
                        viewModel.fetchPostList.execute(null);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(context.l10n.postDeletedSuccess),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              context.l10n.postDeletedFailure(
                                viewModel.deletePost.exception.toString(),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(context.l10n.deleteButton),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
