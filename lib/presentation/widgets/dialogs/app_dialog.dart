import 'package:flutter/material.dart';

/// 앱 다이얼로그
/// 재사용 가능한 다이얼로그 컴포넌트
class AppDialog extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? content;
  final List<AppDialogAction> actions;
  final IconData? icon;

  const AppDialog({
    super.key,
    required this.title,
    this.message,
    this.content,
    this.actions = const [],
    this.icon,
  });

  /// 확인 다이얼로그
  factory AppDialog.confirm({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmLabel = '확인',
    String cancelLabel = '취소',
    bool isDestructive = false,
  }) {
    return AppDialog(
      title: title,
      message: message,
      icon: isDestructive ? Icons.warning : Icons.help_outline,
      actions: [
        AppDialogAction(
          label: cancelLabel,
          onPressed: onCancel,
          isDefault: false,
        ),
        AppDialogAction(
          label: confirmLabel,
          onPressed: onConfirm,
          isDefault: true,
          isDestructive: isDestructive,
        ),
      ],
    );
  }

  /// 알림 다이얼로그
  factory AppDialog.alert({
    required String title,
    required String message,
    VoidCallback? onOk,
    String okLabel = '확인',
    IconData? icon,
  }) {
    return AppDialog(
      title: title,
      message: message,
      icon: icon ?? Icons.info_outline,
      actions: [
        AppDialogAction(
          label: okLabel,
          onPressed: onOk,
          isDefault: true,
        ),
      ],
    );
  }

  /// 삭제 확인 다이얼로그
  factory AppDialog.delete({
    required String itemName,
    required VoidCallback onDelete,
    VoidCallback? onCancel,
  }) {
    return AppDialog.confirm(
      title: '$itemName 삭제',
      message: '정말로 $itemName을(를) 삭제하시겠습니까?\n이 작업은 취소할 수 없습니다.',
      onConfirm: onDelete,
      onCancel: onCancel,
      confirmLabel: '삭제',
      cancelLabel: '취소',
      isDestructive: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 28),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleLarge,
            ),
          ),
        ],
      ),
      content: content ??
          (message != null
              ? Text(
                  message!,
                  style: theme.textTheme.bodyMedium,
                )
              : null),
      actions: actions
          .map(
            (action) => action.isDefault
                ? FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      action.onPressed?.call();
                    },
                    style: action.isDestructive
                        ? FilledButton.styleFrom(
                            backgroundColor: theme.colorScheme.error,
                          )
                        : null,
                    child: Text(action.label),
                  )
                : TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      action.onPressed?.call();
                    },
                    child: Text(action.label),
                  ),
          )
          .toList(),
    );
  }
}

/// 다이얼로그 액션
class AppDialogAction {
  final String label;
  final VoidCallback? onPressed;
  final bool isDefault;
  final bool isDestructive;

  const AppDialogAction({
    required this.label,
    this.onPressed,
    this.isDefault = false,
    this.isDestructive = false,
  });
}

/// 다이얼로그 표시 유틸리티
extension AppDialogExtension on BuildContext {
  /// 다이얼로그 표시
  Future<T?> showAppDialog<T>(AppDialog dialog) {
    return showDialog<T>(
      context: this,
      builder: (context) => dialog,
    );
  }

  /// 확인 다이얼로그 표시
  Future<bool> showConfirmDialog({
    required String title,
    required String message,
    String confirmLabel = '확인',
    String cancelLabel = '취소',
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: this,
      builder: (context) => AppDialog.confirm(
        title: title,
        message: message,
        onConfirm: () {},
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
      ),
    );
    return result ?? false;
  }

  /// 삭제 확인 다이얼로그 표시
  Future<bool> showDeleteConfirmDialog(String itemName) async {
    final result = await showDialog<bool>(
      context: this,
      builder: (context) => AppDialog.delete(
        itemName: itemName,
        onDelete: () {},
      ),
    );
    return result ?? false;
  }
}
