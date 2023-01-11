import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';

class DatabaseHelper {
  static late DatabaseHelper _databaseHelper;
  static late Database _database;

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper();
    return _databaseHelper;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}node_db';
    var noteDatabase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
          ' $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, '
          '$colDate TEXT)');
    });
    return noteDatabase;
  }

  //Fetch All Notes
  Future<List<Map<String, dynamic>>> getAllNotesFromDatabase() async {
    Database database = await this.database;
    var results = await database
        .rawQuery('SELECT * FROM $noteTable ORDER BY $colPriority ASC');
    return results;
  }

  //Insert Note
  Future<int> insertNote(Note note) async {
    Database database = await this.database;
    var results = await database.insert(noteTable, note.toMap());
    return results;
  }
}
