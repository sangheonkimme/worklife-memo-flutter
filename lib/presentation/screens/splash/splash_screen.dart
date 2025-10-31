import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/common/app_loading_indicator.dart';

/// Splash Screen
/// 앱 초기화 및 데이터베이스 설정
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      // Drift 데이터베이스는 lazy initialization을 사용하므로 별도 초기화 불필요

      // 최소 로딩 시간 (스플래시 화면이 너무 빨리 사라지지 않도록)
      await Future.delayed(const Duration(milliseconds: 1500));

      // 홈 화면으로 이동
      if (mounted) {
        context.go('/notes');
      }
    } catch (e) {
      // 에러 발생 시 에러 표시 (추후 에러 핸들링 개선)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('초기화 실패: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 앱 로고/아이콘
            Icon(
              Icons.note_alt,
              size: 100,
              color: theme.colorScheme.onPrimary,
            ),
            const SizedBox(height: 24),
            // 앱 이름
            Text(
              'WorkLife Memo',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // 부제목
            Text(
              '업무와 일상을 기록하는 스마트한 방법',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 48),
            // 로딩 인디케이터
            AppLoadingIndicator(
              color: theme.colorScheme.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
