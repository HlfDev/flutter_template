import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:core/core.dart';

class PostListRetry extends StatelessWidget {
  final VoidCallback onRetry;
  const PostListRetry({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: kSize124, color: AppColors.error),
          Text(context.l10n.failedToLoadPosts),
          TextButton(
            onPressed: onRetry,
            child: Text(context.l10n.retry),
          ),
        ],
      ),
    );
  }
}
