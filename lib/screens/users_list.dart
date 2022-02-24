import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:notes/controller/note_controller.dart';
import 'package:notes/database/database.dart';
import 'package:notes/screens/add_person.dart';
import 'package:notes/screens/settings.dart';
import 'package:notes/utils.dart';
import 'package:provider/provider.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final noteController = Get.put(NoteController());
  bool local=isSwitched;

  @override
  void initState() {
    noteController.getUsers(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('users'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AddPerson())),
              icon: const Icon(Icons.person))
        ],
      ),
      body:local? FutureBuilder(
        future: Provider.of<GetUsers>(context,listen: false).fetchAndSetUsers(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            :
            Consumer<GetUsers>(builder: (context,getUsers,ch)=>getUsers.users.isEmpty?const Center(child: Text('no users yet')):
                ListView.builder(itemCount: getUsers.users.length,itemBuilder: (context,i)=>ListTile(title: Text(getUsers.users[i].username),))
      ),
      ):Obx(()=>
      (noteController.isLoading.value)?
      const Center(child: CircularProgressIndicator(),):
      (noteController.isLoading.value==false && noteController.usersList.isEmpty)?
      const Center(child: Text('no users yet'),):
      ListView.builder(
          itemCount: noteController.usersList.length,
          itemBuilder:(context,i){
            return ListTile(
              leading: CircleAvatar(
                radius:30,
                child:noteController.usersList[i].imageAsBase64==""?const Icon(Icons.person):ClipRect(child: Image.memory(base64.decode(noteController.usersList[i].imageAsBase64),fit: BoxFit.cover,)),
              ),
              title: Text(noteController.usersList[i].username),
            );
          })
      )
    );
  }
}
