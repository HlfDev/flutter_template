import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:post/post.dart';
import 'package:localization/localization.dart';

class UpdatePostModal extends StatefulWidget {
  const UpdatePostModal({
    super.key,
    required this.post,
    required this.postBloc,
  });

  final Post post;
  final PostBloc postBloc;

  @override
  State<UpdatePostModal> createState() => _UpdatePostModalState();
}

class _UpdatePostModalState extends State<UpdatePostModal> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.title);
    _bodyController = TextEditingController(text: widget.post.body);
  }

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
                  context.l10n.updatePost,
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
                          final updatedPost = widget.post.copyWith(
                            title: _titleController.text,
                            body: _bodyController.text,
                          );
                          widget.postBloc.add(UpdatePost(updatedPost));
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(context.l10n.postUpdatedSuccess),
                            ),
                          );
                        }
                      },
                      child: Text(context.l10n.updateButton),
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
