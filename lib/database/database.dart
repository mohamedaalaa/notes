import 'package:flutter/cupertino.dart';
import 'package:notes/model/notes.dart';
import 'package:notes/model/user.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBHelper {



  static Future<Database> databaseUsers() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'users.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE users(id TEXT PRIMARY KEY,name TEXT,password TEXT,email TEXT,image TEXT)');
    }, version: 1);
  }

  static Future<void> insertUser(
      String table, Map<String, dynamic> data) async {
    final db = await DBHelper.databaseUsers();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getUsersData(String table) async {
    final db = await DBHelper.databaseUsers();
    return db.query(table);
  }







  static Future<Database> databaseNotes() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'notes.db'),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE notes(userid TEXT PRIMARY KEY,placedatetime TEXT,text TEXT)');
        }, version: 1);
  }

  static Future<void> insertNote(
      String table, Map<String, dynamic> data) async {
    final db = await DBHelper.databaseNotes();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getNotesData(String table) async {
    final db = await DBHelper.databaseNotes();
    return db.query(table);
  }

}

class GetUsers extends ChangeNotifier{


  List<User> users=[];
  Future<void> fetchAndSetUsers() async {
    print('here');
    final dataList = await DBHelper.getUsersData('users');
    print('here1');
    users = dataList
        .map((e) => User(
        username: e["username"],
        password: e["password"],
        email: e["email"],
        imageAsBase64: e["imageAsBase64"],
        intrestId: e['username'],
        id: e['id']))
        .toList();
    //print('here2');
    notifyListeners();

  }



  List<Note> notes=[];
  Future<void> fetchAndSetNotes() async {
    print('here');
    final dataList = await DBHelper.getNotesData('notes');
    print('here1');
    notes = dataList
        .map((e) => Note(text: e['text'], placeDateTime:e[''], userId:e[''])).toList();
    //print('here2');
    notifyListeners();

  }

}
