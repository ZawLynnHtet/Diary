import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/API/model.dart';
import 'package:law_diary/Diary/daily_diary.dart';
import 'package:law_diary/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiaryDetailPage extends StatefulWidget {
  final DateTime selectedDate;
  final List<diarylistmodel> diariesForSelectedDate;

  const DiaryDetailPage({
    Key? key,
    required this.selectedDate,
    required this.diariesForSelectedDate,
  }) : super(key: key);

  @override
  _DiaryDetailPageState createState() => _DiaryDetailPageState();
}

class _DiaryDetailPageState extends State<DiaryDetailPage> {
  late List<diarylistmodel> _diaries;

  @override
  void initState() {
    super.initState();
    _diaries = List.from(widget.diariesForSelectedDate);
  }

  void _deleteDiary(int diaryId) {
    setState(() {
      _diaries.removeWhere((diary) => diary.diaryid == diaryId);
    });
    // Add any additional deletion logic here, like making an API call
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        elevation: 0,
        leading: BackButton(
          color: darkmain,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DailyDiaryPage()),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.grey.shade200),
              dataRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.grey.shade50),
              border: TableBorder.all(color: Colors.grey.shade300, width: 1),
              headingTextStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
              ),
              dataTextStyle: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.black87,
              ),
              columnSpacing: 20,
              horizontalMargin: 10,
              columns: const [
                DataColumn(label: Text("Client")),
                DataColumn(label: Text("Action")),
                DataColumn(label: Text("ToDo")),
                DataColumn(label: Text("Cause No")),
                DataColumn(label: Text("Appointment")),
                DataColumn(label: Text("Edit")),
                DataColumn(label: Text("Delete")),
              ],
              rows: _diaries
                  .map((diary) => DataRow(cells: [
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(diary.clientname),
                          ),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(diary.action),
                          ),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(diary.todo),
                          ),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(diary.causenum),
                          ),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              diary.appointment.isNotEmpty
                                  ? DateFormat('yyyy-MM-dd')
                                      .format(DateTime.parse(diary.appointment))
                                  : 'No Appointment',
                            ),
                          ),
                        ),
                        // Edit Button
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              // TODO: Add edit functionality here
                              print('Edit diary: ${diary.diaryid}');
                            },
                          ),
                        ),
                        // Delete Button
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    'Are you sure to Delete?',
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'No',
                                        style:
                                            GoogleFonts.poppins(fontSize: 15),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          deleteDiary(diary.diaryid);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Yes',
                                        style: GoogleFonts.poppins(
                                            fontSize: 15, color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ]))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  deleteDiary(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await API().deleteDiaryApi(id);
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(
          ">>>>>>>>>>> delete diary response statusCode ${response.statusCode}");
      print(">>>>>>>>>>> delete diary response body ${response.body}");

      print('>>>>>>>>>>>>>>>>>>>>>>>');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DailyDiaryPage(),
        ),
      );
    } else if (response.statusCode == 400) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      showToast(context, res['message'], Colors.red);
    }
    //  Navigator.pop(context);
    //   showToast('${result['returncode']}', 'red');
    setState(() {});
  }
}
