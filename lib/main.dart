import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'core/constants/app_strings.dart';
import 'core/constants/app_themes.dart';
import 'presentation/router/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: WorkLifeMemoApp(),
    ),
  );
}

class WorkLifeMemoApp extends StatelessWidget {
  const WorkLifeMemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,

      // Material Design 3 테마 적용
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,

      // Flutter Quill Localization
      localizationsDelegates: FlutterQuillLocalizations.localizationsDelegates,
      supportedLocales: FlutterQuillLocalizations.supportedLocales,

      // go_router 설정
      routerConfig: appRouter,
    );
  }
}
