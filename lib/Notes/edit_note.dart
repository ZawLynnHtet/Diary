import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:law_diary/Notes/notes.dart';
import 'package:law_diary/common.dart';

import '../API/api.dart';

class EditNote extends StatefulWidget {
  String categoryId;
  String editData;
  String userId;
  EditNote(
      {super.key,
      required this.categoryId,
      required this.editData,
      required this.userId});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  bool isLoading = false;

  var editData;

  initData() {
    print(">>>>>> editdata");
    editData = jsonDecode(widget.editData);
    print(">>>>>>>>>>>> edit data $editData");

    setState(() {
      if (editData != null) {
        _titleController.text = editData["title"] ?? '';
        _noteController.text = editData["notes"] ?? '';
      }
    });
  }

  @override
  void initState() {
    initData();
    super.initState();
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
                  userId: widget.userId,
                  categoryId: widget.categoryId,
                ),
              ),
            );
          },
        ),
        title: Text(
          'မှတ်ချက်ပြုပြင်ရန်',
          style: GoogleFonts.poppins(
            fontSize: 17,
            color: darkmain,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotesScreen(
                userId: widget.userId,
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
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: MaterialButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    color: btncolor,
                    // onPressed: uploadFile,
                    onPressed: () {
                      if (_titleController.text.isEmpty) {
                        showToast(context, 'Please Enter Title!!', Colors.red);
                      } else if (_noteController.text.isEmpty) {
                        showToast(context, 'Please Enter Note!!', Colors.red);
                      } else {
                        updateNote(widget.userId);
                      }
                    },
                    child: isLoading
                        ? const SpinKitRing(
                            size: 23,
                            lineWidth: 3,
                            color: Colors.black,
                          )
                        : Text(
                            'Update',
                            style: GoogleFonts.poppins(
                                color: seccolor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateNote(userId) async {
    isLoading = true;
    final response = await API().editNoteApi(
      userId,
      editData["noteId"].toString(),
      _titleController.text,
      _noteController.text,
    );
    print("hererere");
    var res = jsonDecode(response.body);
    print(">>>>>>>>>>> edit note response statusCode ${response.statusCode}");
    print(">>>>>>>>>>> edit note response body ${response.body}");
    if (response.statusCode == 200) {
      print("herer 0--");
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotesScreen(
            categoryId: widget.categoryId,
            userId: widget.userId,
          ),
        ),
      );
      showToast(context, res['message'], Colors.green);
    } else if (response.statusCode == 400) {
      // ignore: use_build_context_synchronously
      showToast(context, res['message'], Colors.red);
    }
    setState(() {
      isLoading = false;
    });
  }
}
