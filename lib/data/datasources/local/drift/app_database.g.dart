// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FoldersTable extends Folders with TableInfo<$FoldersTable, Folder>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$FoldersTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
@override
late final GeneratedColumn<String> uuid = GeneratedColumn<String>('uuid', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
static const VerificationMeta _nameMeta = const VerificationMeta('name');
@override
late final GeneratedColumn<String> name = GeneratedColumn<String>('name', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _parentIdMeta = const VerificationMeta('parentId');
@override
late final GeneratedColumn<String> parentId = GeneratedColumn<String>('parent_id', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
@override
late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
@override
late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _orderMeta = const VerificationMeta('order');
@override
late final GeneratedColumn<int> order = GeneratedColumn<int>('order', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
static const VerificationMeta _colorMeta = const VerificationMeta('color');
@override
late final GeneratedColumn<String> color = GeneratedColumn<String>('color', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _iconMeta = const VerificationMeta('icon');
@override
late final GeneratedColumn<String> icon = GeneratedColumn<String>('icon', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
@override
List<GeneratedColumn> get $columns => [id, uuid, name, parentId, createdAt, updatedAt, order, color, icon];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'folders';
@override
VerificationContext validateIntegrity(Insertable<Folder> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));}if (data.containsKey('uuid')) {
context.handle(_uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));} else if (isInserting) {
context.missing(_uuidMeta);
}
if (data.containsKey('name')) {
context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));} else if (isInserting) {
context.missing(_nameMeta);
}
if (data.containsKey('parent_id')) {
context.handle(_parentIdMeta, parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));}if (data.containsKey('created_at')) {
context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));} else if (isInserting) {
context.missing(_createdAtMeta);
}
if (data.containsKey('updated_at')) {
context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));} else if (isInserting) {
context.missing(_updatedAtMeta);
}
if (data.containsKey('order')) {
context.handle(_orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));}if (data.containsKey('color')) {
context.handle(_colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));}if (data.containsKey('icon')) {
context.handle(_iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));}return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override Folder map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return Folder(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!, uuid: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}uuid'])!, name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!, parentId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}parent_id']), createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!, updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!, order: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}order'])!, color: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}color']), icon: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}icon']), );
}
@override
$FoldersTable createAlias(String alias) {
return $FoldersTable(attachedDatabase, alias);}}class Folder extends DataClass implements Insertable<Folder> 
{
final int id;
final String uuid;
final String name;
final String? parentId;
final DateTime createdAt;
final DateTime updatedAt;
final int order;
final String? color;
final String? icon;
const Folder({required this.id, required this.uuid, required this.name, this.parentId, required this.createdAt, required this.updatedAt, required this.order, this.color, this.icon});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<int>(id);
map['uuid'] = Variable<String>(uuid);
map['name'] = Variable<String>(name);
if (!nullToAbsent || parentId != null){map['parent_id'] = Variable<String>(parentId);
}map['created_at'] = Variable<DateTime>(createdAt);
map['updated_at'] = Variable<DateTime>(updatedAt);
map['order'] = Variable<int>(order);
if (!nullToAbsent || color != null){map['color'] = Variable<String>(color);
}if (!nullToAbsent || icon != null){map['icon'] = Variable<String>(icon);
}return map; 
}
FoldersCompanion toCompanion(bool nullToAbsent) {
return FoldersCompanion(id: Value(id),uuid: Value(uuid),name: Value(name),parentId: parentId == null && nullToAbsent ? const Value.absent() : Value(parentId),createdAt: Value(createdAt),updatedAt: Value(updatedAt),order: Value(order),color: color == null && nullToAbsent ? const Value.absent() : Value(color),icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),);
}
factory Folder.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return Folder(id: serializer.fromJson<int>(json['id']),uuid: serializer.fromJson<String>(json['uuid']),name: serializer.fromJson<String>(json['name']),parentId: serializer.fromJson<String?>(json['parentId']),createdAt: serializer.fromJson<DateTime>(json['createdAt']),updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),order: serializer.fromJson<int>(json['order']),color: serializer.fromJson<String?>(json['color']),icon: serializer.fromJson<String?>(json['icon']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'uuid': serializer.toJson<String>(uuid),'name': serializer.toJson<String>(name),'parentId': serializer.toJson<String?>(parentId),'createdAt': serializer.toJson<DateTime>(createdAt),'updatedAt': serializer.toJson<DateTime>(updatedAt),'order': serializer.toJson<int>(order),'color': serializer.toJson<String?>(color),'icon': serializer.toJson<String?>(icon),};}Folder copyWith({int? id,String? uuid,String? name,Value<String?> parentId = const Value.absent(),DateTime? createdAt,DateTime? updatedAt,int? order,Value<String?> color = const Value.absent(),Value<String?> icon = const Value.absent()}) => Folder(id: id ?? this.id,uuid: uuid ?? this.uuid,name: name ?? this.name,parentId: parentId.present ? parentId.value : this.parentId,createdAt: createdAt ?? this.createdAt,updatedAt: updatedAt ?? this.updatedAt,order: order ?? this.order,color: color.present ? color.value : this.color,icon: icon.present ? icon.value : this.icon,);Folder copyWithCompanion(FoldersCompanion data) {
return Folder(
id: data.id.present ? data.id.value : this.id,uuid: data.uuid.present ? data.uuid.value : this.uuid,name: data.name.present ? data.name.value : this.name,parentId: data.parentId.present ? data.parentId.value : this.parentId,createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,order: data.order.present ? data.order.value : this.order,color: data.color.present ? data.color.value : this.color,icon: data.icon.present ? data.icon.value : this.icon,);
}
@override
String toString() {return (StringBuffer('Folder(')..write('id: $id, ')..write('uuid: $uuid, ')..write('name: $name, ')..write('parentId: $parentId, ')..write('createdAt: $createdAt, ')..write('updatedAt: $updatedAt, ')..write('order: $order, ')..write('color: $color, ')..write('icon: $icon')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, uuid, name, parentId, createdAt, updatedAt, order, color, icon);@override
bool operator ==(Object other) => identical(this, other) || (other is Folder && other.id == this.id && other.uuid == this.uuid && other.name == this.name && other.parentId == this.parentId && other.createdAt == this.createdAt && other.updatedAt == this.updatedAt && other.order == this.order && other.color == this.color && other.icon == this.icon);
}class FoldersCompanion extends UpdateCompanion<Folder> {
final Value<int> id;
final Value<String> uuid;
final Value<String> name;
final Value<String?> parentId;
final Value<DateTime> createdAt;
final Value<DateTime> updatedAt;
final Value<int> order;
final Value<String?> color;
final Value<String?> icon;
const FoldersCompanion({this.id = const Value.absent(),this.uuid = const Value.absent(),this.name = const Value.absent(),this.parentId = const Value.absent(),this.createdAt = const Value.absent(),this.updatedAt = const Value.absent(),this.order = const Value.absent(),this.color = const Value.absent(),this.icon = const Value.absent(),});
FoldersCompanion.insert({this.id = const Value.absent(),required String uuid,required String name,this.parentId = const Value.absent(),required DateTime createdAt,required DateTime updatedAt,this.order = const Value.absent(),this.color = const Value.absent(),this.icon = const Value.absent(),}): uuid = Value(uuid), name = Value(name), createdAt = Value(createdAt), updatedAt = Value(updatedAt);
static Insertable<Folder> custom({Expression<int>? id, 
Expression<String>? uuid, 
Expression<String>? name, 
Expression<String>? parentId, 
Expression<DateTime>? createdAt, 
Expression<DateTime>? updatedAt, 
Expression<int>? order, 
Expression<String>? color, 
Expression<String>? icon, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (uuid != null)'uuid': uuid,if (name != null)'name': name,if (parentId != null)'parent_id': parentId,if (createdAt != null)'created_at': createdAt,if (updatedAt != null)'updated_at': updatedAt,if (order != null)'order': order,if (color != null)'color': color,if (icon != null)'icon': icon,});
}FoldersCompanion copyWith({Value<int>? id, Value<String>? uuid, Value<String>? name, Value<String?>? parentId, Value<DateTime>? createdAt, Value<DateTime>? updatedAt, Value<int>? order, Value<String?>? color, Value<String?>? icon}) {
return FoldersCompanion(id: id ?? this.id,uuid: uuid ?? this.uuid,name: name ?? this.name,parentId: parentId ?? this.parentId,createdAt: createdAt ?? this.createdAt,updatedAt: updatedAt ?? this.updatedAt,order: order ?? this.order,color: color ?? this.color,icon: icon ?? this.icon,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<int>(id.value);}
if (uuid.present) {
map['uuid'] = Variable<String>(uuid.value);}
if (name.present) {
map['name'] = Variable<String>(name.value);}
if (parentId.present) {
map['parent_id'] = Variable<String>(parentId.value);}
if (createdAt.present) {
map['created_at'] = Variable<DateTime>(createdAt.value);}
if (updatedAt.present) {
map['updated_at'] = Variable<DateTime>(updatedAt.value);}
if (order.present) {
map['order'] = Variable<int>(order.value);}
if (color.present) {
map['color'] = Variable<String>(color.value);}
if (icon.present) {
map['icon'] = Variable<String>(icon.value);}
return map; 
}
@override
String toString() {return (StringBuffer('FoldersCompanion(')..write('id: $id, ')..write('uuid: $uuid, ')..write('name: $name, ')..write('parentId: $parentId, ')..write('createdAt: $createdAt, ')..write('updatedAt: $updatedAt, ')..write('order: $order, ')..write('color: $color, ')..write('icon: $icon')..write(')')).toString();}
}
class $TagsTable extends Tags with TableInfo<$TagsTable, Tag>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$TagsTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
@override
late final GeneratedColumn<String> uuid = GeneratedColumn<String>('uuid', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
static const VerificationMeta _nameMeta = const VerificationMeta('name');
@override
late final GeneratedColumn<String> name = GeneratedColumn<String>('name', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _colorMeta = const VerificationMeta('color');
@override
late final GeneratedColumn<String> color = GeneratedColumn<String>('color', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
@override
late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
@override
late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _useCountMeta = const VerificationMeta('useCount');
@override
late final GeneratedColumn<int> useCount = GeneratedColumn<int>('use_count', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
@override
List<GeneratedColumn> get $columns => [id, uuid, name, color, createdAt, updatedAt, useCount];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'tags';
@override
VerificationContext validateIntegrity(Insertable<Tag> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));}if (data.containsKey('uuid')) {
context.handle(_uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));} else if (isInserting) {
context.missing(_uuidMeta);
}
if (data.containsKey('name')) {
context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));} else if (isInserting) {
context.missing(_nameMeta);
}
if (data.containsKey('color')) {
context.handle(_colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));} else if (isInserting) {
context.missing(_colorMeta);
}
if (data.containsKey('created_at')) {
context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));} else if (isInserting) {
context.missing(_createdAtMeta);
}
if (data.containsKey('updated_at')) {
context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));} else if (isInserting) {
context.missing(_updatedAtMeta);
}
if (data.containsKey('use_count')) {
context.handle(_useCountMeta, useCount.isAcceptableOrUnknown(data['use_count']!, _useCountMeta));}return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override
List<Set<GeneratedColumn>> get uniqueKeys => [{name},
];
@override Tag map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return Tag(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!, uuid: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}uuid'])!, name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!, color: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}color'])!, createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!, updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!, useCount: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}use_count'])!, );
}
@override
$TagsTable createAlias(String alias) {
return $TagsTable(attachedDatabase, alias);}}class Tag extends DataClass implements Insertable<Tag> 
{
final int id;
final String uuid;
final String name;
final String color;
final DateTime createdAt;
final DateTime updatedAt;
final int useCount;
const Tag({required this.id, required this.uuid, required this.name, required this.color, required this.createdAt, required this.updatedAt, required this.useCount});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<int>(id);
map['uuid'] = Variable<String>(uuid);
map['name'] = Variable<String>(name);
map['color'] = Variable<String>(color);
map['created_at'] = Variable<DateTime>(createdAt);
map['updated_at'] = Variable<DateTime>(updatedAt);
map['use_count'] = Variable<int>(useCount);
return map; 
}
TagsCompanion toCompanion(bool nullToAbsent) {
return TagsCompanion(id: Value(id),uuid: Value(uuid),name: Value(name),color: Value(color),createdAt: Value(createdAt),updatedAt: Value(updatedAt),useCount: Value(useCount),);
}
factory Tag.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return Tag(id: serializer.fromJson<int>(json['id']),uuid: serializer.fromJson<String>(json['uuid']),name: serializer.fromJson<String>(json['name']),color: serializer.fromJson<String>(json['color']),createdAt: serializer.fromJson<DateTime>(json['createdAt']),updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),useCount: serializer.fromJson<int>(json['useCount']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'uuid': serializer.toJson<String>(uuid),'name': serializer.toJson<String>(name),'color': serializer.toJson<String>(color),'createdAt': serializer.toJson<DateTime>(createdAt),'updatedAt': serializer.toJson<DateTime>(updatedAt),'useCount': serializer.toJson<int>(useCount),};}Tag copyWith({int? id,String? uuid,String? name,String? color,DateTime? createdAt,DateTime? updatedAt,int? useCount}) => Tag(id: id ?? this.id,uuid: uuid ?? this.uuid,name: name ?? this.name,color: color ?? this.color,createdAt: createdAt ?? this.createdAt,updatedAt: updatedAt ?? this.updatedAt,useCount: useCount ?? this.useCount,);Tag copyWithCompanion(TagsCompanion data) {
return Tag(
id: data.id.present ? data.id.value : this.id,uuid: data.uuid.present ? data.uuid.value : this.uuid,name: data.name.present ? data.name.value : this.name,color: data.color.present ? data.color.value : this.color,createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,useCount: data.useCount.present ? data.useCount.value : this.useCount,);
}
@override
String toString() {return (StringBuffer('Tag(')..write('id: $id, ')..write('uuid: $uuid, ')..write('name: $name, ')..write('color: $color, ')..write('createdAt: $createdAt, ')..write('updatedAt: $updatedAt, ')..write('useCount: $useCount')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, uuid, name, color, createdAt, updatedAt, useCount);@override
bool operator ==(Object other) => identical(this, other) || (other is Tag && other.id == this.id && other.uuid == this.uuid && other.name == this.name && other.color == this.color && other.createdAt == this.createdAt && other.updatedAt == this.updatedAt && other.useCount == this.useCount);
}class TagsCompanion extends UpdateCompanion<Tag> {
final Value<int> id;
final Value<String> uuid;
final Value<String> name;
final Value<String> color;
final Value<DateTime> createdAt;
final Value<DateTime> updatedAt;
final Value<int> useCount;
const TagsCompanion({this.id = const Value.absent(),this.uuid = const Value.absent(),this.name = const Value.absent(),this.color = const Value.absent(),this.createdAt = const Value.absent(),this.updatedAt = const Value.absent(),this.useCount = const Value.absent(),});
TagsCompanion.insert({this.id = const Value.absent(),required String uuid,required String name,required String color,required DateTime createdAt,required DateTime updatedAt,this.useCount = const Value.absent(),}): uuid = Value(uuid), name = Value(name), color = Value(color), createdAt = Value(createdAt), updatedAt = Value(updatedAt);
static Insertable<Tag> custom({Expression<int>? id, 
Expression<String>? uuid, 
Expression<String>? name, 
Expression<String>? color, 
Expression<DateTime>? createdAt, 
Expression<DateTime>? updatedAt, 
Expression<int>? useCount, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (uuid != null)'uuid': uuid,if (name != null)'name': name,if (color != null)'color': color,if (createdAt != null)'created_at': createdAt,if (updatedAt != null)'updated_at': updatedAt,if (useCount != null)'use_count': useCount,});
}TagsCompanion copyWith({Value<int>? id, Value<String>? uuid, Value<String>? name, Value<String>? color, Value<DateTime>? createdAt, Value<DateTime>? updatedAt, Value<int>? useCount}) {
return TagsCompanion(id: id ?? this.id,uuid: uuid ?? this.uuid,name: name ?? this.name,color: color ?? this.color,createdAt: createdAt ?? this.createdAt,updatedAt: updatedAt ?? this.updatedAt,useCount: useCount ?? this.useCount,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<int>(id.value);}
if (uuid.present) {
map['uuid'] = Variable<String>(uuid.value);}
if (name.present) {
map['name'] = Variable<String>(name.value);}
if (color.present) {
map['color'] = Variable<String>(color.value);}
if (createdAt.present) {
map['created_at'] = Variable<DateTime>(createdAt.value);}
if (updatedAt.present) {
map['updated_at'] = Variable<DateTime>(updatedAt.value);}
if (useCount.present) {
map['use_count'] = Variable<int>(useCount.value);}
return map; 
}
@override
String toString() {return (StringBuffer('TagsCompanion(')..write('id: $id, ')..write('uuid: $uuid, ')..write('name: $name, ')..write('color: $color, ')..write('createdAt: $createdAt, ')..write('updatedAt: $updatedAt, ')..write('useCount: $useCount')..write(')')).toString();}
}
class $NotesTable extends Notes with TableInfo<$NotesTable, Note>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$NotesTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
@override
late final GeneratedColumn<String> uuid = GeneratedColumn<String>('uuid', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
static const VerificationMeta _titleMeta = const VerificationMeta('title');
@override
late final GeneratedColumn<String> title = GeneratedColumn<String>('title', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _contentMeta = const VerificationMeta('content');
@override
late final GeneratedColumn<String> content = GeneratedColumn<String>('content', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _typeMeta = const VerificationMeta('type');
@override
late final GeneratedColumnWithTypeConverter<NoteType, int> type = GeneratedColumn<int>('type', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true).withConverter<NoteType>($NotesTable.$convertertype);
static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
@override
late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
@override
late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _isPinnedMeta = const VerificationMeta('isPinned');
@override
late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>('is_pinned', aliasedName, false, type: DriftSqlType.bool, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_pinned" IN (0, 1))'), defaultValue: const Constant(false));
static const VerificationMeta _isArchivedMeta = const VerificationMeta('isArchived');
@override
late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>('is_archived', aliasedName, false, type: DriftSqlType.bool, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'), defaultValue: const Constant(false));
static const VerificationMeta _isDeletedMeta = const VerificationMeta('isDeleted');
@override
late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>('is_deleted', aliasedName, false, type: DriftSqlType.bool, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'), defaultValue: const Constant(false));
static const VerificationMeta _isFavoriteMeta = const VerificationMeta('isFavorite');
@override
late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>('is_favorite', aliasedName, false, type: DriftSqlType.bool, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'), defaultValue: const Constant(false));
static const VerificationMeta _orderMeta = const VerificationMeta('order');
@override
late final GeneratedColumn<int> order = GeneratedColumn<int>('order', aliasedName, true, type: DriftSqlType.int, requiredDuringInsert: false);
static const VerificationMeta _folderIdMeta = const VerificationMeta('folderId');
@override
late final GeneratedColumn<int> folderId = GeneratedColumn<int>('folder_id', aliasedName, true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES folders (id)'));
@override
List<GeneratedColumn> get $columns => [id, uuid, title, content, type, createdAt, updatedAt, isPinned, isArchived, isDeleted, isFavorite, order, folderId];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'notes';
@override
VerificationContext validateIntegrity(Insertable<Note> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));}if (data.containsKey('uuid')) {
context.handle(_uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));} else if (isInserting) {
context.missing(_uuidMeta);
}
if (data.containsKey('title')) {
context.handle(_titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));} else if (isInserting) {
context.missing(_titleMeta);
}
if (data.containsKey('content')) {
context.handle(_contentMeta, content.isAcceptableOrUnknown(data['content']!, _contentMeta));} else if (isInserting) {
context.missing(_contentMeta);
}
context.handle(_typeMeta, const VerificationResult.success());if (data.containsKey('created_at')) {
context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));} else if (isInserting) {
context.missing(_createdAtMeta);
}
if (data.containsKey('updated_at')) {
context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));} else if (isInserting) {
context.missing(_updatedAtMeta);
}
if (data.containsKey('is_pinned')) {
context.handle(_isPinnedMeta, isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta));}if (data.containsKey('is_archived')) {
context.handle(_isArchivedMeta, isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta));}if (data.containsKey('is_deleted')) {
context.handle(_isDeletedMeta, isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));}if (data.containsKey('is_favorite')) {
context.handle(_isFavoriteMeta, isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta));}if (data.containsKey('order')) {
context.handle(_orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));}if (data.containsKey('folder_id')) {
context.handle(_folderIdMeta, folderId.isAcceptableOrUnknown(data['folder_id']!, _folderIdMeta));}return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override Note map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return Note(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!, uuid: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}uuid'])!, title: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}title'])!, content: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}content'])!, type: $NotesTable.$convertertype.fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}type'])!), createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!, updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!, isPinned: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_pinned'])!, isArchived: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!, isDeleted: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!, isFavorite: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!, order: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}order']), folderId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}folder_id']), );
}
@override
$NotesTable createAlias(String alias) {
return $NotesTable(attachedDatabase, alias);}static JsonTypeConverter2<NoteType,int,int> $convertertype = const EnumIndexConverter<NoteType>(NoteType.values);}class Note extends DataClass implements Insertable<Note> 
{
final int id;
final String uuid;
final String title;
final String content;
final NoteType type;
final DateTime createdAt;
final DateTime updatedAt;
final bool isPinned;
final bool isArchived;
final bool isDeleted;
final bool isFavorite;
final int? order;
final int? folderId;
const Note({required this.id, required this.uuid, required this.title, required this.content, required this.type, required this.createdAt, required this.updatedAt, required this.isPinned, required this.isArchived, required this.isDeleted, required this.isFavorite, this.order, this.folderId});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<int>(id);
map['uuid'] = Variable<String>(uuid);
map['title'] = Variable<String>(title);
map['content'] = Variable<String>(content);
{map['type'] = Variable<int>($NotesTable.$convertertype.toSql(type));
}map['created_at'] = Variable<DateTime>(createdAt);
map['updated_at'] = Variable<DateTime>(updatedAt);
map['is_pinned'] = Variable<bool>(isPinned);
map['is_archived'] = Variable<bool>(isArchived);
map['is_deleted'] = Variable<bool>(isDeleted);
map['is_favorite'] = Variable<bool>(isFavorite);
if (!nullToAbsent || order != null){map['order'] = Variable<int>(order);
}if (!nullToAbsent || folderId != null){map['folder_id'] = Variable<int>(folderId);
}return map; 
}
NotesCompanion toCompanion(bool nullToAbsent) {
return NotesCompanion(id: Value(id),uuid: Value(uuid),title: Value(title),content: Value(content),type: Value(type),createdAt: Value(createdAt),updatedAt: Value(updatedAt),isPinned: Value(isPinned),isArchived: Value(isArchived),isDeleted: Value(isDeleted),isFavorite: Value(isFavorite),order: order == null && nullToAbsent ? const Value.absent() : Value(order),folderId: folderId == null && nullToAbsent ? const Value.absent() : Value(folderId),);
}
factory Note.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return Note(id: serializer.fromJson<int>(json['id']),uuid: serializer.fromJson<String>(json['uuid']),title: serializer.fromJson<String>(json['title']),content: serializer.fromJson<String>(json['content']),type: $NotesTable.$convertertype.fromJson(serializer.fromJson<int>(json['type'])),createdAt: serializer.fromJson<DateTime>(json['createdAt']),updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),isPinned: serializer.fromJson<bool>(json['isPinned']),isArchived: serializer.fromJson<bool>(json['isArchived']),isDeleted: serializer.fromJson<bool>(json['isDeleted']),isFavorite: serializer.fromJson<bool>(json['isFavorite']),order: serializer.fromJson<int?>(json['order']),folderId: serializer.fromJson<int?>(json['folderId']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'uuid': serializer.toJson<String>(uuid),'title': serializer.toJson<String>(title),'content': serializer.toJson<String>(content),'type': serializer.toJson<int>($NotesTable.$convertertype.toJson(type)),'createdAt': serializer.toJson<DateTime>(createdAt),'updatedAt': serializer.toJson<DateTime>(updatedAt),'isPinned': serializer.toJson<bool>(isPinned),'isArchived': serializer.toJson<bool>(isArchived),'isDeleted': serializer.toJson<bool>(isDeleted),'isFavorite': serializer.toJson<bool>(isFavorite),'order': serializer.toJson<int?>(order),'folderId': serializer.toJson<int?>(folderId),};}Note copyWith({int? id,String? uuid,String? title,String? content,NoteType? type,DateTime? createdAt,DateTime? updatedAt,bool? isPinned,bool? isArchived,bool? isDeleted,bool? isFavorite,Value<int?> order = const Value.absent(),Value<int?> folderId = const Value.absent()}) => Note(id: id ?? this.id,uuid: uuid ?? this.uuid,title: title ?? this.title,content: content ?? this.content,type: type ?? this.type,createdAt: createdAt ?? this.createdAt,updatedAt: updatedAt ?? this.updatedAt,isPinned: isPinned ?? this.isPinned,isArchived: isArchived ?? this.isArchived,isDeleted: isDeleted ?? this.isDeleted,isFavorite: isFavorite ?? this.isFavorite,order: order.present ? order.value : this.order,folderId: folderId.present ? folderId.value : this.folderId,);Note copyWithCompanion(NotesCompanion data) {
return Note(
id: data.id.present ? data.id.value : this.id,uuid: data.uuid.present ? data.uuid.value : this.uuid,title: data.title.present ? data.title.value : this.title,content: data.content.present ? data.content.value : this.content,type: data.type.present ? data.type.value : this.type,createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,isArchived: data.isArchived.present ? data.isArchived.value : this.isArchived,isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,isFavorite: data.isFavorite.present ? data.isFavorite.value : this.isFavorite,order: data.order.present ? data.order.value : this.order,folderId: data.folderId.present ? data.folderId.value : this.folderId,);
}
@override
String toString() {return (StringBuffer('Note(')..write('id: $id, ')..write('uuid: $uuid, ')..write('title: $title, ')..write('content: $content, ')..write('type: $type, ')..write('createdAt: $createdAt, ')..write('updatedAt: $updatedAt, ')..write('isPinned: $isPinned, ')..write('isArchived: $isArchived, ')..write('isDeleted: $isDeleted, ')..write('isFavorite: $isFavorite, ')..write('order: $order, ')..write('folderId: $folderId')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, uuid, title, content, type, createdAt, updatedAt, isPinned, isArchived, isDeleted, isFavorite, order, folderId);@override
bool operator ==(Object other) => identical(this, other) || (other is Note && other.id == this.id && other.uuid == this.uuid && other.title == this.title && other.content == this.content && other.type == this.type && other.createdAt == this.createdAt && other.updatedAt == this.updatedAt && other.isPinned == this.isPinned && other.isArchived == this.isArchived && other.isDeleted == this.isDeleted && other.isFavorite == this.isFavorite && other.order == this.order && other.folderId == this.folderId);
}class NotesCompanion extends UpdateCompanion<Note> {
final Value<int> id;
final Value<String> uuid;
final Value<String> title;
final Value<String> content;
final Value<NoteType> type;
final Value<DateTime> createdAt;
final Value<DateTime> updatedAt;
final Value<bool> isPinned;
final Value<bool> isArchived;
final Value<bool> isDeleted;
final Value<bool> isFavorite;
final Value<int?> order;
final Value<int?> folderId;
const NotesCompanion({this.id = const Value.absent(),this.uuid = const Value.absent(),this.title = const Value.absent(),this.content = const Value.absent(),this.type = const Value.absent(),this.createdAt = const Value.absent(),this.updatedAt = const Value.absent(),this.isPinned = const Value.absent(),this.isArchived = const Value.absent(),this.isDeleted = const Value.absent(),this.isFavorite = const Value.absent(),this.order = const Value.absent(),this.folderId = const Value.absent(),});
NotesCompanion.insert({this.id = const Value.absent(),required String uuid,required String title,required String content,required NoteType type,required DateTime createdAt,required DateTime updatedAt,this.isPinned = const Value.absent(),this.isArchived = const Value.absent(),this.isDeleted = const Value.absent(),this.isFavorite = const Value.absent(),this.order = const Value.absent(),this.folderId = const Value.absent(),}): uuid = Value(uuid), title = Value(title), content = Value(content), type = Value(type), createdAt = Value(createdAt), updatedAt = Value(updatedAt);
static Insertable<Note> custom({Expression<int>? id, 
Expression<String>? uuid, 
Expression<String>? title, 
Expression<String>? content, 
Expression<int>? type, 
Expression<DateTime>? createdAt, 
Expression<DateTime>? updatedAt, 
Expression<bool>? isPinned, 
Expression<bool>? isArchived, 
Expression<bool>? isDeleted, 
Expression<bool>? isFavorite, 
Expression<int>? order, 
Expression<int>? folderId, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (uuid != null)'uuid': uuid,if (title != null)'title': title,if (content != null)'content': content,if (type != null)'type': type,if (createdAt != null)'created_at': createdAt,if (updatedAt != null)'updated_at': updatedAt,if (isPinned != null)'is_pinned': isPinned,if (isArchived != null)'is_archived': isArchived,if (isDeleted != null)'is_deleted': isDeleted,if (isFavorite != null)'is_favorite': isFavorite,if (order != null)'order': order,if (folderId != null)'folder_id': folderId,});
}NotesCompanion copyWith({Value<int>? id, Value<String>? uuid, Value<String>? title, Value<String>? content, Value<NoteType>? type, Value<DateTime>? createdAt, Value<DateTime>? updatedAt, Value<bool>? isPinned, Value<bool>? isArchived, Value<bool>? isDeleted, Value<bool>? isFavorite, Value<int?>? order, Value<int?>? folderId}) {
return NotesCompanion(id: id ?? this.id,uuid: uuid ?? this.uuid,title: title ?? this.title,content: content ?? this.content,type: type ?? this.type,createdAt: createdAt ?? this.createdAt,updatedAt: updatedAt ?? this.updatedAt,isPinned: isPinned ?? this.isPinned,isArchived: isArchived ?? this.isArchived,isDeleted: isDeleted ?? this.isDeleted,isFavorite: isFavorite ?? this.isFavorite,order: order ?? this.order,folderId: folderId ?? this.folderId,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<int>(id.value);}
if (uuid.present) {
map['uuid'] = Variable<String>(uuid.value);}
if (title.present) {
map['title'] = Variable<String>(title.value);}
if (content.present) {
map['content'] = Variable<String>(content.value);}
if (type.present) {
map['type'] = Variable<int>($NotesTable.$convertertype.toSql(type.value));}
if (createdAt.present) {
map['created_at'] = Variable<DateTime>(createdAt.value);}
if (updatedAt.present) {
map['updated_at'] = Variable<DateTime>(updatedAt.value);}
if (isPinned.present) {
map['is_pinned'] = Variable<bool>(isPinned.value);}
if (isArchived.present) {
map['is_archived'] = Variable<bool>(isArchived.value);}
if (isDeleted.present) {
map['is_deleted'] = Variable<bool>(isDeleted.value);}
if (isFavorite.present) {
map['is_favorite'] = Variable<bool>(isFavorite.value);}
if (order.present) {
map['order'] = Variable<int>(order.value);}
if (folderId.present) {
map['folder_id'] = Variable<int>(folderId.value);}
return map; 
}
@override
String toString() {return (StringBuffer('NotesCompanion(')..write('id: $id, ')..write('uuid: $uuid, ')..write('title: $title, ')..write('content: $content, ')..write('type: $type, ')..write('createdAt: $createdAt, ')..write('updatedAt: $updatedAt, ')..write('isPinned: $isPinned, ')..write('isArchived: $isArchived, ')..write('isDeleted: $isDeleted, ')..write('isFavorite: $isFavorite, ')..write('order: $order, ')..write('folderId: $folderId')..write(')')).toString();}
}
class $ChecklistItemsTable extends ChecklistItems with TableInfo<$ChecklistItemsTable, ChecklistItem>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$ChecklistItemsTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
@override
late final GeneratedColumn<String> uuid = GeneratedColumn<String>('uuid', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
@override
late final GeneratedColumn<int> noteId = GeneratedColumn<int>('note_id', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES notes (id) ON DELETE CASCADE'));
static const VerificationMeta _itemTextMeta = const VerificationMeta('itemText');
@override
late final GeneratedColumn<String> itemText = GeneratedColumn<String>('item_text', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _isCompletedMeta = const VerificationMeta('isCompleted');
@override
late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>('is_completed', aliasedName, false, type: DriftSqlType.bool, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_completed" IN (0, 1))'), defaultValue: const Constant(false));
static const VerificationMeta _orderMeta = const VerificationMeta('order');
@override
late final GeneratedColumn<int> order = GeneratedColumn<int>('order', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
@override
late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
@override
late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
@override
List<GeneratedColumn> get $columns => [id, uuid, noteId, itemText, isCompleted, order, createdAt, updatedAt];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'checklist_items';
@override
VerificationContext validateIntegrity(Insertable<ChecklistItem> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));}if (data.containsKey('uuid')) {
context.handle(_uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));} else if (isInserting) {
context.missing(_uuidMeta);
}
if (data.containsKey('note_id')) {
context.handle(_noteIdMeta, noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta));} else if (isInserting) {
context.missing(_noteIdMeta);
}
if (data.containsKey('item_text')) {
context.handle(_itemTextMeta, itemText.isAcceptableOrUnknown(data['item_text']!, _itemTextMeta));} else if (isInserting) {
context.missing(_itemTextMeta);
}
if (data.containsKey('is_completed')) {
context.handle(_isCompletedMeta, isCompleted.isAcceptableOrUnknown(data['is_completed']!, _isCompletedMeta));}if (data.containsKey('order')) {
context.handle(_orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));} else if (isInserting) {
context.missing(_orderMeta);
}
if (data.containsKey('created_at')) {
context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));} else if (isInserting) {
context.missing(_createdAtMeta);
}
if (data.containsKey('updated_at')) {
context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));} else if (isInserting) {
context.missing(_updatedAtMeta);
}
return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override ChecklistItem map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return ChecklistItem(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!, uuid: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}uuid'])!, noteId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}note_id'])!, itemText: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}item_text'])!, isCompleted: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!, order: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}order'])!, createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!, updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!, );
}
@override
$ChecklistItemsTable createAlias(String alias) {
return $ChecklistItemsTable(attachedDatabase, alias);}}class ChecklistItem extends DataClass implements Insertable<ChecklistItem> 
{
final int id;
final String uuid;
final int noteId;
final String itemText;
final bool isCompleted;
final int order;
final DateTime createdAt;
final DateTime updatedAt;
const ChecklistItem({required this.id, required this.uuid, required this.noteId, required this.itemText, required this.isCompleted, required this.order, required this.createdAt, required this.updatedAt});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<int>(id);
map['uuid'] = Variable<String>(uuid);
map['note_id'] = Variable<int>(noteId);
map['item_text'] = Variable<String>(itemText);
map['is_completed'] = Variable<bool>(isCompleted);
map['order'] = Variable<int>(order);
map['created_at'] = Variable<DateTime>(createdAt);
map['updated_at'] = Variable<DateTime>(updatedAt);
return map; 
}
ChecklistItemsCompanion toCompanion(bool nullToAbsent) {
return ChecklistItemsCompanion(id: Value(id),uuid: Value(uuid),noteId: Value(noteId),itemText: Value(itemText),isCompleted: Value(isCompleted),order: Value(order),createdAt: Value(createdAt),updatedAt: Value(updatedAt),);
}
factory ChecklistItem.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return ChecklistItem(id: serializer.fromJson<int>(json['id']),uuid: serializer.fromJson<String>(json['uuid']),noteId: serializer.fromJson<int>(json['noteId']),itemText: serializer.fromJson<String>(json['itemText']),isCompleted: serializer.fromJson<bool>(json['isCompleted']),order: serializer.fromJson<int>(json['order']),createdAt: serializer.fromJson<DateTime>(json['createdAt']),updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'uuid': serializer.toJson<String>(uuid),'noteId': serializer.toJson<int>(noteId),'itemText': serializer.toJson<String>(itemText),'isCompleted': serializer.toJson<bool>(isCompleted),'order': serializer.toJson<int>(order),'createdAt': serializer.toJson<DateTime>(createdAt),'updatedAt': serializer.toJson<DateTime>(updatedAt),};}ChecklistItem copyWith({int? id,String? uuid,int? noteId,String? itemText,bool? isCompleted,int? order,DateTime? createdAt,DateTime? updatedAt}) => ChecklistItem(id: id ?? this.id,uuid: uuid ?? this.uuid,noteId: noteId ?? this.noteId,itemText: itemText ?? this.itemText,isCompleted: isCompleted ?? this.isCompleted,order: order ?? this.order,createdAt: createdAt ?? this.createdAt,updatedAt: updatedAt ?? this.updatedAt,);ChecklistItem copyWithCompanion(ChecklistItemsCompanion data) {
return ChecklistItem(
id: data.id.present ? data.id.value : this.id,uuid: data.uuid.present ? data.uuid.value : this.uuid,noteId: data.noteId.present ? data.noteId.value : this.noteId,itemText: data.itemText.present ? data.itemText.value : this.itemText,isCompleted: data.isCompleted.present ? data.isCompleted.value : this.isCompleted,order: data.order.present ? data.order.value : this.order,createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,);
}
@override
String toString() {return (StringBuffer('ChecklistItem(')..write('id: $id, ')..write('uuid: $uuid, ')..write('noteId: $noteId, ')..write('itemText: $itemText, ')..write('isCompleted: $isCompleted, ')..write('order: $order, ')..write('createdAt: $createdAt, ')..write('updatedAt: $updatedAt')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, uuid, noteId, itemText, isCompleted, order, createdAt, updatedAt);@override
bool operator ==(Object other) => identical(this, other) || (other is ChecklistItem && other.id == this.id && other.uuid == this.uuid && other.noteId == this.noteId && other.itemText == this.itemText && other.isCompleted == this.isCompleted && other.order == this.order && other.createdAt == this.createdAt && other.updatedAt == this.updatedAt);
}class ChecklistItemsCompanion extends UpdateCompanion<ChecklistItem> {
final Value<int> id;
final Value<String> uuid;
final Value<int> noteId;
final Value<String> itemText;
final Value<bool> isCompleted;
final Value<int> order;
final Value<DateTime> createdAt;
final Value<DateTime> updatedAt;
const ChecklistItemsCompanion({this.id = const Value.absent(),this.uuid = const Value.absent(),this.noteId = const Value.absent(),this.itemText = const Value.absent(),this.isCompleted = const Value.absent(),this.order = const Value.absent(),this.createdAt = const Value.absent(),this.updatedAt = const Value.absent(),});
ChecklistItemsCompanion.insert({this.id = const Value.absent(),required String uuid,required int noteId,required String itemText,this.isCompleted = const Value.absent(),required int order,required DateTime createdAt,required DateTime updatedAt,}): uuid = Value(uuid), noteId = Value(noteId), itemText = Value(itemText), order = Value(order), createdAt = Value(createdAt), updatedAt = Value(updatedAt);
static Insertable<ChecklistItem> custom({Expression<int>? id, 
Expression<String>? uuid, 
Expression<int>? noteId, 
Expression<String>? itemText, 
Expression<bool>? isCompleted, 
Expression<int>? order, 
Expression<DateTime>? createdAt, 
Expression<DateTime>? updatedAt, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (uuid != null)'uuid': uuid,if (noteId != null)'note_id': noteId,if (itemText != null)'item_text': itemText,if (isCompleted != null)'is_completed': isCompleted,if (order != null)'order': order,if (createdAt != null)'created_at': createdAt,if (updatedAt != null)'updated_at': updatedAt,});
}ChecklistItemsCompanion copyWith({Value<int>? id, Value<String>? uuid, Value<int>? noteId, Value<String>? itemText, Value<bool>? isCompleted, Value<int>? order, Value<DateTime>? createdAt, Value<DateTime>? updatedAt}) {
return ChecklistItemsCompanion(id: id ?? this.id,uuid: uuid ?? this.uuid,noteId: noteId ?? this.noteId,itemText: itemText ?? this.itemText,isCompleted: isCompleted ?? this.isCompleted,order: order ?? this.order,createdAt: createdAt ?? this.createdAt,updatedAt: updatedAt ?? this.updatedAt,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<int>(id.value);}
if (uuid.present) {
map['uuid'] = Variable<String>(uuid.value);}
if (noteId.present) {
map['note_id'] = Variable<int>(noteId.value);}
if (itemText.present) {
map['item_text'] = Variable<String>(itemText.value);}
if (isCompleted.present) {
map['is_completed'] = Variable<bool>(isCompleted.value);}
if (order.present) {
map['order'] = Variable<int>(order.value);}
if (createdAt.present) {
map['created_at'] = Variable<DateTime>(createdAt.value);}
if (updatedAt.present) {
map['updated_at'] = Variable<DateTime>(updatedAt.value);}
return map; 
}
@override
String toString() {return (StringBuffer('ChecklistItemsCompanion(')..write('id: $id, ')..write('uuid: $uuid, ')..write('noteId: $noteId, ')..write('itemText: $itemText, ')..write('isCompleted: $isCompleted, ')..write('order: $order, ')..write('createdAt: $createdAt, ')..write('updatedAt: $updatedAt')..write(')')).toString();}
}
class $NoteTagsTable extends NoteTags with TableInfo<$NoteTagsTable, NoteTagLink>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$NoteTagsTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
@override
late final GeneratedColumn<int> noteId = GeneratedColumn<int>('note_id', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES notes (id) ON DELETE CASCADE'));
static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
@override
late final GeneratedColumn<int> tagId = GeneratedColumn<int>('tag_id', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES tags (id) ON DELETE CASCADE'));
@override
List<GeneratedColumn> get $columns => [noteId, tagId];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'note_tags';
@override
VerificationContext validateIntegrity(Insertable<NoteTagLink> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('note_id')) {
context.handle(_noteIdMeta, noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta));} else if (isInserting) {
context.missing(_noteIdMeta);
}
if (data.containsKey('tag_id')) {
context.handle(_tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));} else if (isInserting) {
context.missing(_tagIdMeta);
}
return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {noteId, tagId};
@override NoteTagLink map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return NoteTagLink(noteId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}note_id'])!, tagId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!, );
}
@override
$NoteTagsTable createAlias(String alias) {
return $NoteTagsTable(attachedDatabase, alias);}}class NoteTagLink extends DataClass implements Insertable<NoteTagLink> 
{
final int noteId;
final int tagId;
const NoteTagLink({required this.noteId, required this.tagId});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['note_id'] = Variable<int>(noteId);
map['tag_id'] = Variable<int>(tagId);
return map; 
}
NoteTagsCompanion toCompanion(bool nullToAbsent) {
return NoteTagsCompanion(noteId: Value(noteId),tagId: Value(tagId),);
}
factory NoteTagLink.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return NoteTagLink(noteId: serializer.fromJson<int>(json['noteId']),tagId: serializer.fromJson<int>(json['tagId']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'noteId': serializer.toJson<int>(noteId),'tagId': serializer.toJson<int>(tagId),};}NoteTagLink copyWith({int? noteId,int? tagId}) => NoteTagLink(noteId: noteId ?? this.noteId,tagId: tagId ?? this.tagId,);NoteTagLink copyWithCompanion(NoteTagsCompanion data) {
return NoteTagLink(
noteId: data.noteId.present ? data.noteId.value : this.noteId,tagId: data.tagId.present ? data.tagId.value : this.tagId,);
}
@override
String toString() {return (StringBuffer('NoteTagLink(')..write('noteId: $noteId, ')..write('tagId: $tagId')..write(')')).toString();}
@override
 int get hashCode => Object.hash(noteId, tagId);@override
