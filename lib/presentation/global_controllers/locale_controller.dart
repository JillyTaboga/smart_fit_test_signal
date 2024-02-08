import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:signals_flutter/signals_flutter.dart';

@singleton
class LocaleController {
  final currentLocal = signal(AppLocalizations.supportedLocales.last);
  changeLocal(Locale newLocal) {
    currentLocal.set(newLocal);
  }
}
