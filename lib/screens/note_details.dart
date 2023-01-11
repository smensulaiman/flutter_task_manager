import 'package:flutter/material.dart';

class NoteDetails extends StatefulWidget {
  String _title;

  NoteDetails(this._title, {super.key});

  @override
  State<NoteDetails> createState() => _NoteDetailsState(_title);
}

class _NoteDetailsState extends State<NoteDetails> {
  static final _priorities = ["High", "Low"];
  String appbarTitle;
  String dropdownValue = _priorities[1];
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();

  _NoteDetailsState(this.appbarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;

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
                value: dropdownValue,
                onChanged: (value) {
                  setState(() {
                    dropdownValue = value!;
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
                      setState(() {});
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
}
