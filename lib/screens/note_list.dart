import 'package:first_project/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';
import 'note_details.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final DatabaseHelper? databaseHelper = DatabaseHelper.getInsatnce();
  List<Note>? noteList;
  int _count = 0;

  @override
  Widget build(BuildContext context) {

    noteList ??= <Note>[];
    updateListView();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gotoNoteDetails("Add Note", Note('', '', '', 2));
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.titleMedium;
    TextStyle? subTitleStyle = Theme.of(context).textTheme.titleSmall;

    return ListView.builder(
      itemCount: _count,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getPriorityColor(noteList![index].priority),
              child: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
            ),
            title: Text(
              noteList![index].title,
              style: titleStyle,
            ),
            subtitle: Text(
              noteList![index].date,
              style: subTitleStyle,
            ),
            trailing: GestureDetector(
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onTap: (){
                _delete(context, noteList![index]);
              },
            ),
            onTap: () {
              gotoNoteDetails("Edit Note", noteList![index]);
            },
          ),
        );
      },
    );
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.red;
      default:
        return Colors.yellow;
    }
  }

  IconData getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icons.play_arrow;
      case 2:
        return Icons.keyboard_arrow_right;
      default:
        return Icons.keyboard_arrow_right;
    }
  }

  void _delete(BuildContext context, Note note) {
    databaseHelper?.deleteNote(note);
    updateListView();
  }

  void gotoNoteDetails(String title, Note note) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetails(title, note);
    }));
  }

  void updateListView() {
    Future<Database>? database = databaseHelper?.initializeDatabase();
    database?.then((db) {
      Future<List<Note>>? noteListAsync = databaseHelper?.getNoteList();
      noteListAsync?.then((noteList){
        setState(() {
          this.noteList = noteList;
          _count = noteList.length;
        });
      });
    });
  }
}
