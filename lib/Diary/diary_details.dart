import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/Diary/diary_list.dart';
import 'package:law_diary/Diary/next_list.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/localization/locales.dart';

class DiaryDetails extends StatefulWidget {
  String casenum;
  DiaryDetails({required this.casenum});

  @override
  State<DiaryDetails> createState() => _DiaryDetailsState();
}

class _DiaryDetailsState extends State<DiaryDetails> {
  List mydiary = [];
  List nextList = [];
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';
  String _casenum = '';
  String _nextdate = '';
  String _client = '';

  Future<void> getdiary() async {
    setState(() {
      isLoading = true;
      hasError = false;
      errorMessage = '';
    });

    try {
      final response = await API().getAllDiariesWithCaseNumApi(widget.casenum);
      final res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        mydiary = res['data'];
        if (mydiary.isNotEmpty) {
          print("-----------------");
          setState(() {
            nextList = [];
            _casenum = mydiary[0]['causenum'] ?? '00#';
            _client = mydiary[0]['clientname'] ?? '---';
            _nextdate = DateFormat("dd MMM yyyy")
                    .format(DateTime.parse(mydiary[0]['appointment'])) ??
                'dd MMM yyyy';
            nextList.add({
              'diaryid': mydiary[0]['diaryid'],
              'userid': mydiary[0]['diaryid'],
              'previousdate': mydiary[0]['appointment'],
              'causenum': mydiary[0]['causenum'],
              'action': mydiary[0]['action'],
              'clientname': mydiary[0]['clientname'],
              'todo': mydiary[0]['todo'],
              'appointment': ""
            });
          });
          print(_casenum);
          print(_nextdate);
          print(mydiary);
        }
      } else {
        setState(() {
          hasError = true;
          errorMessage = res['message'];
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = 'An error occurred while fetching data: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getdiary();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
          LocaleData.casedetails.getString(context),
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.045,
            color: maincolor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? SpinKitRing(
              size: 23,
              lineWidth: 3,
              color: fifthcolor,
            )
          : mydiary.isEmpty
              ? Center(
                  child: Text(
                    LocaleData.emptymsg.getString(context),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Card(
                          color: maincolor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              children: [
                                Text(
                                  LocaleData.casedetails.getString(context),
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _casenum,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          LocaleData.caseNo.getString(context) +
                                              ".",
                                          style: TextStyle(
                                              color: fourthcolor,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          _client,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          LocaleData.client.getString(context),
                                          style: TextStyle(
                                              color: fourthcolor,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          _nextdate,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          LocaleData.nextdate.getString(context),
                                          style: TextStyle(
                                              color: fourthcolor,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        NextListView(mydiary: nextList, onSave: getdiary,),
                        DiaryListView(mydiary: mydiary, onSave: getdiary,),
                      ],
                    ),
                  ),
              ),
    );
  }
}
