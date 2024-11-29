import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/API/model.dart';
import 'package:law_diary/Diary/create_diary.dart';
import 'package:law_diary/Diary/diary_details.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/localization/locales.dart';

class DailyDiaryPage extends StatefulWidget {
  const DailyDiaryPage({super.key});

  @override
  State<DailyDiaryPage> createState() => _DailyDiaryPageState();
}

class _DailyDiaryPageState extends State<DailyDiaryPage> {
  List<diarylistmodel> mydiary = [];
  List<diarylistmodel> filteredDiary = [];
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';
  TextEditingController _dateController = TextEditingController();

  Future<void> getdiary() async {
    setState(() {
      isLoading = true;
      hasError = false;
      errorMessage = '';
    });

    try {
      final response = await API().getAllDiariesApi();
      final res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List diaryList = res['data'];

        setState(() {
          mydiary = diaryList.map((diary) {
            return diarylistmodel(
              diaryid: diary['diaryid'] ?? "",
              clientname: diary['clientname'] ?? "",
              previousdate: diary['previousdate'] ?? "",
              action: diary['action'] ?? "",
              todo: diary["todo"] ?? "",
              causenum: diary["causenum"] ?? "",
              appointment: diary["appointment"] ?? "",
            );
          }).toList();

          filteredDiary = mydiary;
        });
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

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd MMM yyyy').format(pickedDate);
      });
      filterDiaryByDate(pickedDate);
    }
  }

  void filterDiaryByDate(DateTime selectedDate) {
    setState(() {
      filteredDiary = mydiary.where((diary) {
        String appointmentDate = diary.appointment;
        DateTime? parsedDate = appointmentDate.isNotEmpty
            ? DateTime.tryParse(appointmentDate)
            : null;

        if (parsedDate != null) {
          return DateFormat('yyyy-MM-dd').format(parsedDate) ==
              DateFormat('yyyy-MM-dd').format(selectedDate);
        }
        return false;
      }).toList();
    });
  }

  bool isLandscape = false;

  void toggleOrientation() {
    if (isLandscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
    setState(() {
      isLandscape = !isLandscape;
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getdiary();
    _dateController.text = DateFormat("dd MMM yyyy").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: subcolor,
        elevation: 0,
        centerTitle: true,
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
        title: Container(
          width: 155,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(10)),
          child: TextField(
            readOnly: true,
            controller: _dateController,
            style: TextStyle(color: maincolor),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 3, left: 5),
                filled: false,
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.expand_more_rounded,
                  color: maincolor,
                )),
            onTap: () {
              _selectDate(context);
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isLandscape ? Icons.screen_lock_portrait : Icons.rotate_right,
              color: maincolor,
            ),
            onPressed: toggleOrientation,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? SpinKitRing(
                    size: 23,
                    lineWidth: 3,
                    color: fifthcolor,
                  )
                : filteredDiary.isEmpty
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
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.grey.shade200),
                            dataRowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.grey.shade50),
                            border: TableBorder.all(
                                color: Colors.grey.shade300, width: 1),
                            headingTextStyle: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey,
                            ),
                            dataTextStyle: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                            columnSpacing: 50,
                            horizontalMargin: 10,
                            headingRowHeight: 45,
                            dataRowHeight: 80,
                            columns: [
                              DataColumn(
                                  label: Text(LocaleData.previousdate
                                      .getString(context))),
                              DataColumn(
                                  label: Text(
                                      LocaleData.caseNo.getString(context))),
                              DataColumn(
                                  label: Text(
                                      LocaleData.client.getString(context))),
                              DataColumn(
                                  label: Text(
                                      LocaleData.action.getString(context))),
                              DataColumn(
                                  label:
                                      Text(LocaleData.todo.getString(context))),
                              DataColumn(
                                  label: Text(
                                      LocaleData.nextdate.getString(context))),
                            ],
                            rows: filteredDiary.map((diary) {
                              return DataRow(cells: [
                                DataCell(onTap: () {
                                  goToDetails(diary.causenum);
                                },
                                    Text(
                                      diary.previousdate.isNotEmpty
                                          ? DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(
                                                  diary.previousdate))
                                          : '',
                                    )),
                                DataCell(onTap: () {
                                  goToDetails(diary.causenum);
                                }, Text(diary.causenum)),
                                DataCell(onTap: () {
                                  goToDetails(diary.causenum);
                                }, Text(diary.clientname)),
                                DataCell(onTap: () {
                                  goToDetails(diary.causenum);
                                }, Text(diary.action)),
                                DataCell(onTap: () {
                                  goToDetails(diary.causenum);
                                }, Text(diary.todo)),
                                DataCell(onTap: () {
                                  goToDetails(diary.causenum);
                                },
                                    Text(
                                      diary.appointment.isNotEmpty
                                          ? DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(diary.appointment))
                                          : '',
                                    )),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateDiary(onSave: getdiary,)),
          );
        },
        backgroundColor: subcolor,
        foregroundColor: maincolor,
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  goToDetails(casenum) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DiaryDetails(casenum: casenum)),
    );
  }
}
