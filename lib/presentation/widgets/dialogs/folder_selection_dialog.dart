import 'package:flutter/material.dart';

/// 폴더 선택 다이얼로그
class FolderSelectionDialog extends StatefulWidget {
  const FolderSelectionDialog({super.key});

  @override
  State<FolderSelectionDialog> createState() => _FolderSelectionDialogState();
}

class _FolderSelectionDialogState extends State<FolderSelectionDialog> {
  String _selectedFolder = '모든 메모';
  final _folderNameController = TextEditingController();
  int _selectedColorIndex = 0;

  // 사용 가능한 색상들
  final List<Color> _availableColors = [
    const Color(0xFF6366F1), // Indigo
    const Color(0xFFA855F7), // Purple
    const Color(0xFFEC4899), // Pink
    const Color(0xFFF97316), // Orange
    const Color(0xFF84CC16), // Lime
    const Color(0xFF06B6D4), // Cyan
  ];

  @override
  void dispose() {
    _folderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 헤더: 제목 + 닫기 버튼
            Row(
              children: [
                Text(
                  '폴더 선택',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // 기본 폴더 옵션
            _buildFolderOption(
              folderName: '모든 메모',
              icon: Icons.inbox,
              isSelected: _selectedFolder == '모든 메모',
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            // 새 폴더 만들기 섹션
            Text(
              '새 폴더 만들기',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            // 폴더 이름 입력
            TextField(
              controller: _folderNameController,
              decoration: InputDecoration(
                hintText: '폴더 이름',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            // 색상 선택
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _availableColors.asMap().entries.map((entry) {
                final index = entry.key;
                final color = entry.value;
                final isSelected = _selectedColorIndex == index;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedColorIndex = index;
                    });
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 24,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            // 폴더 추가 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _createFolder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add),
                    const SizedBox(width: 8),
                    const Text('폴더 추가'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 폴더 옵션 위젯
  Widget _buildFolderOption({
    required String folderName,
    required IconData icon,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFolder = folderName;
        });
        Navigator.pop(context, folderName);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(width: 12),
            Text(
              folderName,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }

  /// 폴더 생성
  void _createFolder() {
    final folderName = _folderNameController.text.trim();
    if (folderName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('폴더 이름을 입력하세요')),
      );
      return;
    }

    // TODO: 실제 폴더 생성 로직 (Week 6에서 구현)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('폴더 "$folderName" 생성 기능은 Week 6에서 구현됩니다')),
    );

    // 임시로 폴더 이름을 반환
    Navigator.pop(context, folderName);
  }
}
