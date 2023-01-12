import 'package:first_project/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';

class NoteDetails extends StatefulWidget {
  final String _title;
  final Note note;

  const NoteDetails(this._title, this.note, {super.key});

  @override
  State<NoteDetails> createState() => _NoteDetailsState(_title, note);
}

class _NoteDetailsState extends State<NoteDetails> {
  static const _priorities = ["High", "Low"];
  String appbarTitle;
  late String dropdownValue;
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();

  DatabaseHelper? databaseHelper = DatabaseHelper.getInsatnce();
  Note note;

  _NoteDetailsState(this.appbarTitle, this.note);

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    dropdownValue = _priorities[1];
    titleTextEditingController.text = note.title;
    descriptionTextEditingController.text = note.description;

    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: DropdownButton(
                items: _priorities.map((String item) {
                  return DropdownMenuItem<String>(
                      value: item, child: Text(item));
                }).toList(),
                style: textStyle,
                value: convertPriorityToString(note.priority),
                onChanged: (value) {
                  setState(() {
                    convertPriorityFromString(value!);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleTextEditingController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint(value);
                  updateTitle(value);
                },
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionTextEditingController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint(value);
                  updateDescription(value);
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      },
                    child: const Text('Save'),
                  )),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    style: const ButtonStyle(),
                    child: const Text('Delete'),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void convertPriorityFromString(String value) {
    switch (value) {
      case "High":
        note.priority = 1;
        break;
      case "Low":
        note.priority = 2;
        break;
    }
  }

  String convertPriorityToString(int value) {
    switch (value) {
      case 1:
        dropdownValue = _priorities[0];
        break;
      case 2:
        dropdownValue = _priorities[1];
        break;
    }
    return dropdownValue;
  }

  void updateTitle(String title) {
    note.title = title;
  }

  void updateDescription(String description) {
    note.description = description;
  }
}
