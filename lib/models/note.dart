import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
class Note with _$Note {
  const factory Note(
      {required int number,
      required String name,
      required String content,
      required String category,
      required String dateOfCreate,
      required String dateOfEdit,
      required bool deleted}) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}