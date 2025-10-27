import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_strings.dart';
import 'core/constants/app_themes.dart';

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
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,

      // Material Design 3 테마 적용
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,

      // 임시 홈 화면 (Phase 1 Week 3에서 실제 화면으로 교체)
      home: const SplashScreen(),
    );
  }
}

/// 임시 Splash Screen (Phase 1 Week 3에서 실제 구현)
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 앱 아이콘 자리 (나중에 추가)
            Icon(
              Icons.note_alt_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),

            // 앱 이름
            Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),

            // 앱 설명
            Text(
              AppStrings.appDescription,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
            ),
            const SizedBox(height: 48),

            // 로딩 인디케이터
            const CircularProgressIndicator(),
            const SizedBox(height: 16),

            // Phase 정보
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Phase 1: 기초 구축 완료 ✓',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
