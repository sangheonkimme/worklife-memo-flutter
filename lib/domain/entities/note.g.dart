// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoteImpl _$$NoteImplFromJson(Map<String, dynamic> json) => _$NoteImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      type: $enumDecode(_$NoteTypeEnumMap, json['type']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isPinned: json['isPinned'] as bool? ?? false,
      isArchived: json['isArchived'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      order: (json['order'] as num?)?.toInt(),
      folder: json['folder'] == null
          ? null
          : Folder.fromJson(json['folder'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$NoteImplToJson(_$NoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'type': _$NoteTypeEnumMap[instance.type]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isPinned': instance.isPinned,
      'isArchived': instance.isArchived,
      'isDeleted': instance.isDeleted,
      'isFavorite': instance.isFavorite,
      'order': instance.order,
      'folder': instance.folder,
      'tags': instance.tags,
    };

const _$NoteTypeEnumMap = {
  NoteType.richText: 'richText',
  NoteType.markdown: 'markdown',
  NoteType.checklist: 'checklist',
};
