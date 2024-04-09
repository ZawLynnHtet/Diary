import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:law_diary/Diary/daily_diary.dart';
import 'package:law_diary/Diary/diary_details.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/main.dart';

import '../API/api.dart';

class CreateDiaryDetails extends StatefulWidget {
  String diaryId;
  String userId;
  CreateDiaryDetails({super.key, required this.diaryId, required this.userId});

  @override
  State<CreateDiaryDetails> createState() => _CreateDiaryDetailsState();
}

class _CreateDiaryDetailsState extends State<CreateDiaryDetails> {
  final TextEditingController _startdateController = TextEditingController();
  final TextEditingController _appointmentController = TextEditingController();
  final TextEditingController _actionsController = TextEditingController();
  final TextEditingController _toDoController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  bool isLoading = false;
  DateTime? picked;

  @override
  void initState() {
    super.initState();
    print('>>>>><<<<<diaryId>>>>>${widget.diaryId}');
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
                builder: (context) => DiaryDetails(
                  diaryId: widget.diaryId,
                  userId: widget.userId,
                ),
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
              builder: (context) => DiaryDetails(
                diaryId: widget.diaryId,
                userId: widget.userId,
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
                      labelText: 'ဆောင်ရွက်ချက်',
                      labelStyle: TextStyle(color: fifthcolor),
                      // border: InputBorder.none,
                    ),
                    controller: _toDoController,
                  ),
                ),
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
                    color: darkmain,
                    onPressed: () {
                      if (_startdateController.text == "") {
                        showToast(context, "နေ့စွဲထည့်ပါ", Colors.red);
                      } else if (_appointmentController.text == "") {
                        showToast(context, "ရုံးချိန်းရက်ထည့်ပါ", Colors.red);
                      } else if (_actionsController.text == "") {
                        showToast(context, "ဆောင်ရွက်ရန်ထည့်ပါ", Colors.red);
                      } else if (_toDoController.text == "") {
                        showToast(context, "ဆောင်ရွက်ချက်ထည့်ပါ", Colors.red);
                      } else {
                        setState(() {
                          createDiaryDetails();
                        });
                      }
                    },
                    child: isLoading
                        ? const SpinKitRing(
                            size: 23,
                            lineWidth: 3,
                            color: Colors.black,
                          )
                        : Text(
                            'Create',
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

  createDiaryDetails() async {
    isLoading = true;
    final response = await API().createDiaryDetailsApi(
      widget.diaryId,
      _startdateController.text,
      _appointmentController.text,
      _actionsController.text,
      _toDoController.text,
      _notesController.text,
    );
    print("hererere");
    var res = jsonDecode(response.body);
    print(
        ">>>>>>>>>>> create diary details response statusCode ${response.statusCode}");
    print(">>>>>>>>>>> create diary details response body ${response.body}");
    if (response.statusCode == 200) {
      print("herer 0--");
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiaryDetails(
            userId: widget.userId,
            diaryId: widget.diaryId,
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