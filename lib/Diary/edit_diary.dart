import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/localization/locales.dart';

class EditDiary extends StatefulWidget {
  final String diaryId;
  final editData;
  final bool isEdit;
  final VoidCallback onSave;
  EditDiary({
    super.key,
    required this.editData,
    required this.diaryId,
    required this.isEdit,
    required this.onSave,
  });

  @override
  State<EditDiary> createState() => _EditDiaryState();
}

class _EditDiaryState extends State<EditDiary> {
  final TextEditingController _clientnameController = TextEditingController();
  final TextEditingController _previousController = TextEditingController();
  final TextEditingController _actionController = TextEditingController();
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _causenumTypeController = TextEditingController();
  final TextEditingController _appointmentController = TextEditingController();

  bool isLoading = false;
  DateTime? _selectedDate;
  var editData;

  initData() {
    setState(() {
      editData = widget.editData;
      if (editData != null) {
        _previousController.text = DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(editData["previousdate"])) ??
            '';
        _clientnameController.text = editData["clientname"] ?? '';
        _actionController.text = editData["action"] ?? '';
        _todoController.text = editData["todo"] ?? '';
        _causenumTypeController.text = editData["causenum"] ?? '';
        _appointmentController.text = editData["appointment"] ?? '';
        _selectedDate = (editData["appointment"] != null &&
                editData["appointment"].isNotEmpty)
            ? DateFormat('yyyy-MM-dd').parse(editData["appointment"])
            : null;

        if (_selectedDate != null) {
          _appointmentController.text =
              DateFormat('yyyy-MM-dd').format(_selectedDate!);
        }
      }
    });
  }

  @override
  void initState() {
    initData();
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: subcolor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: Icon(
              Icons.chevron_left_outlined,
              color: maincolor,
              size: 35,
            )),
        title: Text(
          LocaleData.updatecase.getString(context),
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.045,
            color: maincolor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(
            context,
          );
          return false;
        },
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleData.previousdate.getString(context),
                    style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  TextFormField(
                    style: TextStyle(color: fifthcolor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    readOnly: true,
                    showCursor: false,
                    controller: _previousController,
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleData.caseNo.getString(context),
                              style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            TextFormField(
                              controller: _causenumTypeController,
                              decoration: _buildInputDecoration(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleData.client.getString(context),
                              style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 3),
                            TextFormField(
                              controller: _clientnameController,
                              decoration: _buildInputDecoration(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    LocaleData.action.getString(context),
                    style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  TextFormField(
                    controller: _actionController,
                    decoration: _buildInputDecoration(),
                    maxLines: 3,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    LocaleData.todo.getString(context),
                    style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _todoController,
                    decoration: _buildInputDecoration(),
                    maxLines: 3,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    LocaleData.nextdate.getString(context),
                    style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  TextFormField(
                    decoration: _buildInputDecoration(),
                    readOnly: true,
                    onTap: () {
                      _selectDate(context);
                    },
                    controller: _appointmentController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: subcolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            LocaleData.cancel.getString(context),
                            style: GoogleFonts.poppins(
                              color: seccolor,
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: subcolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_clientnameController.text.isEmpty) {
                            showToast(
                                context,
                                LocaleData.requiredClient.getString(context),
                                Colors.red);
                          } else if (_actionController.text.isEmpty) {
                            showToast(
                                context,
                                LocaleData.requiredAction.getString(context),
                                Colors.red);
                          } else if (_todoController.text.isEmpty) {
                            showToast(
                                context,
                                LocaleData.requiredToDo.getString(context),
                                Colors.red);
                          } else if (_causenumTypeController.text.isEmpty) {
                            showToast(
                                context,
                                LocaleData.requiredCaseNo.getString(context),
                                Colors.red);
                          } else if (_appointmentController.text.isEmpty) {
                            showToast(
                                context,
                                LocaleData.requiredAppointment
                                    .getString(context),
                                Colors.red);
                          } else {
                            if(widget.isEdit){
                              updateDiary();
                            }else {
                              createDiary();
                            }
                          }
                        },
                        child: isLoading
                            ? const SpinKitRing(
                                size: 23,
                                lineWidth: 3,
                                color: Colors.white,
                              )
                            : Center(
                                child: Text(
                                  LocaleData.update.getString(context),
                                  style: GoogleFonts.poppins(
                                    color: maincolor,
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _appointmentController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  updateDiary() async {
    setState(() {
      isLoading = true;
    });
    final response = await API().editDiaryApi(
      widget.diaryId,
      _clientnameController.text,
      _actionController.text,
      _todoController.text,
      _causenumTypeController.text,
      _appointmentController.text,
    );
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      widget.onSave();
      Navigator.pop(context, true);
      showToast(context, res['message'], Colors.green);
    } else if (response.statusCode == 400) {
      showToast(context, res['message'], Colors.red);
    }
    setState(() {
      isLoading = false;
    });
  }

  createDiary() async {
    setState(() {
      isLoading = true;
    });

    final response = await API().createDiaryApi(
      _previousController.text,
      _clientnameController.text,
      _actionController.text,
      _todoController.text,
      _causenumTypeController.text,
      _appointmentController.text,
    );

    final res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (context.mounted) {
        widget.onSave();
        Navigator.pop(
          context,
        );
        showToast(context, res['message'], Colors.green);
      }
    } else {
      showToast(context, res['message'], Colors.red);
    }
  }
}
