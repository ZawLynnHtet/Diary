import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/API/model.dart';
import 'package:law_diary/Diary/create_diary.dart';
import 'package:law_diary/common.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class DailyDiaryPage extends StatefulWidget {
  const DailyDiaryPage({super.key});

  @override
  State<DailyDiaryPage> createState() => _DailyDiaryPageState();
}

class _DailyDiaryPageState extends State<DailyDiaryPage> {
  List<diarylistmodel> mydiary = [];
  bool isLoading = false;
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, List<diarylistmodel>> _diariesByDate = {};

  Future<void> getdiary() async {
    setState(() {
      isLoading = true;
    });

    final response = await API().getAllDiariesApi();
    final res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List diaryList = res['data'];
      setState(() {
        mydiary = diaryList.map((diary) {
          final diaryDate =
              DateTime.parse(diary['appointment'] ?? DateTime.now().toString());
          _diariesByDate[diaryDate] = [
            ...(_diariesByDate[diaryDate] ?? []),
            diarylistmodel(
              diaryid: diary['diaryid'] ?? "",
              clientname: diary['clientname'] ?? "",
              action: diary['action'] ?? "",
              todo: diary["todo"] ?? "",
              causenum: diary["causenum"] ?? "",
              appointment: diary["appointment"] ?? "",
            )
          ];
          return diarylistmodel(
            diaryid: diary['diaryid'] ?? "",
            clientname: diary['clientname'] ?? "",
            action: diary['action'] ?? "",
            todo: diary["todo"] ?? "",
            causenum: diary["causenum"] ?? "",
            appointment: diary["appointment"] ?? "",
          );
        }).toList();
      });
    } else {
      showToast(context, res['message'], Colors.red);
    }

    setState(() {
      isLoading = false;
    });
  }

  List<diarylistmodel> _getEventsForDay(DateTime day) {
    return mydiary
        .where((diary) =>
            diary.appointment.isNotEmpty &&
            DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(diary.appointment)) ==
                DateFormat('yyyy-MM-dd').format(day))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getdiary();
    });
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
            Navigator.pop(
              context,
            );
          },
        ),
        title: Text(
          'ဆောင်ရွက်ဆဲအမှုစာရင်း',
          style: GoogleFonts.poppins(
            fontSize: 17,
            color: darkmain,
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
                    "Empty",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: fifthcolor,
                    ),
                  ),
                )
              : Column(
                  children: [
                    TableCalendar(
                      locale: 'en-US',
                      rowHeight: 60,
                      focusedDay: _selectedDate,
                      firstDay: DateTime(2000),
                      lastDay: DateTime(2100),
                      calendarFormat: CalendarFormat.month,
                      availableGestures: AvailableGestures.all,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDate, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDate = selectedDay;
                        });
                        // final diariesForSelectedDate =
                        //     _getEventsForDay(selectedDay);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateDiary()),
                        );
                      },
                      calendarStyle: CalendarStyle(
                        cellMargin:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        defaultTextStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        weekendTextStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.lightBlueAccent.withOpacity(0.3),
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.blueAccent, width: 2),
                        ),
                        markerDecoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: darkmain,
                        ),
                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          color: darkmain,
                          size: 32,
                        ),
                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          color: darkmain,
                          size: 32,
                        ),
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey[700],
                          fontWeight: FontWeight.w500,
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (context, day, events) {
                          if (events.isNotEmpty) {
                            return Positioned(
                              bottom: 6,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.deepOrangeAccent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          }
                          return null;
                        },
                      ),
                      eventLoader: (day) => _diariesByDate[day] ?? [],
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ဒိုင်ယာရီများ',
                            style: TextStyle(
                                color: darkmain,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'အသေးစိတ်ကြည့်ရန်..',
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Expanded(
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
                              color: darkmain,
                            ),
                            dataTextStyle: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                            columnSpacing: 20,
                            horizontalMargin: 10,
                            columns: const [
                              DataColumn(label: Text("Client Name")),
                              DataColumn(label: Text("Action")),
                              DataColumn(label: Text("ToDo")),
                              DataColumn(label: Text("No")),
                              DataColumn(label: Text("Appointment")),
                              DataColumn(label: Text("Edit")),
                              DataColumn(label: Text("Delete")),
                            ],
                            rows: mydiary
                                .map((diary) => DataRow(cells: [
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(diary.clientname),
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(diary.action),
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(diary.todo),
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(diary.causenum),
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(
                                            diary.appointment.isNotEmpty
                                                ? DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.parse(
                                                        diary.appointment))
                                                : 'No Appointment',
                                          ),
                                        ),
                                      ),
                                      // Edit Button
                                      DataCell(
                                        IconButton(
                                          icon: Icon(Icons.edit,
                                              color: Colors.blue),
                                          onPressed: () {
                                            // TODO: Add edit functionality here
                                            print(
                                                'Edit diary: ${diary.diaryid}');
                                          },
                                        ),
                                      ),
                                      // Delete Button
                                      DataCell(
                                        IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(
                                                  'Are you sure to Delete?',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'No',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 15),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        deleteDiary(
                                                            diary.diaryid);
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'Yes',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.red),
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
                  ],
                ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: darkmain,
        backgroundColor: darkmain,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateDiary()),
          );
        },
        child: Icon(Icons.add),
        // label: Text('', style: GoogleFonts.poppins(color: seccolor)),
        // icon: Icon(Icons.add, color: seccolor),
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
