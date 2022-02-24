import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<Note> noteFromJson(String str) => List<Note>.from(json.decode(str).map((x) => Note.fromJson(x)));

String noteToJson(List<Note> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Note {
  Note({
    required this.text,
    required this.placeDateTime,
    required this.userId,
    //required this.id,
  });

  String text;
  DateTime placeDateTime;
  String userId;
  //String id;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    text: json["text"],
    placeDateTime: DateTime.parse(json["placeDateTime"]),
    userId: json["userId"] ?? "1",
    //id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "placeDateTime": placeDateTime.toIso8601String(),
    "userId": userId,
    //"id": id,
  };
}

/*
class NotesProvider extends ChangeNotifier {
  Future<void> insertNote(BuildContext context, String userId, String notee,
      String dateTime) async {
    var url = Uri.parse("https://noteapi.popssolutions.net/notes/insert");
    try {
      var response = await http.post(url,
          body: json.encode(
              {"UserId": userId, "Text": notee, "PlaceDateTime": dateTime}),
          headers: {HttpHeaders.contentTypeHeader: "application/json"});
      var jsonResults = jsonDecode(response.body);
      Notes? note;
      var data = jsonResults;
      print(data);
    } catch (e) {
      print(e);
    }
  }
}*/
