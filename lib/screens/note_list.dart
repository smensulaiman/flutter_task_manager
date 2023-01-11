import 'package:flutter/material.dart';

import 'note_details.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  int count = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gotoNoteDetails("Add Note");
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
      itemCount: count,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
            ),
            title: Text(
              'Dummy Title',
              style: titleStyle,
            ),
            subtitle: Text(
              'Nov 10, 2023',
              style: subTitleStyle,
            ),
            trailing: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onTap: () {
              gotoNoteDetails("Edit Note");
            },
          ),
        );
      },
    );
  }

  void gotoNoteDetails(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetails(title);
    }));
  }
}
