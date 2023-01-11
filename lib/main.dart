
import 'package:first_project/screens/note_details.dart';
import 'package:first_project/screens/note_list.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
  //add(1,2, addNumbers);
}

void add(int x, int y, Function(int a, int b) function){
  function(x,y);
}

dynamic addNumbers(int a , int b){
 print('sum is ${a+b}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: const NoteList(),
    );
  }
}
