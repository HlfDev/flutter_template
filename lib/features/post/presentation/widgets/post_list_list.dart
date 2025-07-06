import 'package:flutter_template/features/post/post.dart';
import 'package:flutter_template/design_system/design_system.dart';
import 'package:flutter/material.dart';

class PostListList extends StatelessWidget {
  final List<Post> posts;
  const PostListList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for your post',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kBorderRadius24),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.lightGrey25,
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: kSize24)),
        SliverList.separated(
          itemCount: posts.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
          itemBuilder: (context, index) {
            final post = posts[index];
            return ListTile(
              onTap: () {},
              leading: Icon(Icons.bookmark, size: kSize32),
              title: Text(post.title),
              subtitle: Text(post.body),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: kSize24),
            );
          },
        ),
      ],
    );
  }
}
