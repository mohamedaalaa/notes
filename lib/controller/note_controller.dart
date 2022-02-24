import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes/api_services/api_srvice_note.dart';
import 'package:notes/database/database.dart';
import 'package:notes/model/notes.dart';

import 'package:notes/model/user.dart';
import 'package:provider/provider.dart';

class NoteController extends GetxController {
  var isLoading = false.obs;
  var noteList = <Note>[].obs;
  var usersList = <User>[].obs;

  /* Future<Note?> insertNote(BuildContext context,Note note)async{
    var url =Uri.parse("https://noteapi.popssolutions.net/notes/insert");

      //isLoading(true);
      var response = await http.post(url,body:json.encode({
        'text':note.text,
        'placeDateTime':note.placeDateTime,
        'userId':note.userId,
        'id':note.id
      }),
        headers: {
         HttpHeaders.contentTypeHeader:"application/json"
        }
      );
      var data=jsonDecode(response.body);
      print(data);
      Notes? notee;
      notee=Notes.fromJson(data);
      print(notee.text);
      return notee;

  }*/

  Future<void> insertNote(Note note) async {
    try {
      isLoading(true);
      await NotesApi().insertNote(note);
      await DBHelper.insertUser("users", {
        "userid": note.userId,
        "placedatetime": note.placeDateTime,
        "text": note.text
      });
      //return mNote;
    } finally {
      isLoading(false);
    }
  }

  Future<List<Note>?> getNotes(BuildContext context) async {
    try {
      isLoading(true);
      var notes = await NotesApi().getNotes(context);
      if (notes != null) {
        noteList.assignAll(notes);
        print(noteList.length);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> insertUser(User user) async {
    try {
      isLoading(true);
      await NotesApi().insertUser(user);
      await DBHelper.insertUser("users", {
        "id": user.id,
        "name": user.username,
        "password": user.password,
        "email": user.email,
        "image": user.imageAsBase64,
      });
      //return mNote;
    } finally {
      isLoading(false);
    }
  }

  Future<List<User>?> getUsers(BuildContext context) async {
    try {
      isLoading(true);
      var users = await NotesApi().getAllUsers();
      if (users != null) {
        usersList.assignAll(users);
        print(usersList.length);
      }
    } finally {
      isLoading(false);
    }
  }
}
