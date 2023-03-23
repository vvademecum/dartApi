import 'dart:collection';
import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:project_lesson/model/note.dart';
import 'package:project_lesson/utils/app_response.dart';
import 'package:project_lesson/utils/app_utils.dart';

import '../model/history.dart';
import '../model/model_response.dart';
import '../model/user.dart';

class AppNoteController extends ResourceController {
  AppNoteController(this.managedContext);

  final ManagedContext managedContext;

  @Operation.post()
  Future<Response> createNote(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      @Bind.body() Note note) async {
    if (note.number == null ||
        note.name == null ||
        note.content == null ||
        note.category == null) {
      return Response.badRequest(
        body: ModelResponse(
            message: 'Поля number, name, content и category обязательны'),
      );
    }
    try {
      final id = AppUtils.getIdFromHeader(header);
      final user = await managedContext.fetchObjectWithID<User>(id);

      late final int noteId;

      await managedContext.transaction((transaction) async {
        final qCreateNote = Query<Note>(transaction)
          ..values.number = note.number
          ..values.name = note.name
          ..values.content = note.content
          ..values.category = note.category
          ..values.dateOfCreate = DateTime.now().toString()
          ..values.dateOfEdit = DateTime.now().toString()
          ..values.user = user
          ..values.deleted = false;

        final createdNote = await qCreateNote.insert();

        noteId = createdNote.id!;
      });

      final noteView = await managedContext.fetchObjectWithID<Note>(noteId);
      noteView!.removePropertiesFromBackingMap(["id", "user", "deleted"]);

      createHistoryRow(id,
          "Добавлена заметка №${note.number} пользователем ${user!.userName}");

      return Response.ok(
        ModelResponse(
          data: noteView.backing.contents,
          message: 'Заметка успешно создана',
        ),
      );
    } on QueryException catch (e) {
      return Response.serverError(body: ModelResponse(message: e.message));
    }
  }

  @Operation.get()
  Future<Response> getNotes(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      {@Bind.query("search") String? search,
      @Bind.query("offset") int? offset,
      @Bind.query("limit") int? limit,
      @Bind.query("filter") String? filter}) async {
    try {
      final id = AppUtils.getIdFromHeader(header);

      Query<Note>? qNotes;
      if (search != null && search != "") {
        qNotes = Query<Note>(managedContext)
          ..where((note) => note.name).contains(search)
          ..where((note) => note.user!.id).equalTo(id);
      } else {
        qNotes = Query<Note>(managedContext)
          ..where((note) => note.user!.id).equalTo(id);
      }

      if (filter == 'deleted')
        qNotes.where((note) => note.deleted).equalTo(true);
      else
        qNotes.where((note) => note.deleted).equalTo(false);

      if (limit != null && limit > 0) {
        qNotes.fetchLimit = limit;
      }
      if (offset != null && offset > 0) {
        qNotes.offset = offset;
      }

      final List<Note> notesList = await qNotes.fetch();
      List notesJson = List.empty(growable: true);

      if (notesList.isEmpty)
        return AppResponse.ok(message: "Заметки не найдены");
      else {
        notesList.forEach((element) {
          element.removePropertiesFromBackingMap(["user", "id", "deleted"]);
          notesJson.add(element.backing.contents);
        });
      }

      return AppResponse.ok(message: 'Заметки получены', body: notesJson);
    } catch (e) {
      return AppResponse.serverError(e);
    }
  }

  @Operation.delete("number")
  Future<Response> deleteNote(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      @Bind.path("number") int number) async {
    try {
      final id = AppUtils.getIdFromHeader(header);
      final user = await managedContext.fetchObjectWithID<User>(id);
      final qNote = Query<Note>(managedContext)
        ..where((note) => note.number).equalTo(number)
        ..where((note) => note.user!.id).equalTo(id)
        ..where((note) => note.deleted).equalTo(false);
      final note = await qNote.fetchOne();
      if (note == null) {
        return AppResponse.ok(message: "Заметка не найдена");
      }
      final qLogicDeleteNote = Query<Note>(managedContext)
        ..where((note) => note.number).equalTo(number)
        ..values.deleted = true;
      await qLogicDeleteNote.update();
      createHistoryRow(id,
          "Удалена заметка №${note.number} пользователем ${user!.userName}");

      return AppResponse.ok(message: 'Успешное удаление заметки');
    } catch (e) {
      return AppResponse.serverError(e, message: 'Ошибка удаления заметки');
    }
  }

  @Operation.get("number")
  Future<Response> getNote(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      @Bind.path("number") int number,
      {@Bind.query("reborn") bool? reborn}) async {
    try {
      final id = AppUtils.getIdFromHeader(header);
      final user = await managedContext.fetchObjectWithID<User>(id);
      final qOneNote = Query<Note>(managedContext)
        ..where((note) => note.number).equalTo(number)
        ..where((note) => note.user!.id).equalTo(id)
        ..where((note) => note.deleted).equalTo(true);

      final oneNote = await qOneNote.fetchOne();

      String message = "Заметка найдена";
      if (oneNote != null && reborn != null && reborn) {
        qOneNote.values.deleted = false;
        qOneNote.update();
        message = "Заметка восстановлена";

        createHistoryRow(id,
            "Восстановлена заметка №${oneNote.number} пользователем ${user!.userName}");
      }

      final qNote = Query<Note>(managedContext)
        ..where((note) => note.number).equalTo(number)
        ..where((note) => note.user!.id).equalTo(id)
        ..where((note) => note.deleted).equalTo(false);
      final note = await qNote.fetchOne();
      if (note == null) {
        return AppResponse.ok(message: "Заметка не найдена");
      }
      note.removePropertiesFromBackingMap(["user", "id", "deleted"]);
      return AppResponse.ok(body: note.backing.contents, message: message);
    } catch (e) {
      return AppResponse.serverError(e,
          message: 'Ошибка при получении заметки');
    }
  }

  @Operation.put("number")
  Future<Response> updateNote(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      @Bind.path("number") int number,
      @Bind.body() Note note) async {
    try {
      final id = AppUtils.getIdFromHeader(header);
      final user = await managedContext.fetchObjectWithID<User>(id);
      final qNote = Query<Note>(managedContext)
        ..where((note) => note.number).equalTo(number)
        ..where((note) => note.user!.id).equalTo(id)
        ..where((note) => note.deleted).equalTo(false);
      final noteDB = await qNote.fetchOne();
      if (noteDB == null) {
        return AppResponse.ok(message: "Заметка не найдена");
      }
      final qUpdateNote = Query<Note>(managedContext)
        ..where((note) => note.id).equalTo(noteDB.id)
        ..values.number = note.number
        ..values.category = note.category
        ..values.name = note.name
        ..values.content = note.content
        ..values.dateOfEdit = DateTime.now().toString();
      await qUpdateNote.update();

      createHistoryRow(id,
          "Обновлена заметка №${note.number} пользователем ${user!.userName}");

      return AppResponse.ok(
          body: note.backing.contents, message: "Данные заметки обновлены");
    } catch (e) {
      return AppResponse.serverError(e,
          message: 'Ошибка при получении заметки');
    }
  }

  void createHistoryRow(int userId, String message) async {
    final user = await managedContext.fetchObjectWithID<User>(userId);

    final qHistory = Query<History>(managedContext)
      ..values.dateOfManipulation = DateTime.now().toString()
      ..values.action = message
      ..values.user = user;

    qHistory.insert();
  }
}
