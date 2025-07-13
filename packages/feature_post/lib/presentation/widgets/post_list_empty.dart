import 'package:flutter/material.dart';

class PostListEmpty extends StatelessWidget {
  const PostListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No posts found'));
  }
}
