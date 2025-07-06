import 'package:flutter_template/design_system/design_system.dart';
import 'package:flutter/material.dart';

class PostListRetry extends StatelessWidget {
  final VoidCallback onRetry;
  const PostListRetry({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: kSize8,
        children: [
          Icon(Icons.error, size: kSize124, color: AppColors.error),
          Label.bodyLarge(text: 'Failed to load posts'),
          TextButton(
            onPressed: onRetry,
            child: const Label.bodyLarge(text: 'Retry'),
          ),
        ],
      ),
    );
  }
}
