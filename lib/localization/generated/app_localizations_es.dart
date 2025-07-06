// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get title => 'Publicación';

  @override
  String get searchPosts => 'Buscar publicaciones';

  @override
  String get createPost => 'Crear Publicación';

  @override
  String get updatePost => 'Actualizar Publicación';

  @override
  String get deletePost => 'Eliminar Publicación';

  @override
  String get titleLabel => 'Título';

  @override
  String get bodyLabel => 'Cuerpo';

  @override
  String get titleRequired => 'Por favor ingresa un título';

  @override
  String get bodyRequired => 'Por favor ingresa un cuerpo';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get createButton => 'Crear';

  @override
  String get updateButton => 'Actualizar';

  @override
  String get deleteButton => 'Eliminar';

  @override
  String get deletePostConfirmation =>
      '¿Estás seguro de que quieres eliminar esta publicación?';

  @override
  String get postCreatedSuccess => '¡Publicación creada exitosamente!';

  @override
  String postCreatedFailure(Object error) {
    return 'Error al crear la publicación: $error';
  }

  @override
  String get postUpdatedSuccess => '¡Publicación actualizada exitosamente!';

  @override
  String postUpdatedFailure(Object error) {
    return 'Error al actualizar la publicación: $error';
  }

  @override
  String get postDeletedSuccess => '¡Publicación eliminada exitosamente!';

  @override
  String postDeletedFailure(Object error) {
    return 'Error al eliminar la publicación: $error';
  }
}
