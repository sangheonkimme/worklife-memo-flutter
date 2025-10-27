import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';
part 'tag.g.dart';

/// 태그 Domain Entity
@freezed
class Tag with _$Tag {
  const factory Tag({
    required String id,
    required String name,
    required String color,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int useCount,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

/// 태그 생성 헬퍼
extension TagX on Tag {
  /// 새 태그 생성
  static Tag create({
    required String name,
    required String color,
  }) {
    final now = DateTime.now();
    return Tag(
      id: '', // Repository에서 UUID 생성
      name: name,
      color: color,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// 사용 횟수 증가
  Tag incrementUseCount() => copyWith(useCount: useCount + 1);

  /// 사용 횟수 감소
  Tag decrementUseCount() => copyWith(
        useCount: useCount > 0 ? useCount - 1 : 0,
      );
}
