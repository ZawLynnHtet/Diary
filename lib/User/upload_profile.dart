import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/drawer.dart';
import 'package:law_diary/home.dart';

class UploadProfile extends StatefulWidget {
  const UploadProfile({super.key});

  @override
  State<UploadProfile> createState() => _UploadProfileState();
}

class _UploadProfileState extends State<UploadProfile> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool isLoading = false;

  var imagefile;
  var imagevalue;
  ImagePicker picker = ImagePicker();

  Future uploadFile() async {
    isLoading = true;
    XFile file = imagefile;
    Reference ref =
        FirebaseStorage.instance.ref().child("profile_images").child("$imagevalue.jpg");
    print(">>>>>>> ref $ref");
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    print(">>>>>>> metadata $metadata");
    var uploadTask = ref.putData(await file.readAsBytes(), metadata);
    print(">>>>>>> uploadTask $uploadTask");
    setState(() {
      uploadTask.whenComplete(() async {
        var imageURL = await ref.getDownloadURL();
        print("><< image url $imageURL");
        updateUser(imageURL);
      });
    });
  }

  getImageFromGallery() async {
    final XFile? pickedFile = (await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 100,
    ));
    late XFile tem;
    tem = pickedFile!;
    imagefile = tem;
    imagevalue = pickedFile.path;
    setState(() {});
  }

  getImageFromCamera() async {
    final XFile? pickedFile = (await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 100,
    ));
    late XFile tem;
    tem = pickedFile!;
    imagefile = tem;
    imagevalue = pickedFile.path;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thirdcolor,
      appBar: AppBar(
        backgroundColor: thirdcolor,
        elevation: 0,
      ),
      drawer: const DrawerPage(),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
          return false;
        },
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      getImageFromGallery();
                    },
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(color: maincolor),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(80)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: imagevalue == null
                            ? Container(
                                margin: EdgeInsets.all(10),
                                child: Image.asset(
                                  'images/userprofile.png',
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.file(
                                File(imagevalue),
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Form(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: btncolor,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: 'Enter Name',
                            border: InputBorder.none,
                          ),
                          controller: _nameController,
                          validator: (value) {
                            return value!.isEmpty ? 'Please enter Name?' : null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: btncolor,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: 'Enter Email',
                            border: InputBorder.none,
                          ),
                          controller: _emailController,
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Please enter Email?'
                                : null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_nameController.text == "") {
                        showToast(context, "Enter Name", Colors.red);
                      } else if (_emailController.text == "") {
                        showToast(context, "Enter Email", Colors.red);
                      } else {
                        setState(() {
                          uploadFile();
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: btncolor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      child: Center(
                        child: isLoading
                            ? const SpinKitRing(
                                size: 23,
                                lineWidth: 3,
                                color: Colors.black,
                              )
                            : Text(
                                'Confirm',
                                style: TextStyle(
                                  color: seccolor,
                                  fontSize: 15,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  updateUser(profile) async {
    isLoading = true;
    final response = await API().updateUser(
      _emailController.text,
      _nameController.text,
      profile,
      userID,
    );
    var res = jsonDecode(response.body);
    showToast(context, res['message'],
        res.statusCode == 200 ? Colors.green : Colors.red);
    setState(() {
      isLoading = false;
    });
  }
}