bool operator ==(Object other) => identical(this, other) || (other is NoteTagLink && other.noteId == this.noteId && other.tagId == this.tagId);
}class NoteTagsCompanion extends UpdateCompanion<NoteTagLink> {
final Value<int> noteId;
final Value<int> tagId;
final Value<int> rowid;
const NoteTagsCompanion({this.noteId = const Value.absent(),this.tagId = const Value.absent(),this.rowid = const Value.absent(),});
NoteTagsCompanion.insert({required int noteId,required int tagId,this.rowid = const Value.absent(),}): noteId = Value(noteId), tagId = Value(tagId);
static Insertable<NoteTagLink> custom({Expression<int>? noteId, 
Expression<int>? tagId, 
Expression<int>? rowid, 
}) {
return RawValuesInsertable({if (noteId != null)'note_id': noteId,if (tagId != null)'tag_id': tagId,if (rowid != null)'rowid': rowid,});
}NoteTagsCompanion copyWith({Value<int>? noteId, Value<int>? tagId, Value<int>? rowid}) {
return NoteTagsCompanion(noteId: noteId ?? this.noteId,tagId: tagId ?? this.tagId,rowid: rowid ?? this.rowid,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (noteId.present) {
map['note_id'] = Variable<int>(noteId.value);}
if (tagId.present) {
map['tag_id'] = Variable<int>(tagId.value);}
if (rowid.present) {
map['rowid'] = Variable<int>(rowid.value);}
return map; 
}
@override
String toString() {return (StringBuffer('NoteTagsCompanion(')..write('noteId: $noteId, ')..write('tagId: $tagId, ')..write('rowid: $rowid')..write(')')).toString();}
}
abstract class _$AppDatabase extends GeneratedDatabase{
_$AppDatabase(QueryExecutor e): super(e);
$AppDatabaseManager get managers => $AppDatabaseManager(this);
late final $FoldersTable folders = $FoldersTable(this);
late final $TagsTable tags = $TagsTable(this);
late final $NotesTable notes = $NotesTable(this);
late final $ChecklistItemsTable checklistItems = $ChecklistItemsTable(this);
late final $NoteTagsTable noteTags = $NoteTagsTable(this);
@override
Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
@override
List<DatabaseSchemaEntity> get allSchemaEntities => [folders, tags, notes, checklistItems, noteTags];
@override
StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([WritePropagation(on: TableUpdateQuery.onTableName('notes' , limitUpdateKind: UpdateKind.delete), result: [TableUpdate('checklist_items', kind: UpdateKind.delete), ],), WritePropagation(on: TableUpdateQuery.onTableName('notes' , limitUpdateKind: UpdateKind.delete), result: [TableUpdate('note_tags', kind: UpdateKind.delete), ],), WritePropagation(on: TableUpdateQuery.onTableName('tags' , limitUpdateKind: UpdateKind.delete), result: [TableUpdate('note_tags', kind: UpdateKind.delete), ],), ],);
}
typedef $$FoldersTableCreateCompanionBuilder = FoldersCompanion Function({Value<int> id,required String uuid,required String name,Value<String?> parentId,required DateTime createdAt,required DateTime updatedAt,Value<int> order,Value<String?> color,Value<String?> icon,});
typedef $$FoldersTableUpdateCompanionBuilder = FoldersCompanion Function({Value<int> id,Value<String> uuid,Value<String> name,Value<String?> parentId,Value<DateTime> createdAt,Value<DateTime> updatedAt,Value<int> order,Value<String?> color,Value<String?> icon,});
      final class $$FoldersTableReferences extends BaseReferences<
        _$AppDatabase,
        $FoldersTable,
        Folder> {
        $$FoldersTableReferences(super.$_db, super.$_table, super.$_typedResult);
        
                  
                  static MultiTypedResultKey<
          $NotesTable,
          List<Note>
        > _notesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(
          db.notes, 
          aliasName: $_aliasNameGenerator(
            db.folders.id,
            db.notes.folderId)
        );

          $$NotesTableProcessedTableManager get notesRefs {
        final manager = $$NotesTableTableManager(
            $_db, $_db.notes
            ).filter(
              (f) => f.folderId.id(
              $_item.id
            )
          );

          final cache = $_typedResult.readTableOrNull(_notesRefsTable($_db));
          return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));


        }
        

      }class $$FoldersTableFilterComposer extends Composer<
        _$AppDatabase,
        $FoldersTable> {
        $$FoldersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get name => $composableBuilder(
      column: $table.name,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get parentId => $composableBuilder(
      column: $table.parentId,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get order => $composableBuilder(
      column: $table.order,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get color => $composableBuilder(
      column: $table.color,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon,
      builder: (column) => 
      ColumnFilters(column));
      
        Expression<bool> notesRefs(
          Expression<bool> Function( $$NotesTableFilterComposer f) f
        ) {
                final $$NotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.folderId,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$NotesTableFilterComposer(
              $db: $db,
              $table: $db.notes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return f(composer);
        }

        }
      class $$FoldersTableOrderingComposer extends Composer<
        _$AppDatabase,
        $FoldersTable> {
        $$FoldersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get parentId => $composableBuilder(
      column: $table.parentId,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon,
      builder: (column) => 
      ColumnOrderings(column));
      
        }
      class $$FoldersTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $FoldersTable> {
        $$FoldersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => column);
      
GeneratedColumn<String> get name => $composableBuilder(
      column: $table.name,
      builder: (column) => column);
      
GeneratedColumn<String> get parentId => $composableBuilder(
      column: $table.parentId,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt,
      builder: (column) => column);
      
GeneratedColumn<int> get order => $composableBuilder(
      column: $table.order,
      builder: (column) => column);
      
GeneratedColumn<String> get color => $composableBuilder(
      column: $table.color,
      builder: (column) => column);
      
GeneratedColumn<String> get icon => $composableBuilder(
      column: $table.icon,
      builder: (column) => column);
      
        Expression<T> notesRefs<T extends Object>(
          Expression<T> Function( $$NotesTableAnnotationComposer a) f
        ) {
                final $$NotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.folderId,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$NotesTableAnnotationComposer(
              $db: $db,
              $table: $db.notes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return f(composer);
        }

        }
      class $$FoldersTableTableManager extends RootTableManager    <_$AppDatabase,
    $FoldersTable,
    Folder,
    $$FoldersTableFilterComposer,
    $$FoldersTableOrderingComposer,
    $$FoldersTableAnnotationComposer,
    $$FoldersTableCreateCompanionBuilder,
    $$FoldersTableUpdateCompanionBuilder,
    (Folder,$$FoldersTableReferences),
    Folder,
    PrefetchHooks Function({bool notesRefs})
    > {
    $$FoldersTableTableManager(_$AppDatabase db, $FoldersTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$FoldersTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$FoldersTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$FoldersTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<int> id = const Value.absent(),Value<String> uuid = const Value.absent(),Value<String> name = const Value.absent(),Value<String?> parentId = const Value.absent(),Value<DateTime> createdAt = const Value.absent(),Value<DateTime> updatedAt = const Value.absent(),Value<int> order = const Value.absent(),Value<String?> color = const Value.absent(),Value<String?> icon = const Value.absent(),})=> FoldersCompanion(id: id,uuid: uuid,name: name,parentId: parentId,createdAt: createdAt,updatedAt: updatedAt,order: order,color: color,icon: icon,),
        createCompanionCallback: ({Value<int> id = const Value.absent(),required String uuid,required String name,Value<String?> parentId = const Value.absent(),required DateTime createdAt,required DateTime updatedAt,Value<int> order = const Value.absent(),Value<String?> color = const Value.absent(),Value<String?> icon = const Value.absent(),})=> FoldersCompanion.insert(id: id,uuid: uuid,name: name,parentId: parentId,createdAt: createdAt,updatedAt: updatedAt,order: order,color: color,icon: icon,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), $$FoldersTableReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback:         ({notesRefs = false}){
          return PrefetchHooks(
            db: db,
            explicitlyWatchedTables: [
             if (notesRefs) db.notes
            ],
            addJoins: null,
            getPrefetchedDataCallback: (items) async {
            return [
                      if (notesRefs) await $_getPrefetchedData(
                  currentTable: table,
                  referencedTable:
                      $$FoldersTableReferences._notesRefsTable(db),
                  managerFromTypedResult: (p0) =>
                      $$FoldersTableReferences(db, table, p0).notesRefs,
                  referencedItemsForCurrentItem: (item, referencedItems) =>
                      referencedItems.where((e) => e.folderId == item.id),
                  typedResults: items)
            
                ];
              },
          );
        }
,
        ));
        }
    typedef $$FoldersTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $FoldersTable,
    Folder,
    $$FoldersTableFilterComposer,
    $$FoldersTableOrderingComposer,
    $$FoldersTableAnnotationComposer,
    $$FoldersTableCreateCompanionBuilder,
    $$FoldersTableUpdateCompanionBuilder,
    (Folder,$$FoldersTableReferences),
    Folder,
    PrefetchHooks Function({bool notesRefs})
    >;typedef $$TagsTableCreateCompanionBuilder = TagsCompanion Function({Value<int> id,required String uuid,required String name,required String color,required DateTime createdAt,required DateTime updatedAt,Value<int> useCount,});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({Value<int> id,Value<String> uuid,Value<String> name,Value<String> color,Value<DateTime> createdAt,Value<DateTime> updatedAt,Value<int> useCount,});
      final class $$TagsTableReferences extends BaseReferences<
        _$AppDatabase,
        $TagsTable,
        Tag> {
        $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);
        
                  
                  static MultiTypedResultKey<
          $NoteTagsTable,
          List<NoteTagLink>
        > _noteTagsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(
          db.noteTags, 
          aliasName: $_aliasNameGenerator(
            db.tags.id,
            db.noteTags.tagId)
        );

          $$NoteTagsTableProcessedTableManager get noteTagsRefs {
        final manager = $$NoteTagsTableTableManager(
            $_db, $_db.noteTags
            ).filter(
              (f) => f.tagId.id(
              $_item.id
            )
          );

          final cache = $_typedResult.readTableOrNull(_noteTagsRefsTable($_db));
          return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));


        }
        

      }class $$TagsTableFilterComposer extends Composer<
        _$AppDatabase,
        $TagsTable> {
        $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get name => $composableBuilder(
      column: $table.name,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get color => $composableBuilder(
      column: $table.color,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get useCount => $composableBuilder(
      column: $table.useCount,
      builder: (column) => 
      ColumnFilters(column));
      
        Expression<bool> noteTagsRefs(
          Expression<bool> Function( $$NoteTagsTableFilterComposer f) f
        ) {
                final $$NoteTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.noteTags,
      getReferencedColumn: (t) => t.tagId,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$NoteTagsTableFilterComposer(
              $db: $db,
              $table: $db.noteTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return f(composer);
        }

        }
      class $$TagsTableOrderingComposer extends Composer<
        _$AppDatabase,
        $TagsTable> {
        $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get useCount => $composableBuilder(
      column: $table.useCount,
      builder: (column) => 
      ColumnOrderings(column));
      
        }
      class $$TagsTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $TagsTable> {
        $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => column);
      
GeneratedColumn<String> get name => $composableBuilder(
      column: $table.name,
      builder: (column) => column);
      
GeneratedColumn<String> get color => $composableBuilder(
      column: $table.color,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt,
      builder: (column) => column);
      
GeneratedColumn<int> get useCount => $composableBuilder(
      column: $table.useCount,
      builder: (column) => column);
      
        Expression<T> noteTagsRefs<T extends Object>(
          Expression<T> Function( $$NoteTagsTableAnnotationComposer a) f
        ) {
                final $$NoteTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.noteTags,
      getReferencedColumn: (t) => t.tagId,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$NoteTagsTableAnnotationComposer(
              $db: $db,
              $table: $db.noteTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return f(composer);
        }

        }
      class $$TagsTableTableManager extends RootTableManager    <_$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableAnnotationComposer,
    $$TagsTableCreateCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder,
    (Tag,$$TagsTableReferences),
    Tag,
    PrefetchHooks Function({bool noteTagsRefs})
    > {
    $$TagsTableTableManager(_$AppDatabase db, $TagsTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$TagsTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$TagsTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$TagsTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<int> id = const Value.absent(),Value<String> uuid = const Value.absent(),Value<String> name = const Value.absent(),Value<String> color = const Value.absent(),Value<DateTime> createdAt = const Value.absent(),Value<DateTime> updatedAt = const Value.absent(),Value<int> useCount = const Value.absent(),})=> TagsCompanion(id: id,uuid: uuid,name: name,color: color,createdAt: createdAt,updatedAt: updatedAt,useCount: useCount,),
        createCompanionCallback: ({Value<int> id = const Value.absent(),required String uuid,required String name,required String color,required DateTime createdAt,required DateTime updatedAt,Value<int> useCount = const Value.absent(),})=> TagsCompanion.insert(id: id,uuid: uuid,name: name,color: color,createdAt: createdAt,updatedAt: updatedAt,useCount: useCount,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), $$TagsTableReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback:         ({noteTagsRefs = false}){
          return PrefetchHooks(
            db: db,
            explicitlyWatchedTables: [
             if (noteTagsRefs) db.noteTags
            ],
            addJoins: null,
            getPrefetchedDataCallback: (items) async {
            return [
                      if (noteTagsRefs) await $_getPrefetchedData(
                  currentTable: table,
                  referencedTable:
                      $$TagsTableReferences._noteTagsRefsTable(db),
                  managerFromTypedResult: (p0) =>
                      $$TagsTableReferences(db, table, p0).noteTagsRefs,
                  referencedItemsForCurrentItem: (item, referencedItems) =>
                      referencedItems.where((e) => e.tagId == item.id),
                  typedResults: items)
            
                ];
              },
          );
        }
,
        ));
        }
    typedef $$TagsTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableAnnotationComposer,
    $$TagsTableCreateCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder,
    (Tag,$$TagsTableReferences),
    Tag,
    PrefetchHooks Function({bool noteTagsRefs})
    >;typedef $$NotesTableCreateCompanionBuilder = NotesCompanion Function({Value<int> id,required String uuid,required String title,required String content,required NoteType type,required DateTime createdAt,required DateTime updatedAt,Value<bool> isPinned,Value<bool> isArchived,Value<bool> isDeleted,Value<bool> isFavorite,Value<int?> order,Value<int?> folderId,});
