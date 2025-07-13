import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:post/post.dart';
import 'package:localization/localization.dart';

class DeletePostModal extends StatelessWidget {
  const DeletePostModal({
    super.key,
    required this.postId,
    required this.postBloc,
  });

  final String postId;
  final PostBloc postBloc;

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
                    onPressed: () {
                      postBloc.add(DeletePost(postId));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(context.l10n.postDeletedSuccess),
                        ),
                      );
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
