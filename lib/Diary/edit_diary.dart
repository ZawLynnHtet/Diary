import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:law_diary/Diary/diary_details.dart';
import 'package:law_diary/Note-Category/note-category.dart';

import '../API/api.dart';
import '../common.dart';

class EditDiary extends StatefulWidget {
  String diaryId;
  String editData;
  String userId;
  EditDiary({super.key, required this.editData, required this.userId, required this.diaryId});

  @override
  State<EditDiary> createState() => _EditDiaryState();
}

class _EditDiaryState extends State<EditDiary> {
  // final TextEditingController _caseController = TextEditingController();
  // final TextEditingController _caseNumController = TextEditingController();
  final TextEditingController _startdateController = TextEditingController();
  final TextEditingController _appointmentController = TextEditingController();
  final TextEditingController _actionsController = TextEditingController();
  final TextEditingController _toDoController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  bool isLoading = false;
  DateTime? picked;
  var editData;

  initData() {
    print(">>>>>> editdata");
    editData = jsonDecode(widget.editData);
    print(">>>>>>>>>>>> edit data $editData");

    setState(() {
      if (editData != null) {
        _startdateController.text = editData["startDate"] ?? '';
        _appointmentController.text = editData["appointment"] ?? '';
        _actionsController.text = editData["actions"] ?? '';
        _toDoController.text = editData["toDo"] ?? '';
        _notesController.text = editData["notes"] ?? '';
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
        elevation: 0,
        centerTitle: true,
        backgroundColor: thirdcolor,
        iconTheme: IconThemeData(
          color: maincolor,
          size: 30,
        ),
        title: Text(
          "အမှုအသေးစိတ်",
          style: GoogleFonts.poppins(
            fontSize: 17,
            color: maincolor,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                    return value!.isEmpty ? 'Please Enter Appointment!' : null;
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
                      showToast(context, "နေ့စွဲထည့်ပါ!!", Colors.red);
                    } else if (_appointmentController.text == "") {
                      showToast(context, "ရုံးချိန်းရက်ထည့်ပါ", Colors.red);
                    } else if (_actionsController.text == "") {
                      showToast(context, "ဆောင်ရွက်ရန်ထည့်ပါ", Colors.red);
                    } else if (_toDoController.text == "") {
                      showToast(context, "ဆောင်ရွက်ချက်ထည့်ပါ", Colors.red);
                    } else {
                      setState(() {
                        updateDiary();
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
                          'Update',
                          style: GoogleFonts.poppins(
                              color: maincolor,
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
    );
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

  updateDiary() async {
    print(">>>>>>>>>>> name");
    // print(_caseController.text);
    isLoading = true;
    final response = await API().editDetailsDiaryApi(
      widget.diaryId,
      editData["detailsId"].toString(),
      _startdateController.text,
      _appointmentController.text,
      _actionsController.text,
      _toDoController.text,
      _notesController.text,
    );
    print("hererere");
    var res = jsonDecode(response.body);
    print(">>>>>>>>>>> edit diary response statusCode ${response.statusCode}");
    print(">>>>>>>>>>> edit diary response body ${response.body}");
    print(editData['diaryId']);
    if (response.statusCode == 200) {
      print("herer 0--");
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiaryDetails(
            userId: widget.userId,
            diaryId: editData["diaryId"],
          
          ),
        ),
      );
      showToast(context, res['message'], Colors.green);
    } else if (response.statusCode == 400) {
      showToast(context, res['message'], Colors.red);
    }
    setState(() {
      isLoading = false;
    });
  }
}
