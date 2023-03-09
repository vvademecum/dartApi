// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      number: json['number'] as int,
      name: json['name'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      dateOfCreate: json['dateOfCreate'] as String,
      dateOfEdit: json['dateOfEdit'] as String,
      deleted: json['deleted'] == null ? false : true,
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'content': instance.content,
      'category': instance.category,
      'dateOfCreate': instance.dateOfCreate,
      'dateOfEdit': instance.dateOfEdit,
      'deleted': instance.deleted,
    };
