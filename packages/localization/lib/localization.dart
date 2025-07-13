import 'package:flutter/material.dart';

import 'package:localization/generated/app_localizations.dart';
export 'generated/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}