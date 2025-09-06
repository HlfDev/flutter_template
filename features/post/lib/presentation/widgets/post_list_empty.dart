import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class PostListEmpty extends StatelessWidget {
  const PostListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.book, size: DSSizes.sizeXXL, color: DSColors.info),
          Text('No posts found'),
        ],
      ),
    );
  }
}
