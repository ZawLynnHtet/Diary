import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/common.dart';
import 'notes.dart';

class CreateNote extends StatefulWidget {
  final String categoryId;
  const CreateNote({super.key, required this.categoryId});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String date = DateTime.now().toString();
  bool isLoading = false;
  var imagefile;
  var imagevalue;
  ImagePicker picker = ImagePicker();

  Future uploadFile() async {
    isLoading = true;
    XFile file = imagefile;
    Reference ref =
        FirebaseStorage.instance.ref().child("images").child("$imagevalue.jpg");
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
        createNote(imageURL);
      });
    });
  }

  getMainImage() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thirdcolor,
      appBar: AppBar(
        backgroundColor: thirdcolor,
        elevation: 0,
        leading: BackButton(
          color: darkmain,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotesScreen(
                  categoryId: widget.categoryId,
                ),
              ),
            );
          },
        ),
        title: Text(
          'မှတ်ချက်ထည့်ရန်',
          style: GoogleFonts.poppins(
            fontSize: 17,
            color: darkmain,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (_titleController.text == "") {
                showToast(context, "ခေါင်းစဉ်ထည့်ပါ", Colors.red);
              } else {
                setState(() {
                  uploadFile();
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 6, 5, 6),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: isLoading
                      ? SpinKitRing(
                          size: 23,
                          lineWidth: 3,
                          color: maincolor,
                        )
                      : Text(
                          'Done',
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                ),
              ),
            ),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotesScreen(
                categoryId: widget.categoryId,
              ),
            ),
          );
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                  bottom: 10,
                  left: 15,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    style: TextStyle(color: backcolor),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: fifthcolor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: fifthcolor),
                      ),
                      labelText: 'ခေါင်းစဉ်',
                      labelStyle: TextStyle(color: fifthcolor),
                      // border: InputBorder.none,
                    ),
                    controller: _titleController,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                  bottom: 10,
                  left: 15,
                ),
                child: Container(
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   border: Border.all(color: Colors.black),
                  //   borderRadius: BorderRadius.circular(12),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextFormField(
                      style: TextStyle(color: backcolor),
                      keyboardType: TextInputType.name,
                      minLines: 1,
                      maxLines: 20,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: fifthcolor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: fifthcolor),
                        ),
                        labelText: 'မှတ်ချက်',
                        labelStyle: TextStyle(color: fifthcolor),
                        // border: InputBorder.none,
                      ),
                      controller: _noteController,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              if (imagevalue != null)
                Image.file(
                  File(imagevalue),
                  // width: 100,
                  fit: BoxFit.cover,
                ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkmain,
                ),
                onPressed: getMainImage,
                child: Text(
                  'Select File',
                  style: GoogleFonts.poppins(
                    color: seccolor,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20.0),
              //   child: SizedBox(
              //     width: MediaQuery.of(context).size.width - 30,
              //     height: MediaQuery.of(context).size.height * 0.06,
              //     child: MaterialButton(
              //       elevation: 0,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(6),
              //       ),
              //       color: darkmain,
              //       onPressed: () {
              //         if (_titleController.text == "") {
              //           showToast(context, "ခေါင်းစဉ်ထည့်ပါ", Colors.red);
              //         } else {
              //           setState(() {
              //             uploadFile();
              //           });
              //         }
              //       },
              //       child: isLoading
              //           ? SpinKitRing(
              //               size: 23,
              //               lineWidth: 3,
              //               color: seccolor,
              //             )
              //           : Text(
              //               'Create',
              //               style: GoogleFonts.poppins(
              //                   color: seccolor,
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.w500),
              //             ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  createNote(attachment) async {
    isLoading = true;
    final response = await API().createNoteApi(
      widget.categoryId,
      _titleController.text,
      _noteController.text,
      attachment,
    );
    print("hererere");
    var res = jsonDecode(response.body);
    print(">>>>>>>>>>> create note response statusCode ${response.statusCode}");
    print(">>>>>>>>>>> create note response body ${response.body}");
    if (response.statusCode == 200) {
      print("herer 0--");
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotesScreen(
            categoryId: widget.categoryId,
          ),
        ),
      );
    } else if (response.statusCode == 400) {
      showToast(context, res['message'], Colors.red);
    }
    setState(() {
      isLoading = false;
    });
  }
}
