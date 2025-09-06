import 'package:design_system/tokens/ds_sizes.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/app_localizations.dart';
import 'package:post/presentation/view_model/post_bloc.dart';

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
          padding: const EdgeInsets.all(DSSizes.spacingM),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.deletePost,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: DSSizes.sizeM),
              Text(context.l10n.deletePostConfirmation),
              const SizedBox(height: DSSizes.sizeM),
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
