import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:feature_post/feature_post.dart';
import 'package:core/core.dart';

class CreatePostModal extends StatefulWidget {
  const CreatePostModal({super.key, required this.postBloc});

  final PostBloc postBloc;

  @override
  State<CreatePostModal> createState() => _CreatePostModalState();
}

class _CreatePostModalState extends State<CreatePostModal> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: kPadding16,
            right: kPadding16,
            top: kPadding16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.createPost,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: kSize16),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: context.l10n.titleLabel,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.titleRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: kSize16),
                TextFormField(
                  controller: _bodyController,
                  decoration: InputDecoration(
                    labelText: context.l10n.bodyLabel,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.bodyRequired;
                    }
                    return null;
                  },
                ),
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
                        if (_formKey.currentState?.validate() ?? false) {
                          final newPost = Post(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            title: _titleController.text,
                            body: _bodyController.text,
                          );
                          widget.postBloc.add(CreatePost(newPost));
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(context.l10n.postCreatedSuccess),
                            ),
                          );
                        }
                      },
                      child: Text(context.l10n.createButton),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
