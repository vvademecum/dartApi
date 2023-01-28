import 'package:conduit/conduit.dart';
import 'package:project_lesson/model/user.dart';

class History extends ManagedObject<_History> implements _History {}

class _History {
  @primaryKey
  int? id;
  @Column(nullable: false)
  String? action;
  @Column(nullable: false)
  String? dateOfManipulation;
  
  @Relate(#historyList, isRequired: true, onDelete: DeleteRule.cascade)
  User? user;
}
