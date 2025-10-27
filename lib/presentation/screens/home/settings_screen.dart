import 'package:flutter/material.dart';

/// Settings Screen
/// 설정 화면
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: ListView(
        children: [
          // 앱 정보
          _SettingsSection(
            title: '앱 정보',
            children: [
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.primary,
                ),
                title: const Text('버전'),
                subtitle: const Text('1.0.0'),
              ),
              ListTile(
                leading: Icon(
                  Icons.description_outlined,
                  color: theme.colorScheme.primary,
                ),
                title: const Text('라이선스'),
                onTap: () {
                  // TODO: 라이선스 화면
                },
              ),
            ],
          ),
          // 외관
          _SettingsSection(
            title: '외관',
            children: [
              ListTile(
                leading: Icon(
                  Icons.palette_outlined,
                  color: theme.colorScheme.primary,
                ),
                title: const Text('테마'),
                subtitle: const Text('시스템 설정 따르기'),
                onTap: () {
                  // TODO: 테마 설정 (Phase 4)
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.text_fields,
                  color: theme.colorScheme.primary,
                ),
                title: const Text('폰트 크기'),
                subtitle: const Text('중간'),
                onTap: () {
                  // TODO: 폰트 크기 설정 (Phase 4)
                },
              ),
            ],
          ),
          // 데이터
          _SettingsSection(
            title: '데이터',
            children: [
              ListTile(
                leading: Icon(
                  Icons.backup_outlined,
                  color: theme.colorScheme.primary,
                ),
                title: const Text('백업 및 복원'),
                onTap: () {
                  // TODO: 백업 기능 (추후 구현)
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.storage_outlined,
                  color: theme.colorScheme.primary,
                ),
                title: const Text('저장소 관리'),
                onTap: () {
                  // TODO: 저장소 관리 (추후 구현)
                },
              ),
            ],
          ),
          // 고급
          _SettingsSection(
            title: '고급',
            children: [
              ListTile(
                leading: Icon(
                  Icons.delete_sweep_outlined,
                  color: theme.colorScheme.error,
                ),
                title: Text(
                  '모든 데이터 삭제',
                  style: TextStyle(color: theme.colorScheme.error),
                ),
                onTap: () {
                  // TODO: 데이터 삭제 확인 다이얼로그
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 설정 섹션
class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}
