import 'package:conduit/conduit.dart';
import 'package:project_lesson/model/user.dart';

class Note extends ManagedObject<_Note> implements _Note {}

class _Note {
  @primaryKey
  int? id;
  @Column(nullable: false)
  int? number;
  @Column(unique: true, nullable: false)
  String? name;
  @Column(nullable: false)
  String? content;
  @Column(nullable: false)
  String? category;
  @Column(nullable: false)
  String? dateOfCreate;
  @Column(nullable: false)
  String? dateOfEdit;
  @Column(nullable: false)
  bool? deleted;

  @Relate(#notesList, isRequired: true, onDelete: DeleteRule.cascade)
  User? user;
}
