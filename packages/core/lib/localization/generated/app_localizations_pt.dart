// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get title => 'Publicação';

  @override
  String get searchPosts => 'Buscar publicações';

  @override
  String get createPost => 'Criar Publicação';

  @override
  String get updatePost => 'Atualizar Publicação';

  @override
  String get deletePost => 'Excluir Publicação';

  @override
  String get titleLabel => 'Título';

  @override
  String get bodyLabel => 'Corpo';

  @override
  String get titleRequired => 'Por favor insira um título';

  @override
  String get bodyRequired => 'Por favor insira um corpo';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get createButton => 'Criar';

  @override
  String get updateButton => 'Atualizar';

  @override
  String get deleteButton => 'Excluir';

  @override
  String get deletePostConfirmation =>
      'Tem certeza de que deseja excluir esta publicação?';

  @override
  String get postCreatedSuccess => 'Publicação criada com sucesso!';

  @override
  String postCreatedFailure(Object error) {
    return 'Falha ao criar a publicação: $error';
  }

  @override
  String get postUpdatedSuccess => 'Publicação atualizada com sucesso!';

  @override
  String postUpdatedFailure(Object error) {
    return 'Falha ao atualizar a publicação: $error';
  }

  @override
  String get postDeletedSuccess => 'Publicação excluída com sucesso!';

  @override
  String postDeletedFailure(Object error) {
    return 'Falha ao excluir a publicação: $error';
  }

  @override
  String get failedToLoadPosts => 'Failed to load posts';

  @override
  String get retry => 'Retry';
}
