import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/Diary/diary_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/model.dart';
import '../common.dart';

class ActionTodoDetails extends StatefulWidget {
  String actions;
  String toDo;
  String notes;
  ActionTodoDetails({
    super.key,
    required this.actions,
    required this.toDo,
    required this.notes,
  });

  @override
  State<ActionTodoDetails> createState() => _ActionTodoDetailsState();
}

class _ActionTodoDetailsState extends State<ActionTodoDetails> {
  List<diarydetailslistmodel> mydetails = [];
  diarydetailslistmodel? selecteddetails;

  List<diarylistmodel> mydiary = [];
  diarylistmodel? selecteddiary;

  bool ready = false;
  bool isLoading = false;

  @override
  void initState() {
    print('>>>>>>>>>><<<<<<<<<<<<<<,,${widget.actions}');
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
            Navigator.pop(context);
          },
        ),
        title: Text(
          'အမှုအသေးစိတ်',
          style: GoogleFonts.poppins(
            fontSize: 17,
            color: darkmain,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: isLoading
            ? SpinKitRing(
                size: 23,
                lineWidth: 3,
                color: maincolor,
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        'ဆောင်ရွက်ချက်',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: darkmain,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        widget.actions,
                        maxLines: 10,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: maincolor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        'ဆောင်ရွက်ရန်',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: darkmain,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        widget.toDo,
                        maxLines: 10,
                        style:
                            GoogleFonts.poppins(fontSize: 15, color: maincolor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        'မှတ်ချက်',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: darkmain,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        widget.notes,
                        maxLines: 10,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: maincolor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
