import 'package:design_system/tokens/ds_sizes.dart';
import 'package:flutter/material.dart';
import 'package:post/data/models/post.dart';

class PostListList extends StatelessWidget {
  final List<Post> posts;
  final Function(Post) onEdit;
  final Function(String) onDelete;

  const PostListList({
    super.key,
    required this.posts,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.separated(
          itemCount: posts.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Theme.of(context).colorScheme.outlineVariant);
          },
          itemBuilder: (context, index) {
            final post = posts[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: DSSizes.spacingS),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DSSizes.radiusS),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(DSSizes.spacingM),
                onTap: () {},
                leading: Icon(
                  Icons.bookmark,
                  size: DSSizes.sizeXL,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  post.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  post.body,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: DSSizes.sizeL,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () => onEdit(post),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: DSSizes.sizeL,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      onPressed: () => onDelete(post.id),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
