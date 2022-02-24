import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/add_note.dart';
import 'package:notes/controller/note_controller.dart';
import 'package:notes/database/database.dart';
import 'package:notes/model/notes.dart';
import 'package:notes/screens/notes_list.dart';
import 'package:notes/screens/users_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>GetUsers(),
      child: MaterialApp(
          title: 'Flutter Demo',
          home: const NotesList(),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final noteControllerr=Get.put(NoteController());

  @override
  void initState() {
    super.initState();
    noteControllerr.getNotes(context);
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title:const Text('Notes'),),
      body: Container(
        height: height,
        width: width,
        child: Obx(()=>
        (noteControllerr.isLoading.value)?
            const Center(child: CircularProgressIndicator(),):
        (noteControllerr.isLoading.value==false && noteControllerr.noteList.isEmpty)?
            const Center(child: Text('no notes yet'),):
            ListView.builder(itemCount: noteControllerr.noteList.length
                ,itemBuilder: (context,i){
                   return Padding(
                     padding: const EdgeInsets.all(10),
                     child: ListTile(
                       title: Text(noteControllerr.noteList[i].text),
                     ),
                   );
                })


        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNote()));
        },
      ),
    );
  }
}
