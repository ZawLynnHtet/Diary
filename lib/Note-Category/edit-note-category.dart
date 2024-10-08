import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/Note-Category/note-category.dart';
import 'package:law_diary/common.dart';

class EditNoteCategory extends StatefulWidget {
  final String editData;
  const EditNoteCategory({super.key, required this.editData});

  @override
  State<EditNoteCategory> createState() => _EditNoteCategoryState();
}

class _EditNoteCategoryState extends State<EditNoteCategory> {
  final TextEditingController _categorynameController = TextEditingController();
  bool isLoading = false;
  var editData;

  initData() {
    print(">>>>>> editdata");
    editData = jsonDecode(widget.editData);
    print(">>>>>>>>>>>> edit data $editData");
    setState(() {
      if (editData != null) {
        _categorynameController.text = editData["categoryName"] ?? '';
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NoteCategoryScreen(),
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
        actions: [
          GestureDetector(
            onTap: () {
              if (_categorynameController.text.isEmpty) {
                showToast(context, 'Please Enter Category Name!!', Colors.red);
              } else {
                updateNoteCategory();
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
                          'Edit',
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NoteCategoryScreen(),
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
                      minLines: 1,
                      maxLines: 10,
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
                      controller: _categorynameController,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
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
              //         if (_categorynameController.text.isEmpty) {
              //           showToast(context, 'Please Enter Category Name!!',
              //               Colors.red);
              //         } else {
              //           updateNoteCategory();
              //         }
              //       },
              //       child: isLoading
              //           ? const SpinKitRing(
              //               size: 23,
              //               lineWidth: 3,
              //               color: Colors.black,
              //             )
              //           : Text(
              //               'Update',
              //               style: GoogleFonts.poppins(
              //                   color: maincolor,
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

  updateNoteCategory() async {
    isLoading = true;
    final response = await API().editNoteCategoryApi(
      editData["categoryId"].toString(),
      _categorynameController.text,
    );
    print("hererere");
    var res = jsonDecode(response.body);
    print(
        ">>>>>>>>>>> edit note category response statusCode ${response.statusCode}");
    print(">>>>>>>>>>> edit note category response body ${response.body}");
    if (response.statusCode == 200) {
      print("herer 0--");
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NoteCategoryScreen(),
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