typedef $$NotesTableUpdateCompanionBuilder = NotesCompanion Function({Value<int> id,Value<String> uuid,Value<String> title,Value<String> content,Value<NoteType> type,Value<DateTime> createdAt,Value<DateTime> updatedAt,Value<bool> isPinned,Value<bool> isArchived,Value<bool> isDeleted,Value<bool> isFavorite,Value<int?> order,Value<int?> folderId,});
      final class $$NotesTableReferences extends BaseReferences<
        _$AppDatabase,
        $NotesTable,
        Note> {
        $$NotesTableReferences(super.$_db, super.$_table, super.$_typedResult);
        
                          static $FoldersTable _folderIdTable(_$AppDatabase db) => 
            db.folders.createAlias($_aliasNameGenerator(
            db.notes.folderId,
            db.folders.id));
          

        $$FoldersTableProcessedTableManager? get folderId {
          if ($_item.folderId == null) return null;
          final manager = $$FoldersTableTableManager($_db, $_db.folders).filter((f) => f.id($_item.folderId!));
          final item = $_typedResult.readTableOrNull(_folderIdTable($_db));
          if (item == null) return manager;
          return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
        }

          
                  static MultiTypedResultKey<
          $ChecklistItemsTable,
          List<ChecklistItem>
        > _checklistItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(
          db.checklistItems, 
          aliasName: $_aliasNameGenerator(
            db.notes.id,
            db.checklistItems.noteId)
        );

          $$ChecklistItemsTableProcessedTableManager get checklistItemsRefs {
        final manager = $$ChecklistItemsTableTableManager(
            $_db, $_db.checklistItems
            ).filter(
              (f) => f.noteId.id(
              $_item.id
            )
          );

          final cache = $_typedResult.readTableOrNull(_checklistItemsRefsTable($_db));
          return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));


        }
        
          
                  static MultiTypedResultKey<
          $NoteTagsTable,
          List<NoteTagLink>
        > _noteTagsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(
          db.noteTags, 
          aliasName: $_aliasNameGenerator(
            db.notes.id,
            db.noteTags.noteId)
        );

          $$NoteTagsTableProcessedTableManager get noteTagsRefs {
        final manager = $$NoteTagsTableTableManager(
            $_db, $_db.noteTags
            ).filter(
              (f) => f.noteId.id(
              $_item.id
            )
          );

          final cache = $_typedResult.readTableOrNull(_noteTagsRefsTable($_db));
          return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));


        }
        

      }class $$NotesTableFilterComposer extends Composer<
        _$AppDatabase,
        $NotesTable> {
        $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get title => $composableBuilder(
      column: $table.title,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get content => $composableBuilder(
      column: $table.content,
      builder: (column) => 
      ColumnFilters(column));
      
          ColumnWithTypeConverterFilters<NoteType,NoteType,int> get type => $composableBuilder(
      column: $table.type,
      builder: (column) => 
      ColumnWithTypeConverterFilters(column));
      
ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<bool> get isPinned => $composableBuilder(
      column: $table.isPinned,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<bool> get isArchived => $composableBuilder(
      column: $table.isArchived,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get order => $composableBuilder(
      column: $table.order,
      builder: (column) => 
      ColumnFilters(column));
      
        $$FoldersTableFilterComposer get folderId {
                final $$FoldersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.folderId,
      referencedTable: $db.folders,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$FoldersTableFilterComposer(
              $db: $db,
              $table: $db.folders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        Expression<bool> checklistItemsRefs(
          Expression<bool> Function( $$ChecklistItemsTableFilterComposer f) f
        ) {
                final $$ChecklistItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checklistItems,
      getReferencedColumn: (t) => t.noteId,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$ChecklistItemsTableFilterComposer(
              $db: $db,
              $table: $db.checklistItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return f(composer);
        }

        Expression<bool> noteTagsRefs(
          Expression<bool> Function( $$NoteTagsTableFilterComposer f) f
        ) {
                final $$NoteTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.noteTags,
      getReferencedColumn: (t) => t.noteId,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$NoteTagsTableFilterComposer(
              $db: $db,
              $table: $db.noteTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return f(composer);
        }

        }
      class $$NotesTableOrderingComposer extends Composer<
        _$AppDatabase,
        $NotesTable> {
        $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<bool> get isPinned => $composableBuilder(
      column: $table.isPinned,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<bool> get isArchived => $composableBuilder(
      column: $table.isArchived,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order,
      builder: (column) => 
      ColumnOrderings(column));
      
        $$FoldersTableOrderingComposer get folderId {
                final $$FoldersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.folderId,
      referencedTable: $db.folders,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$FoldersTableOrderingComposer(
              $db: $db,
              $table: $db.folders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        }
      class $$NotesTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $NotesTable> {
        $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => column);
      
GeneratedColumn<String> get title => $composableBuilder(
      column: $table.title,
      builder: (column) => column);
      
GeneratedColumn<String> get content => $composableBuilder(
      column: $table.content,
      builder: (column) => column);
      
          GeneratedColumnWithTypeConverter<NoteType,int> get type => $composableBuilder(
      column: $table.type,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt,
      builder: (column) => column);
      
GeneratedColumn<bool> get isPinned => $composableBuilder(
      column: $table.isPinned,
      builder: (column) => column);
      
GeneratedColumn<bool> get isArchived => $composableBuilder(
      column: $table.isArchived,
      builder: (column) => column);
      
GeneratedColumn<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted,
      builder: (column) => column);
      
GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite,
      builder: (column) => column);
      
GeneratedColumn<int> get order => $composableBuilder(
      column: $table.order,
      builder: (column) => column);
      
        $$FoldersTableAnnotationComposer get folderId {
                final $$FoldersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.folderId,
      referencedTable: $db.folders,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$FoldersTableAnnotationComposer(
              $db: $db,
              $table: $db.folders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        Expression<T> checklistItemsRefs<T extends Object>(
          Expression<T> Function( $$ChecklistItemsTableAnnotationComposer a) f
        ) {
                final $$ChecklistItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checklistItems,
      getReferencedColumn: (t) => t.noteId,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$ChecklistItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.checklistItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return f(composer);
        }

        Expression<T> noteTagsRefs<T extends Object>(
          Expression<T> Function( $$NoteTagsTableAnnotationComposer a) f
        ) {
                final $$NoteTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.noteTags,
      getReferencedColumn: (t) => t.noteId,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$NoteTagsTableAnnotationComposer(
              $db: $db,
              $table: $db.noteTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return f(composer);
        }

        }
      class $$NotesTableTableManager extends RootTableManager    <_$AppDatabase,
    $NotesTable,
    Note,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableAnnotationComposer,
    $$NotesTableCreateCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder,
    (Note,$$NotesTableReferences),
    Note,
    PrefetchHooks Function({bool folderId,bool checklistItemsRefs,bool noteTagsRefs})
    > {
    $$NotesTableTableManager(_$AppDatabase db, $NotesTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$NotesTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$NotesTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$NotesTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<int> id = const Value.absent(),Value<String> uuid = const Value.absent(),Value<String> title = const Value.absent(),Value<String> content = const Value.absent(),Value<NoteType> type = const Value.absent(),Value<DateTime> createdAt = const Value.absent(),Value<DateTime> updatedAt = const Value.absent(),Value<bool> isPinned = const Value.absent(),Value<bool> isArchived = const Value.absent(),Value<bool> isDeleted = const Value.absent(),Value<bool> isFavorite = const Value.absent(),Value<int?> order = const Value.absent(),Value<int?> folderId = const Value.absent(),})=> NotesCompanion(id: id,uuid: uuid,title: title,content: content,type: type,createdAt: createdAt,updatedAt: updatedAt,isPinned: isPinned,isArchived: isArchived,isDeleted: isDeleted,isFavorite: isFavorite,order: order,folderId: folderId,),
        createCompanionCallback: ({Value<int> id = const Value.absent(),required String uuid,required String title,required String content,required NoteType type,required DateTime createdAt,required DateTime updatedAt,Value<bool> isPinned = const Value.absent(),Value<bool> isArchived = const Value.absent(),Value<bool> isDeleted = const Value.absent(),Value<bool> isFavorite = const Value.absent(),Value<int?> order = const Value.absent(),Value<int?> folderId = const Value.absent(),})=> NotesCompanion.insert(id: id,uuid: uuid,title: title,content: content,type: type,createdAt: createdAt,updatedAt: updatedAt,isPinned: isPinned,isArchived: isArchived,isDeleted: isDeleted,isFavorite: isFavorite,order: order,folderId: folderId,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), $$NotesTableReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback:         ({folderId = false,checklistItemsRefs = false,noteTagsRefs = false}){
          return PrefetchHooks(
            db: db,
            explicitlyWatchedTables: [
             if (checklistItemsRefs) db.checklistItems,if (noteTagsRefs) db.noteTags
            ],
            addJoins: <T extends TableManagerState<dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic>>(state) {

                                  if (folderId){
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.folderId,
                    referencedTable:
                        $$NotesTableReferences._folderIdTable(db),
                    referencedColumn:
                        $$NotesTableReferences._folderIdTable(db).id,
                  ) as T;
               }

                return state;
              }
,
            getPrefetchedDataCallback: (items) async {
            return [
                      if (checklistItemsRefs) await $_getPrefetchedData(
                  currentTable: table,
                  referencedTable:
                      $$NotesTableReferences._checklistItemsRefsTable(db),
                  managerFromTypedResult: (p0) =>
                      $$NotesTableReferences(db, table, p0).checklistItemsRefs,
                  referencedItemsForCurrentItem: (item, referencedItems) =>
                      referencedItems.where((e) => e.noteId == item.id),
                  typedResults: items)
            ,          if (noteTagsRefs) await $_getPrefetchedData(
                  currentTable: table,
                  referencedTable:
                      $$NotesTableReferences._noteTagsRefsTable(db),
                  managerFromTypedResult: (p0) =>
                      $$NotesTableReferences(db, table, p0).noteTagsRefs,
                  referencedItemsForCurrentItem: (item, referencedItems) =>
                      referencedItems.where((e) => e.noteId == item.id),
                  typedResults: items)
            
                ];
              },
          );
        }
,
        ));
        }
    typedef $$NotesTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $NotesTable,
    Note,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableAnnotationComposer,
    $$NotesTableCreateCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder,
    (Note,$$NotesTableReferences),
    Note,
    PrefetchHooks Function({bool folderId,bool checklistItemsRefs,bool noteTagsRefs})
    >;typedef $$ChecklistItemsTableCreateCompanionBuilder = ChecklistItemsCompanion Function({Value<int> id,required String uuid,required int noteId,required String itemText,Value<bool> isCompleted,required int order,required DateTime createdAt,required DateTime updatedAt,});
typedef $$ChecklistItemsTableUpdateCompanionBuilder = ChecklistItemsCompanion Function({Value<int> id,Value<String> uuid,Value<int> noteId,Value<String> itemText,Value<bool> isCompleted,Value<int> order,Value<DateTime> createdAt,Value<DateTime> updatedAt,});
      final class $$ChecklistItemsTableReferences extends BaseReferences<
        _$AppDatabase,
        $ChecklistItemsTable,
        ChecklistItem> {
        $$ChecklistItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);
        
                          static $NotesTable _noteIdTable(_$AppDatabase db) => 
            db.notes.createAlias($_aliasNameGenerator(
            db.checklistItems.noteId,
            db.notes.id));
          

        $$NotesTableProcessedTableManager? get noteId {
          if ($_item.noteId == null) return null;
          final manager = $$NotesTableTableManager($_db, $_db.notes).filter((f) => f.id($_item.noteId!));
          final item = $_typedResult.readTableOrNull(_noteIdTable($_db));
          if (item == null) return manager;
          return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
        }


      }class $$ChecklistItemsTableFilterComposer extends Composer<
        _$AppDatabase,
        $ChecklistItemsTable> {
        $$ChecklistItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get itemText => $composableBuilder(
      column: $table.itemText,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get order => $composableBuilder(
      column: $table.order,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt,
      builder: (column) => 
      ColumnFilters(column));
      
        $$NotesTableFilterComposer get noteId {
                final $$NotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.noteId,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$NotesTableFilterComposer(
              $db: $db,
              $table: $db.notes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        }
      class $$ChecklistItemsTableOrderingComposer extends Composer<
        _$AppDatabase,
        $ChecklistItemsTable> {
        $$ChecklistItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get itemText => $composableBuilder(
      column: $table.itemText,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
        $$NotesTableOrderingComposer get noteId {
                final $$NotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.noteId,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$NotesTableOrderingComposer(
              $db: $db,
              $table: $db.notes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        }
      class $$ChecklistItemsTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $ChecklistItemsTable> {
        $$ChecklistItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => column);
      
GeneratedColumn<String> get itemText => $composableBuilder(
      column: $table.itemText,
      builder: (column) => column);
      
GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted,
      builder: (column) => column);
      
GeneratedColumn<int> get order => $composableBuilder(
      column: $table.order,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt,
      builder: (column) => column);
      
        $$NotesTableAnnotationComposer get noteId {
                final $$NotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.noteId,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$NotesTableAnnotationComposer(
              $db: $db,
              $table: $db.notes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        }
      class $$ChecklistItemsTableTableManager extends RootTableManager    <_$AppDatabase,
    $ChecklistItemsTable,
    ChecklistItem,
    $$ChecklistItemsTableFilterComposer,
    $$ChecklistItemsTableOrderingComposer,
    $$ChecklistItemsTableAnnotationComposer,
    $$ChecklistItemsTableCreateCompanionBuilder,
    $$ChecklistItemsTableUpdateCompanionBuilder,
    (ChecklistItem,$$ChecklistItemsTableReferences),
    ChecklistItem,
    PrefetchHooks Function({bool noteId})
    > {
    $$ChecklistItemsTableTableManager(_$AppDatabase db, $ChecklistItemsTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$ChecklistItemsTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$ChecklistItemsTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$ChecklistItemsTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<int> id = const Value.absent(),Value<String> uuid = const Value.absent(),Value<int> noteId = const Value.absent(),Value<String> itemText = const Value.absent(),Value<bool> isCompleted = const Value.absent(),Value<int> order = const Value.absent(),Value<DateTime> createdAt = const Value.absent(),Value<DateTime> updatedAt = const Value.absent(),})=> ChecklistItemsCompanion(id: id,uuid: uuid,noteId: noteId,itemText: itemText,isCompleted: isCompleted,order: order,createdAt: createdAt,updatedAt: updatedAt,),
        createCompanionCallback: ({Value<int> id = const Value.absent(),required String uuid,required int noteId,required String itemText,Value<bool> isCompleted = const Value.absent(),required int order,required DateTime createdAt,required DateTime updatedAt,})=> ChecklistItemsCompanion.insert(id: id,uuid: uuid,noteId: noteId,itemText: itemText,isCompleted: isCompleted,order: order,createdAt: createdAt,updatedAt: updatedAt,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), $$ChecklistItemsTableReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback:         ({noteId = false}){
          return PrefetchHooks(
            db: db,
            explicitlyWatchedTables: [
             
            ],
            addJoins: <T extends TableManagerState<dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic>>(state) {

                                  if (noteId){
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.noteId,
                    referencedTable:
                        $$ChecklistItemsTableReferences._noteIdTable(db),
                    referencedColumn:
                        $$ChecklistItemsTableReferences._noteIdTable(db).id,
                  ) as T;
               }

                return state;
              }
,
            getPrefetchedDataCallback: (items) async {
            return [
            
                ];
              },
          );
        }
,
        ));
        }
    typedef $$ChecklistItemsTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $ChecklistItemsTable,
    ChecklistItem,
    $$ChecklistItemsTableFilterComposer,
    $$ChecklistItemsTableOrderingComposer,
    $$ChecklistItemsTableAnnotationComposer,
    $$ChecklistItemsTableCreateCompanionBuilder,
    $$ChecklistItemsTableUpdateCompanionBuilder,
    (ChecklistItem,$$ChecklistItemsTableReferences),
    ChecklistItem,
    PrefetchHooks Function({bool noteId})
    >;typedef $$NoteTagsTableCreateCompanionBuilder = NoteTagsCompanion Function({required int noteId,required int tagId,Value<int> rowid,});
typedef $$NoteTagsTableUpdateCompanionBuilder = NoteTagsCompanion Function({Value<int> noteId,Value<int> tagId,Value<int> rowid,});
      final class $$NoteTagsTableReferences extends BaseReferences<
        _$AppDatabase,
        $NoteTagsTable,
        NoteTagLink> {
        $$NoteTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);
        
                          static $NotesTable _noteIdTable(_$AppDatabase db) => 
            db.notes.createAlias($_aliasNameGenerator(
            db.noteTags.noteId,
            db.notes.id));
          

        $$NotesTableProcessedTableManager? get noteId {
          if ($_item.noteId == null) return null;
          final manager = $$NotesTableTableManager($_db, $_db.notes).filter((f) => f.id($_item.noteId!));
          final item = $_typedResult.readTableOrNull(_noteIdTable($_db));
          if (item == null) return manager;
          return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
        }

                  static $TagsTable _tagIdTable(_$AppDatabase db) => 
            db.tags.createAlias($_aliasNameGenerator(
            db.noteTags.tagId,
            db.tags.id));
          

        $$TagsTableProcessedTableManager? get tagId {
          if ($_item.tagId == null) return null;
          final manager = $$TagsTableTableManager($_db, $_db.tags).filter((f) => f.id($_item.tagId!));
          final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
          if (item == null) return manager;
          return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
        }


      }class $$NoteTagsTableFilterComposer extends Composer<
        _$AppDatabase,
        $NoteTagsTable> {
        $$NoteTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
                  $$NotesTableFilterComposer get noteId {
                final $$NotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.noteId,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$NotesTableFilterComposer(
              $db: $db,
              $table: $db.notes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        $$TagsTableFilterComposer get tagId {
                final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$TagsTableFilterComposer(
              $db: $db,
              $table: $db.tags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        }
      class $$NoteTagsTableOrderingComposer extends Composer<
        _$AppDatabase,
        $NoteTagsTable> {
        $$NoteTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
                  $$NotesTableOrderingComposer get noteId {
                final $$NotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.noteId,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$NotesTableOrderingComposer(
              $db: $db,
              $table: $db.notes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        $$TagsTableOrderingComposer get tagId {
                final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$TagsTableOrderingComposer(
              $db: $db,
              $table: $db.tags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        }
      class $$NoteTagsTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $NoteTagsTable> {
        $$NoteTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
                  $$NotesTableAnnotationComposer get noteId {
                final $$NotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.noteId,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$NotesTableAnnotationComposer(
              $db: $db,
              $table: $db.notes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        $$TagsTableAnnotationComposer get tagId {
                final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$TagsTableAnnotationComposer(
              $db: $db,
              $table: $db.tags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        }
      class $$NoteTagsTableTableManager extends RootTableManager    <_$AppDatabase,
    $NoteTagsTable,
    NoteTagLink,
    $$NoteTagsTableFilterComposer,
    $$NoteTagsTableOrderingComposer,
    $$NoteTagsTableAnnotationComposer,
    $$NoteTagsTableCreateCompanionBuilder,
    $$NoteTagsTableUpdateCompanionBuilder,
    (NoteTagLink,$$NoteTagsTableReferences),
    NoteTagLink,
    PrefetchHooks Function({bool noteId,bool tagId})
    > {
    $$NoteTagsTableTableManager(_$AppDatabase db, $NoteTagsTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$NoteTagsTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$NoteTagsTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$NoteTagsTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<int> noteId = const Value.absent(),Value<int> tagId = const Value.absent(),Value<int> rowid = const Value.absent(),})=> NoteTagsCompanion(noteId: noteId,tagId: tagId,rowid: rowid,),
        createCompanionCallback: ({required int noteId,required int tagId,Value<int> rowid = const Value.absent(),})=> NoteTagsCompanion.insert(noteId: noteId,tagId: tagId,rowid: rowid,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), $$NoteTagsTableReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback:         ({noteId = false,tagId = false}){
          return PrefetchHooks(
            db: db,
            explicitlyWatchedTables: [
             
            ],
            addJoins: <T extends TableManagerState<dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic>>(state) {

                                  if (noteId){
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.noteId,
                    referencedTable:
                        $$NoteTagsTableReferences._noteIdTable(db),
                    referencedColumn:
                        $$NoteTagsTableReferences._noteIdTable(db).id,
                  ) as T;
               }
                  if (tagId){
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tagId,
                    referencedTable:
                        $$NoteTagsTableReferences._tagIdTable(db),
                    referencedColumn:
                        $$NoteTagsTableReferences._tagIdTable(db).id,
                  ) as T;
               }

                return state;
              }
,
            getPrefetchedDataCallback: (items) async {
            return [
            
                ];
              },
          );
        }
,
        ));
        }
    typedef $$NoteTagsTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $NoteTagsTable,
    NoteTagLink,
    $$NoteTagsTableFilterComposer,
    $$NoteTagsTableOrderingComposer,
    $$NoteTagsTableAnnotationComposer,
    $$NoteTagsTableCreateCompanionBuilder,
    $$NoteTagsTableUpdateCompanionBuilder,
    (NoteTagLink,$$NoteTagsTableReferences),
    NoteTagLink,
    PrefetchHooks Function({bool noteId,bool tagId})
    >;class $AppDatabaseManager {
final _$AppDatabase _db;
$AppDatabaseManager(this._db);
$$FoldersTableTableManager get folders => $$FoldersTableTableManager(_db, _db.folders);
$$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
$$NotesTableTableManager get notes => $$NotesTableTableManager(_db, _db.notes);
$$ChecklistItemsTableTableManager get checklistItems => $$ChecklistItemsTableTableManager(_db, _db.checklistItems);
$$NoteTagsTableTableManager get noteTags => $$NoteTagsTableTableManager(_db, _db.noteTags);
}
