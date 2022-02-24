import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/note_controller.dart';
import 'package:notes/database/database.dart';
import 'package:notes/screens/users_list.dart';
import 'package:notes/utils.dart';
import 'package:provider/provider.dart';

import '../add_note.dart';

class NotesList extends StatefulWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  final noteControllerr = Get.put(NoteController());

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
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const UsersList())),
          )
        ],
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: isSwitched
            ? FutureBuilder(
                future: Provider.of<GetUsers>(context, listen: false)
                    .fetchAndSetNotes(),
                builder: (context, snapshot) => snapshot.connectionState ==
                        ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Consumer<GetUsers>(
                        builder: (context, getNotes, ch) => getNotes
                                .notes.isEmpty
                            ? const Center(child: Text('no notes yet'))
                            : ListView.builder(
                                itemCount: getNotes.notes.length,
                                itemBuilder: (context, i) => ListTile(
                                      title: Text(getNotes.users[i].username),
                                    ))),
              )
            : Obx(() => (noteControllerr.isLoading.value)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (noteControllerr.isLoading.value == false &&
                        noteControllerr.noteList.isEmpty)
                    ? const Center(
                        child: Text('no notes yet'),
                      )
                    : ListView.builder(
                        itemCount: noteControllerr.noteList.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(noteControllerr.noteList[i].text),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Divider(
                                  thickness: 2,
                                )
                              ],
                            ),
                          );
                        })),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddNote()));
        },
      ),
    );
  }
}
