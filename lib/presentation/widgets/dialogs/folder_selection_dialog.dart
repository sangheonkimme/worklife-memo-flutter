import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/folder.dart';
import '../../providers/folder_provider.dart';

/// 폴더 선택 다이얼로그
class FolderSelectionDialog extends ConsumerStatefulWidget {
  /// 현재 선택된 폴더 ID (nullable)
  final String? selectedFolderId;

  const FolderSelectionDialog({
    super.key,
    this.selectedFolderId,
  });

  @override
  ConsumerState<FolderSelectionDialog> createState() => _FolderSelectionDialogState();
}

class _FolderSelectionDialogState extends ConsumerState<FolderSelectionDialog> {
  String? _selectedFolderId;
  final _folderNameController = TextEditingController();
  int _selectedColorIndex = 0;
  bool _isCreating = false;

  @override
  void initState() {
    super.initState();
    _selectedFolderId = widget.selectedFolderId;
  }

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
    final foldersAsync = ref.watch(folderListProvider);

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
            // 기본 폴더 옵션 (모든 메모)
            _buildFolderOption(
              folder: null,
              folderName: '모든 메모',
              icon: Icons.inbox,
              isSelected: _selectedFolderId == null,
            ),
            const SizedBox(height: 16),
            // 폴더 목록
            Expanded(
              child: foldersAsync.when(
                data: (folders) {
                  if (folders.isEmpty) {
                    return const Center(
                      child: Text('폴더가 없습니다'),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: folders.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final folder = folders[index];
                      return _buildFolderOption(
                        folder: folder,
                        folderName: folder.name,
                        icon: Icons.folder,
                        isSelected: _selectedFolderId == folder.id,
                        color: folder.color != null
                            ? Color(int.parse(folder.color!, radix: 16))
                            : null,
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('오류: $error')),
              ),
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
    required Folder? folder,
    required String folderName,
    required IconData icon,
    required bool isSelected,
    Color? color,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFolderId = folder?.id;
        });
        Navigator.pop(context, folder);
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
  Future<void> _createFolder() async {
    final folderName = _folderNameController.text.trim();
    if (folderName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('폴더 이름을 입력하세요')),
      );
      return;
    }

    setState(() {
      _isCreating = true;
    });

    try {
      // 선택된 색상을 HEX 문자열로 변환
      final selectedColor = _availableColors[_selectedColorIndex];
      final colorHex = selectedColor.toARGB32().toRadixString(16).padLeft(8, '0');

      // 폴더 생성
      final folder = FolderX.create(
        name: folderName,
        color: colorHex,
      );

      await ref.read(folderListProvider.notifier).createFolder(folder);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('폴더 "$folderName"이(가) 생성되었습니다')),
        );

        // 생성된 폴더로 선택하고 다이얼로그 닫기
        // 폴더 목록을 다시 불러온 후 방금 생성된 폴더를 찾아서 반환
        final folders = await ref.refresh(folderListProvider.future);
        final createdFolder = folders.firstWhere(
          (f) => f.name == folderName,
          orElse: () => folders.last,
        );

        if (mounted) {
          Navigator.pop(context, createdFolder);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('폴더 생성 실패: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCreating = false;
        });
      }
    }
  }
}
