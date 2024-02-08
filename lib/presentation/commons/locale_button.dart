import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:smart_fit_test_signal/core/injection.dart';
import 'package:smart_fit_test_signal/helpers/app_colors.dart';
import 'package:smart_fit_test_signal/presentation/global_controllers/locale_controller.dart';

class LocaleButton extends StatefulWidget {
  const LocaleButton({
    super.key,
  });

  @override
  State<LocaleButton> createState() => _LocaleButtonState();
}

class _LocaleButtonState extends State<LocaleButton> {
  final LocaleController localeController = getIt.get<LocaleController>();

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      value: localeController.currentLocal.watch(context),
      focusColor: Colors.transparent,
      elevation: 0,
      dropdownColor: AppColors.darkGrey,
      icon: const SizedBox.shrink(),
      padding: const EdgeInsets.all(10),
      underline: const SizedBox.shrink(),
      items: AppLocalizations.supportedLocales
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.toString().toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          localeController.changeLocal(value);
        }
      },
    );
  }
}
