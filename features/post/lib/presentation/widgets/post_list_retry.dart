import 'package:design_system/tokens/ds_colors.dart';
import 'package:design_system/tokens/ds_sizes.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/app_localizations.dart';

class PostListRetry extends StatelessWidget {
  final VoidCallback onRetry;
  const PostListRetry({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: DSSizes.sizeXXL, color: DSColors.error),
          Text(context.l10n.failedToLoadPosts),
          TextButton(onPressed: onRetry, child: Text(context.l10n.retry)),
        ],
      ),
    );
  }
}
