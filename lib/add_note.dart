
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:notes/controller/note_controller.dart';

import 'package:notes/model/notes.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController noteController=TextEditingController();
  final key=GlobalKey<FormState>();
  final noteControllerr=Get.put(NoteController());



  /*void _addNote(){
    bool isValid=key.currentState!.validate();
    if(isValid){
     Provider.of<NotesProvider>(context,listen: false).insertNote(context, DateTime.now().toString(), noteController.text, DateTime.now().toString());
     // noteControllerr.insertNote(context, note)
    }else{
      return;
    }
  }*/
// 					"raw": "noteapi.popssolutions.net",

  // noteapi.popssolutions.net/notes/getall

  // https://noteapi.popssolutions.net/notes/insert

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add note'),
        actions: [
          Obx(()=>
          (noteControllerr.isLoading.value)?
              const Center(child: CircularProgressIndicator(),):
          IconButton(onPressed:(){
            if(key.currentState!.validate()){
              noteControllerr.insertNote(Note(text: noteController.text, placeDateTime: DateTime.now(), userId: "1")).then((value) {
                Navigator.of(context).pop();
                /*if(value!=null){
                  print('added');
                  noteController.text="";
                  Navigator.of(context).pop();
                }else{
                  print('null');
                }*/
              });

            }
          },icon:const Icon(Icons.save))
          )

        ],

      ),
      body: Container(
        child: Form(
          key: key,
          child: TextFormField(
            maxLines: 7,
            decoration: const InputDecoration(
              hintText: "add note"
            ),
            controller: noteController,
            validator: (value){
              if(value!.isEmpty){
                return "value can't be empty";
              }else if(value.length<5){
                return "value can't be less than 5 chars";
              }
            },
          ),
        ),
      ),
    );
  }
}
