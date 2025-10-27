import 'package:freezed_annotation/freezed_annotation.dart';

part 'folder.freezed.dart';
part 'folder.g.dart';

/// 폴더 Domain Entity
@freezed
class Folder with _$Folder {
  const factory Folder({
    required String id,
    required String name,
    String? parentId,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int order,
    String? color,
    String? icon,
  }) = _Folder;

  factory Folder.fromJson(Map<String, dynamic> json) => _$FolderFromJson(json);
}

/// 폴더 생성 헬퍼
extension FolderX on Folder {
  /// 새 폴더 생성
  static Folder create({
    required String name,
    String? parentId,
    String? color,
    String? icon,
  }) {
    final now = DateTime.now();
    return Folder(
      id: '', // Repository에서 UUID 생성
      name: name,
      parentId: parentId,
      createdAt: now,
      updatedAt: now,
      color: color,
      icon: icon,
    );
  }

  /// 루트 폴더 여부
  bool get isRoot => parentId == null;

  /// 서브 폴더 여부
  bool get isSubFolder => !isRoot;
}
