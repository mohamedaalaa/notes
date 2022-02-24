import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/controller/note_controller.dart';
import 'package:notes/model/user.dart';
import 'package:notes/screens/settings.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({Key? key}) : super(key: key);

  @override
  _AddPersonState createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String base64File = "";
  File? _storedImage;
  final controller = Get.put(NoteController());
  final key = GlobalKey<FormState>();

  Future pickImage() async {
    File? _image1;
    XFile _imageFile;
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    _imageFile = image!;
    _image1 = File(_imageFile.path);
    List<int> fileUnit8 = _image1.readAsBytesSync();

    setState(() {
      base64File = base64.encode(fileUnit8);
      print(base64File);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("add user"),
        actions: [
          Row(
            children: [
              Obx(() => (controller.isLoading.value)
                  ? const CircularProgressIndicator(
                      color: Colors.purple,
                    )
                  : IconButton(
                      onPressed: () {
                        if (key.currentState!.validate() && base64File != "") {
                          controller
                              .insertUser(User(
                                  username: nameController.text,
                                  password: passwordController.text,
                                  email: emailController.text,
                                  imageAsBase64: base64File,
                                  intrestId: "1",
                                  id: "1"))
                              .then((value) {
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      icon: const Icon(Icons.save))),
              const SizedBox(
                width: 4,
              ),
              IconButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Settings())),
                  icon: const Icon(Icons.settings))
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 30,
                  child: base64File == ""
                      ? const Icon(Icons.person)
                      : ClipRect(
                          child: Image.memory(
                          base64.decode(base64File),
                          fit: BoxFit.cover,
                        )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "name can't be empty";
                  } else if (value.length < 5) {
                    return "name can't be less than 5 chars";
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "email can't be empty";
                  } else if (value.length < 5) {
                    return "email can't be less than 5 chars";
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(hintText: 'password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "password can't be empty";
                  } else if (value.length < 5) {
                    return "password can't be less than 5 chars";
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
