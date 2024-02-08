import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:smart_fit_test_signal/core/injection.dart';
import 'package:smart_fit_test_signal/helpers/app_colors.dart';
import 'package:smart_fit_test_signal/presentation/global_controllers/locale_controller.dart';
import 'package:smart_fit_test_signal/presentation/search_unity/screen/search_unity_screen.dart';

void main() {
  configureDependencies(); //Initialize dependency injection
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final LocaleController localeController = getIt.get<LocaleController>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Gotham',
        primaryColor: AppColors.yellow,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: AppColors.darkGrey,
          ),
          headlineLarge: TextStyle(
            fontSize: 22,
            color: AppColors.lightGrey.withOpacity(0.7),
            fontWeight: FontWeight.w300,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w100,
            color: AppColors.darkGrey,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: AppColors.lightGrey,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: AppColors.lightGrey,
          ),
          displayMedium: TextStyle(
            fontSize: 16,
            color: AppColors.darkGrey,
            fontWeight: FontWeight.w800,
          ),
          displayLarge: TextStyle(
            fontSize: 20,
            color: AppColors.darkGrey,
            fontWeight: FontWeight.w900,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            foregroundColor: AppColors.darkGrey,
            backgroundColor: AppColors.yellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            minimumSize: const Size(250, 45),
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.darkGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            minimumSize: const Size(250, 45),
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.yellow,
        ),
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.trackpad,
        },
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: localeController.currentLocal.watch(context),
      home: const SearchUnityScreen(),
    );
  }
}
