import 'package:flutter/material.dart';

/// 앱 에러 위젯
/// 에러 상태를 표시하고 재시도 기능 제공
class AppErrorWidget extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback? onRetry;
  final IconData icon;
  final bool isFullScreen;

  const AppErrorWidget({
    super.key,
    required this.message,
    this.title,
    this.onRetry,
    this.icon = Icons.error_outline,
    this.isFullScreen = false,
  });

  /// 네트워크 에러용 생성자
  factory AppErrorWidget.network({
    String? message,
    VoidCallback? onRetry,
    bool isFullScreen = false,
  }) {
    return AppErrorWidget(
      message: message ?? '네트워크 연결을 확인해주세요',
      title: '연결 실패',
      icon: Icons.wifi_off,
      onRetry: onRetry,
      isFullScreen: isFullScreen,
    );
  }

  /// 데이터 로드 에러용 생성자
  factory AppErrorWidget.loadFailed({
    String? message,
    VoidCallback? onRetry,
    bool isFullScreen = false,
  }) {
    return AppErrorWidget(
      message: message ?? '데이터를 불러오지 못했습니다',
      title: '로드 실패',
      icon: Icons.error_outline,
      onRetry: onRetry,
      isFullScreen: isFullScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final content = Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          if (title != null) ...[
            Text(
              title!,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
          ],
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('다시 시도'),
            ),
          ],
        ],
      ),
    );

    if (isFullScreen) {
      return Scaffold(
        body: Center(child: content),
      );
    }

    return Center(child: content);
  }
}
