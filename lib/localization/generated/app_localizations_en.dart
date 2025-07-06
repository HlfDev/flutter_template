// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Posts';

  @override
  String get searchPosts => 'Search posts';

  @override
  String get createPost => 'Create Post';

  @override
  String get updatePost => 'Update Post';

  @override
  String get deletePost => 'Delete Post';

  @override
  String get titleLabel => 'Title';

  @override
  String get bodyLabel => 'Body';

  @override
  String get titleRequired => 'Please enter a title';

  @override
  String get bodyRequired => 'Please enter a body';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get createButton => 'Create';

  @override
  String get updateButton => 'Update';

  @override
  String get deleteButton => 'Delete';

  @override
  String get deletePostConfirmation =>
      'Are you sure you want to delete this post?';

  @override
  String get postCreatedSuccess => 'Post created successfully!';

  @override
  String postCreatedFailure(Object error) {
    return 'Failed to create post: $error';
  }

  @override
  String get postUpdatedSuccess => 'Post updated successfully!';

  @override
  String postUpdatedFailure(Object error) {
    return 'Failed to update post: $error';
  }

  @override
  String get postDeletedSuccess => 'Post deleted successfully!';

  @override
  String postDeletedFailure(Object error) {
    return 'Failed to delete post: $error';
  }
}
