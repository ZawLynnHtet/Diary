import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/Diary/daily_diary.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/localization/locales.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateDiary extends StatefulWidget {
  final VoidCallback onSave;
  CreateDiary({required this.onSave});

  @override
  State<CreateDiary> createState() => _CreateDiaryState();
}

class _CreateDiaryState extends State<CreateDiary> {
  final TextEditingController _clientnameController = TextEditingController();
  final TextEditingController _actionController = TextEditingController();
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _causenumTypeController = TextEditingController();
  final TextEditingController _nextController = TextEditingController();
  final TextEditingController _previousController = TextEditingController();

  DateTime defaultPreDate = DateTime.now();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _previousController.text = DateFormat('yyyy-MM-dd').format(defaultPreDate);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: maincolor,
        appBar: AppBar(
          backgroundColor: subcolor,
          elevation: 0,
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
            LocaleData.newcase.getString(context),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    TextFormField(
                      decoration: _buildInputDecoration(),
                      readOnly: true,
                      onTap: () {
                        _selectDateForPrevious(context);
                      },
                      controller: _previousController,
                    ),
                    SizedBox(height: screenHeight * 0.01),
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
                                  fontWeight: FontWeight.bold,
                                ),
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.005),
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
                        fontWeight: FontWeight.bold,
                      ),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    TextFormField(
                      decoration: _buildInputDecoration(),
                      readOnly: true,
                      onTap: () {
                        _selectDateForAppointment(context);
                      },
                      controller: _nextController,
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
                            if (_previousController.text.isEmpty) {
                              showToast(
                                  context,
                                  LocaleData.requiredPrevious
                                      .getString(context),
                                  Colors.red);
                            } else if (_clientnameController.text.isEmpty) {
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
                            } else if (_nextController.text.isEmpty) {
                              showToast(
                                  context,
                                  LocaleData.requiredAppointment
                                      .getString(context),
                                  Colors.red);
                            } else {
                              createDiary();
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
                                    LocaleData.save.getString(context),
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
      ),
    );
  }

  Future<void> _selectDateForAppointment(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _nextController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateForPrevious(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _previousController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
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

  String diaryId = "";

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
      _nextController.text,
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
