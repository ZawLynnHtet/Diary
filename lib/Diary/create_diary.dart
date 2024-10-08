import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/Diary/daily_diary.dart';
import 'package:law_diary/common.dart';

class CreateDiary extends StatefulWidget {
  const CreateDiary({super.key});

  @override
  State<CreateDiary> createState() => _CreateDiaryState();
}

class _CreateDiaryState extends State<CreateDiary> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _caseController = TextEditingController();
  final TextEditingController _caseNumController = TextEditingController();
  final TextEditingController _caseTypeController = TextEditingController();
  final TextEditingController _startdateController = TextEditingController();
  final TextEditingController _appointmentController = TextEditingController();
  final TextEditingController _actionsController = TextEditingController();
  final TextEditingController _toDoController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _attachmentNameController =
      TextEditingController();
  final TextEditingController _atachmentFileController =
      TextEditingController();

  bool isLoading = false;
  DateTime? picked;

  String pdffile = '';
  String pdfvalue = '';

  Future uploadFile() async {
    isLoading = true;
    if (pdffile.isNotEmpty) {
      Reference ref =
          FirebaseStorage.instance.ref().child('files').child(pdfvalue);
      UploadTask uploadTask = ref.putFile(File(pdffile));

      await uploadTask.whenComplete(() async {
        print('PDF Uploaded');
        var fileURL = await ref.getDownloadURL();
        print(fileURL);
        createDiary(fileURL);
      });
    }
  }

  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        pdfvalue = result.files.single.name;
        pdffile = result.files.single.path!;
        print(pdfvalue);
        print(pdffile);
      });
    }
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
                builder: (context) => const DailyDiaryPage(),
              ),
            );
          },
        ),
        title: Text(
          'နေ့စဉ်မှတ်တမ်း',
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
              builder: (context) => const DailyDiaryPage(),
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
                      labelText: 'အမှုနံပါတ်',
                      labelStyle: TextStyle(color: fifthcolor),
                      // border: InputBorder.none,
                    ),
                    controller: _caseNumController,
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
                      labelText: 'အမှု',
                      labelStyle: TextStyle(color: fifthcolor),
                      // border: InputBorder.none,
                    ),
                    controller: _caseController,
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
                      labelText: 'အမှုသည်',
                      labelStyle: TextStyle(color: fifthcolor),
                      // border: InputBorder.none,
                    ),
                    controller: _nameController,
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
                      labelText: 'အမှုအမျိုးအစား',
                      labelStyle: TextStyle(color: fifthcolor),
                      // border: InputBorder.none,
                    ),
                    controller: _caseTypeController,
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    onTap: () {
                      _DateDialog();
                    },
                    style: TextStyle(color: backcolor),
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: fifthcolor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: fifthcolor),
                      ),
                      labelText: 'နေ့စွဲ',
                      labelStyle: TextStyle(color: fifthcolor),
                      // border: InputBorder.none,
                    ),
                    controller: _startdateController,
                    validator: (value) {
                      return value!.isEmpty ? 'Please Enter Start Date!' : null;
                    },
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
                      labelText: 'ဆောင်ရွက်ချက်',
                      labelStyle: TextStyle(color: fifthcolor),
                      // border: InputBorder.none,
                    ),
                    controller: _toDoController,
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    onTap: () {
                      _pickDateDialog();
                    },
                    style: TextStyle(color: backcolor),
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: fifthcolor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: fifthcolor),
                      ),
                      labelText: 'ရုံးချိန်းရက်',
                      labelStyle: TextStyle(color: fifthcolor),
                      // border: InputBorder.none,
                    ),
                    controller: _appointmentController,
                    validator: (value) {
                      return value!.isEmpty
                          ? 'Please Enter Appointment!'
                          : null;
                    },
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
                      labelText: 'ဆောင်ရွက်ရန်',
                      labelStyle: TextStyle(color: fifthcolor),
                      // border: InputBorder.none,
                    ),
                    controller: _actionsController,
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
                    controller: _notesController,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              pdfvalue != ""
                  ? Container(
                      color: darkmain,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Image.asset(
                            "images/pdfforview.png",
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              pdfvalue,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              pdfvalue != ""
                  ? const SizedBox(
                      height: 15,
                    )
                  : Container(),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectFile();
                        setState(() {});
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: darkmain,
                        ),
                        child: Center(
                          child: Text(
                            'Select File',
                            style: GoogleFonts.poppins(
                              color: seccolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (_caseNumController.text == "") {
                          showToast(context, "အမှုနံပါတ်ထည့်ပါ!!", Colors.red);
                        } else if (_caseController.text == "") {
                          showToast(context, "အမှုထည့်ပါ", Colors.red);
                        } else if (_nameController.text == "") {
                          showToast(context, "အမှုသည်နာမည်ထည့်ပါ", Colors.red);
                        } else if (_caseTypeController.text == "") {
                          showToast(
                              context, "အမှုအမျိုးအစားထည့်ပါ", Colors.red);
                        } else if (_startdateController.text == "") {
                          showToast(context, "နေ့စွဲထည့်ပါ", Colors.red);
                        } else if (_toDoController.text == "") {
                          showToast(context, "ဆောင်ရွက်ချက်ထည့်ပါ", Colors.red);
                        } else if (_appointmentController.text == "") {
                          showToast(context, "ရုံးချိန်းရက်ထည့်ပါ", Colors.red);
                        } else if (_actionsController.text == "") {
                          showToast(context, "ဆောင်ရွက်ရန်ထည့်ပါ", Colors.red);
                        } else if (_notesController.text == "") {
                          showToast(context, "မှတ်ချက်ထည့်ပါ", Colors.red);
                        } else {
                          setState(() {
                            uploadFile();
                          });
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: darkmain,
                        ),
                        child: isLoading
                            ? const SpinKitRing(
                                size: 23,
                                lineWidth: 3,
                                color: Colors.black,
                              )
                            : Center(
                                child: Text(
                                  'Create',
                                  style: GoogleFonts.poppins(
                                    color: seccolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: darkmain,
              //   ),
              //   onPressed: () {
              //     selectFile();
              //     setState(() {});
              //   },
              //   child: Text(
              //     'Select File',
              //     style: GoogleFonts.poppins(
              //       color: seccolor,
              //     ),
              //   ),
              // ),
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
              //         if (_caseNumController.text == "") {
              //           showToast(context, "အမှုနံပါတ်ထည့်ပါ!!", Colors.red);
              //         } else if (_caseController.text == "") {
              //           showToast(context, "အမှုထည့်ပါ", Colors.red);
              //         } else if (_nameController.text == "") {
              //           showToast(context, "အမှုသည်နာမည်ထည့်ပါ", Colors.red);
              //         } else if (_caseTypeController.text == "") {
              //           showToast(context, "အမှုအမျိုးအစားထည့်ပါ", Colors.red);
              //         } else if (_startdateController.text == "") {
              //           showToast(context, "နေ့စွဲထည့်ပါ", Colors.red);
              //         } else if (_toDoController.text == "") {
              //           showToast(context, "ဆောင်ရွက်ချက်ထည့်ပါ", Colors.red);
              //         } else if (_appointmentController.text == "") {
              //           showToast(context, "ရုံးချိန်းရက်ထည့်ပါ", Colors.red);
              //         } else if (_actionsController.text == "") {
              //           showToast(context, "ဆောင်ရွက်ရန်ထည့်ပါ", Colors.red);
              //         } else if (_notesController.text == "") {
              //           showToast(context, "မှတ်ချက်ထည့်ပါ", Colors.red);
              //         } else {
              //           setState(() {
              //             uploadFile();
              //           });
              //         }
              //       },
              //       child: isLoading
              //           ? const SpinKitRing(
              //               size: 23,
              //               lineWidth: 3,
              //               color: Colors.black,
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
              // const SizedBox(
              //   height: 30,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  String diaryId = "";

  createDiary(pdffile) async {
    isLoading = true;
    final response = await API().createDiaryApi(
      _caseNumController.text,
      _caseController.text,
      _nameController.text,
      _caseTypeController.text,
    );
    print("hererere");
    var res = jsonDecode(response.body);
    var data = res['data'];
    print('+++++++++++++${data}');

    diaryId = data['diaryId'];
    print("========$diaryId");
    if (diaryId != '') {
      createDetails(diaryId, pdffile);
    }
    // createAttachment();
    // print(
    //     ">>>>>>>>>>> create diary response statusCode ${response.statusCode}");
    // print(">>>>>>>>>>> create diary response body ${response.body}");
    if (response.statusCode == 200) {
      print("herer 0--");
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DailyDiaryPage(),
        ),
      );
    } else if (response.statusCode == 500) {
      showToast(context, res['message'], Colors.red);
    }
    setState(() {
      isLoading = false;
    });
  }

  // createAttachment() async {
  //   print('begin<<<<<<<>>>>>><<<<<>>>>>>>><<<<<<<>...>>>>>>>');
  //   final response = await API().createAttachmentApi(
  //     _attachmentNameController,
  //     _atachmentFileController,
  //   );
  //   print("hererere");
  //   var res = jsonDecode(response.body);
  //   print(
  //       ">>>>>>>>>>> create attachemnt response statusCode ${response.statusCode}");
  //   print(">>>>>>>>>>> create attachment response body ${response.body}");

  //   if (response.statusCode == 200) {
  //     print("herer 0--");
  //   } else if (response.statusCode == 500) {
  //     showToast(context, res['message'], Colors.red);
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  //   setState(() {
  //     isLoading = false;
  //   });
  //   print('end>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>');
  // }

  createDetails(id, pdffile) async {
    isLoading = true;
    final response = await API().createDiaryDetailsApi(
      id,
      _startdateController.text,
      _appointmentController.text,
      _actionsController.text,
      _toDoController.text,
      _notesController.text,
      pdffile,
      fcmtoken,
    );
    print("hererere");
    var res = jsonDecode(response.body);
    print(
        ">>>>>>>>>>> create diary response statusCode ${response.statusCode}");
    print(">>>>>>>>>>> create diary response body ${response.body}");

    if (response.statusCode == 200) {
      print("herer 0--");
      // ignore: use_build_context_synchronously
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => DailyDiary(
      //       userId: widget.userId,
      //     ),
      //   ),
      // );
    } else if (response.statusCode == 500) {
      showToast(context, res['message'], Colors.red);
    }
    setState(() {
      isLoading = false;
    });
    setState(() {
      isLoading = false;
    });
  }

  void _pickDateDialog() async {
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        // _start_dateController.text = '${picked!.year} - ${picked!.month} ${picked!.day}';
        _appointmentController.text = DateFormat('yyyy-MM-dd').format(picked!);
      });
    }
  }

  void _DateDialog() async {
    print("-------");
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1000),
      lastDate: DateTime(2100),
    );
    print('-----++++++');
    if (picked != null) {
      print('00000000');
      setState(() {
        // _start_dateController.text = '${picked!.year} - ${picked!.month} ${picked!.day}';
        _startdateController.text = DateFormat('yyyy-MM-dd').format(picked!);
        print(_startdateController);
      });
    }
  }
}
