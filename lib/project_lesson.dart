import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:project_lesson/contollers/app_auth_contoller.dart';
import 'package:project_lesson/contollers/app_note_controller.dart';
import 'package:project_lesson/contollers/app_token_contoller.dart';
import 'package:project_lesson/contollers/app_user_contoller.dart';

import 'contollers/app_history_controller.dart';

class AppService extends ApplicationChannel {
  late final ManagedContext managedContext;

  @override
  Future prepare() {
    final persistentStore = _initDatabase();

    managedContext = ManagedContext(
        ManagedDataModel.fromCurrentMirrorSystem(), persistentStore);
    return super.prepare();
  }

  @override
  Controller get entryPoint => Router()
    ..route('token/[:refresh]').link(
      () => AppAuthContoler(managedContext),
    )
    ..route('user')
        .link(AppTokenContoller.new)!
        .link(() => AppUserConttolelr(managedContext))
    ..route('notes/[:number]')
        .link(AppTokenContoller.new)!
        .link(() => AppNoteController(managedContext))
    ..route('history')
        .link(AppTokenContoller.new)!
        .link(() => AppHistoryController(managedContext));

  PersistentStore _initDatabase() {
    final config =
        AppConfiguration.fromFile(File(options!.configurationFilePath!));
    final db = config.database;
    final username = db.username;
    final password = db.password;
    final host = db.host;
    final port = db.port;
    final databaseName = db.databaseName;
    return PostgreSQLPersistentStore(
        username, password, host, port, databaseName);
  }
}

class AppConfiguration extends Configuration {
  AppConfiguration.fromFile(File file) : super.fromFile(file);

  late DatabaseConfiguration database;
}
