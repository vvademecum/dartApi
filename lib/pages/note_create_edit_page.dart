import 'package:api_app_flutter/pages/main_page.dart';
import 'package:flutter/material.dart';

import '../models/note.dart';
import '../utils/note_utils.dart';

class NoteCreateEditPage extends StatefulWidget {
  NoteCreateEditPage({Note? note, Key? key}) {
    this.note = note;
    key = super.key;
  }

  late Note? note;

  State<NoteCreateEditPage> createState() => NoteCreateEditPageState(note);
}

class NoteCreateEditPageState extends State<NoteCreateEditPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  Note? note;

  NoteCreateEditPageState(Note? note) {
    this.note = note;
  }

  TextEditingController nameController = new TextEditingController();
  TextEditingController contentController = new TextEditingController();
  TextEditingController categoryController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (note != null) {
      nameController.text = note!.name;
      contentController.text = note!.content;
      categoryController.text = note!.category;
    }
    return Scaffold(
      body: Column(
        children: [
          Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    child: TextFormField(
                      validator: (value) {
                        if (value == "") {
                          return "Поле не должно быть пустым";
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: new InputDecoration(
                          hintText: "Название", border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    child: TextFormField(
                      validator: (value) {
                        if (value == "") {
                          return "Поле не должно быть пустым";
                        }
                        return null;
                      },
                      controller: contentController,
                      decoration: new InputDecoration(
                          hintText: "Текст", border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    child: TextFormField(
                      validator: (value) {
                        if (value == "") {
                          return "Поле не должно быть пустым";
                        }
                        return null;
                      },
                      controller: categoryController,
                      decoration: new InputDecoration(
                          hintText: "Категория", border: OutlineInputBorder()),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()));
                          },
                          child: Text("Назад")),
                      ElevatedButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }
                            if (note != null) {
                              // ignore: unnecessary_new
                              Note updateNote = new Note(
                                  number: note!.number,
                                  name: nameController.text,
                                  content: contentController.text,
                                  category: categoryController.text,
                                  dateOfCreate: "dateOfCreate",
                                  dateOfEdit: "dateOfEdit",
                                  deleted: false);
                              NoteUtils()
                                  .updateNote(updateNote)
                                  .then((success) {
                                if (!success) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                          content: Text(
                                    "Ошибка сохранения данных",
                                    textAlign: TextAlign.justify,
                                  )));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                          content: Text(
                                    "Успешное сохранение данных заметки",
                                    textAlign: TextAlign.justify,
                                  )));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainPage()));
                                }
                              });
                            } else {
                              // ignore: unnecessary_new
                              Note createNote = new Note(
                                  number: 234,
                                  name: nameController.text,
                                  content: contentController.text,
                                  category: categoryController.text,
                                  dateOfCreate: "dateOfCreate",
                                  dateOfEdit: "dateOfEdit",
                                  deleted: false);
                              NoteUtils()
                                  .createNote(createNote)
                                  .then((success) {
                                if (!success) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                          content: Text(
                                    "Ошибка сохранения данных",
                                    textAlign: TextAlign.justify,
                                  )));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                          content: Text(
                                    "Успешное сохранение данных заметки",
                                    textAlign: TextAlign.justify,
                                  )));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainPage()));
                                }
                              });
                            }
                          },
                          child: Text("Сохранить"))
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
