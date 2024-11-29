import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/Diary/edit_diary.dart';
import 'package:law_diary/common.dart';

class DiaryListView extends StatelessWidget {
  final List mydiary;
  final VoidCallback onSave;

  const DiaryListView({
    Key? key,
    required this.mydiary,
    required this.onSave
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    deleteDiary(String id) async {
      final response = await API().deleteDiaryApi(id);
      var res = jsonDecode(response.body);
      print(res);

      if (response.statusCode == 200) {
        showToast(context, 'Diary deleted successfully.', Colors.green);
        onSave();
      } else if (response.statusCode == 400) {
        showToast(context, res['message'], Colors.red);
      }
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mydiary.length,
      itemBuilder: (context, index) {
        return Card(
          color: const Color.fromARGB(255, 224, 208, 195),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat("dd MMM yyyy").format(
                          DateTime.parse(mydiary[index]['previousdate'])),
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditDiary(
                                  editData: mydiary[index],
                                  diaryId: mydiary[index]['diaryid'],
                                  isEdit: true,
                                  onSave: onSave,
   
                                ),
                              ),
                            );
                          },
                          child: const Icon(Icons.edit),
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () => deleteDiary(mydiary[index]['diaryid']),
                          child: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.grey[200]!),
                    dataRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
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
                    dataRowHeight: 60,
                    showCheckboxColumn: false,
                    columns: [
                      const DataColumn(label: Text("Previous Date")),
                      const DataColumn(label: Text("Case No.")),
                      const DataColumn(label: Text("Client")),
                      const DataColumn(label: Text("Action")),
                      const DataColumn(label: Text("To Do")),
                      const DataColumn(label: Text("Next Date")),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text(DateFormat('yyyy-MM-dd').format(
                          DateTime.parse(mydiary[index]['previousdate']),
                        ))),
                        DataCell(Text(mydiary[index]['causenum'])),
                        DataCell(Text(mydiary[index]['clientname'])),
                        DataCell(Text(mydiary[index]['action'])),
                        DataCell(Text(mydiary[index]['todo'])),
                        DataCell(Text(DateFormat('yyyy-MM-dd').format(
                          DateTime.parse(mydiary[index]['appointment']),
                        ))),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
