import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes/model/notes.dart';
import 'package:http/http.dart' as http;
import 'package:notes/model/user.dart';

class NotesApi {
  Future<Note?> insertNote(Note note) async {
    var url = Uri.parse("https://noteapi.popssolutions.net/notes/insert");

    var response = await http.post(url,
        body: json.encode(

            //note.toJson()
            {
              "Text": note.text,
              "PlaceDateTime": note.placeDateTime.toIso8601String(),
              "UserId": note.userId,

              //"id":note.id
            }),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
    /* print(response.body);
      var data=jsonDecode(response.body);
      print(data);
      Note? noteModel;
      noteModel=Note.fromJson(data);

      return noteModel;*/
  }

  Future<List<Note>?> getNotes(BuildContext context) async {
    var url = Uri.parse("https://noteapi.popssolutions.net/notes/getall");
    var response = await http.get(url);

    var jsonResult = jsonDecode(response.body);
    print(jsonResult);
    List<Note>? notes;
    notes = List<Note>.from(jsonResult.map((x) => Note.fromJson(x)));
    return notes;
  }

  Future<User?> insertUser(User user) async {
    var url = Uri.parse("https://noteapi.popssolutions.net/users/insert");
    var response = await http.post(url,
        body: json.encode(

            //note.toJson()
            {
              "Username": user.username,
              "Password": user.password,
              "Email": user.email,
              "ImageAsBase64": user.imageAsBase64
            }),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
  }

  Future<List<User>?> getAllUsers() async {
    var url = Uri.parse("https://noteapi.popssolutions.net/users/getall");
    var response = await http.get(url);
    var jsonResult = jsonDecode(response.body);
    print(jsonResult);
    List<User>? users;
    users = List<User>.from(jsonResult.map((x) => User.fromJson(x)));
    return users;
  }
}
