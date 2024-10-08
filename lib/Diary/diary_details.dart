import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/API/model.dart';
import 'package:law_diary/Diary/create_diary_details.dart';
import 'package:law_diary/Diary/daily_diary.dart';
import 'package:law_diary/Diary/edit_diary.dart';
import 'package:law_diary/common.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action-todo_details.dart';

class DiaryDetails extends StatefulWidget {
  final String diaryId;
  const DiaryDetails({super.key, required this.diaryId});

  @override
  State<DiaryDetails> createState() => _DiaryDetailsState();
}

class _DiaryDetailsState extends State<DiaryDetails> {
  List<diarydetailslistmodel> mydetails = [];
  diarydetailslistmodel? selecteddetails;

  // List<diarylistmodel> mydiary = [];
  // diarylistmodel? selecteddiary;

  bool ready = false;
  bool isLoading = false;

  // getdiarydetails() async {
  //   isLoading = true;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final response = await API().getdiarydetails(widget.diaryId);
  //   print('>>>>>>>>>>>>>diaryId<<<<<<<<<<<<<<,${widget.diaryId}');
  //   final res = jsonDecode(response.body);
  //   print('>>>>>>>>>>>>>>>>>>>>>>$response');
  //   if (response.statusCode == 200) {
  //     print("response data");

  //     // List diaryList = res[''];
  //     // print('>>>>>>>>>>>>>>> diary list$diaryList');
  //     if (res["status"] == "success") {
  //       List data = res['data'];
  //       if (data.isNotEmpty) {
  //         for (var i = 0; i < data.length; i++) {
  //           mydetails.add(
  //             diarydetailslistmodel(
  //               detailsId: data[i]['detailsId'],
  //               diaryId: data[i]['diaryId'],
  //               actions: data[i]['actions'] ?? "",
  //               toDo: data[i]['toDo'] ?? "",
  //               notes: data[i]["notes"] ?? "",
  //               startDate: data[i]["startDate"] ?? "",
  //               appointment: data[i]["appointment"] ?? "",
  //             ),
  //           );
  //         }
  //       }
  //     } else if (response.statusCode == 400) {
  //       mydetails = [];
  //       showToast(context, res['message'], Colors.red);
  //     }
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  getdiarydetails() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await API().getdiarydetails(widget.diaryId);
    final res = jsonDecode(response.body);
    print("hellohellohellohello");
    print('_____________>>>>>>>>>>>>>>>response body ${res}');
    print('>>>>>>>>>>>>>>>>>>>>>>$response');
    if (response.statusCode == 200) {
      List diarydetailsList = res['data'];
      print("----------------");
      print('>>>>>>>>>>>>>>> diary details list$diarydetailsList');
      if (diarydetailsList.isNotEmpty) {
        for (var i = 0; i < diarydetailsList.length; i++) {
          setState(() {
            mydetails.add(
              diarydetailslistmodel(
                detailsId: diarydetailsList[i]['detailsId'],
                diaryId: diarydetailsList[i]['diaryId'],
                actions: diarydetailsList[i]['actions'] ?? "",
                toDo: diarydetailsList[i]['toDo'] ?? "",
                notes: diarydetailsList[i]["notes"] ?? "",
                startDate: diarydetailsList[i]["startDate"] ?? "",
                appointment: diarydetailsList[i]["appointment"] ?? "",
                pdffile: diarydetailsList[i]["url"] ?? "",
              ),
            );
            print('>>>>>>>>>>>>>>>>mydetails<<<<<<<<<<<<<<<${mydetails[0]}');
          });
        }
      } else if (response.statusCode == 400) {
        setState(() {
          mydetails = [];
        });

        showToast(context, res['message'], Colors.red);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  // getsinglediary() async {
  //   print("0000000000000${widget.diaryId}");
  //   isLoading = true;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final response = await API().getSingleDiariesApi(widget.diaryId);
  //   final res = jsonDecode(response.body);
  //   print('_____________>>>>>>>>>>>>>>>response body ${res}');
  //   print('>>>>>>>>>>>>>>>>>>>>>>$response');
  //   print(res['userId']);
  //   if (response.statusCode == 200) {
  //     print("----------------");
  //     if (res.isNotEmpty) {
  //       setState(() {
  //         mydiary.add(
  //           diarylistmodel(
  //             diaryId: res['diaryId'] ?? "",
  //             clientName: res['clientName'] ?? "",
  //             cause: res['cause'] ?? "",
  //             causeNum: res["causeNum"] ?? "",
  //             causeType: res["causeType"] ?? "",
  //           ),
  //         );
  //       });
  //     } else if (response.statusCode == 400) {
  //       setState(() {
  //         mydiary = [];
  //       });

  //       showToast(context, res['message'], Colors.red);
  //     }
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  void initState() {
    getdiarydetails();
    // getsinglediary();
    // print('>>>>>>>>>>>mydetails<<<<<<<<<<<<${mydetails}');
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DailyDiaryPage(),
              ),
            );
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DailyDiaryPage(),
            ),
          );
          return false;
        },
        child: isLoading
            ? SpinKitRing(
                size: 23,
                lineWidth: 3,
                color: maincolor,
              )
            : mydetails.isEmpty
                ? Center(
                    child: Text(
                    "Empty",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: fifthcolor,
                    ),
                  ))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: mydetails.length,
                        itemBuilder: (context, i) {
                          return DiaryDetailsModel(
                            eachdetails: mydetails[i],
                            diaryId: widget.diaryId,
                            // eachdiary: mydiary[i],
                          );
                        },
                      ),
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: darkmain,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateDiaryDetails(
                diaryId: widget.diaryId,
              ),
            ),
          );
        },
        label: Text(
          'Add',
          style: GoogleFonts.poppins(color: seccolor),
        ),
        icon: Icon(Icons.add, color: seccolor),
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
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // showToast('successfully deleted', 'darkmain');
      // ignore: use_build_context_synchronously
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const DailyDiary(),
      //     ),
      //     (route) => false);
      // ignore: use_build_context_synchronously
      showToast(context, res['message'], Colors.green);
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

class DiaryDetailsModel extends StatefulWidget {
  final diarydetailslistmodel eachdetails;
  final String diaryId;
  const DiaryDetailsModel({
    super.key,
    required this.eachdetails,
    required this.diaryId,
  });

  @override
  State<DiaryDetailsModel> createState() => _DiaryDetailsModelState();
}

class _DiaryDetailsModelState extends State<DiaryDetailsModel> {
  List<diarydetailslistmodel> mydetails = [];
  List<diarylistmodel> mydiary = [];
  bool isLoading = false;
  var time = DateTime.now();
  PopupMenuItem _buildPopupMenuItem(String title, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        children: [
          Text(title),
        ],
      ),
    );
  }

  _popUpWidget(diarydetailslistmodel data) {
    return PopupMenuButton(
      padding: EdgeInsets.all(0),
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: (value) {
        print("value : $value");
        setState(() {});
        if (value == 0) {
          print(">>>>> my data");
          var mydata = jsonEncode({
            "detailsId": widget.eachdetails.detailsId,
            "diaryId": widget.eachdetails.diaryId,
            "actions": widget.eachdetails.actions,
            "toDo": widget.eachdetails.toDo,
            "notes": widget.eachdetails.notes,
            "startDate": widget.eachdetails.startDate,
            "appointment": widget.eachdetails.appointment,
          });
          print(">>>>> my data");
          print(mydata);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditDiary(
                editData: mydata,
                diaryId: widget.diaryId,
                // categoryId: widget.eachnote.categoryId,
              ),
            ),
          );
        } else {
          print("value >>>> : $value");
        }
      },
      offset: Offset(
        0.0,
        AppBar().preferredSize.height,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      itemBuilder: (contex) => [
        _buildPopupMenuItem(
          'Edit',
          0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActionTodoDetails(
                actions: widget.eachdetails.actions,
                toDo: widget.eachdetails.toDo,
                notes: widget.eachdetails.notes,
                pdffile: widget.eachdetails.pdffile,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: fourthcolor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: seccolor,
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 10),
                      child: Image.asset(
                        'images/lawbg.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    _popUpWidget(widget.eachdetails),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'နေ့စွဲ :',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: maincolor,
                        ),
                      ),
                      Text(
                        widget.eachdetails.startDate == ""
                            ? ""
                            : DateFormat("dd-MM-yyyy").format(
                                DateTime.parse(widget.eachdetails.startDate),
                              ),
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: maincolor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'ဆောင်ရွက်ချက် :',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: maincolor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.eachdetails.toDo,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: maincolor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ရုံးချိန်းရက် :',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: maincolor,
                        ),
                      ),
                      Text(
                        widget.eachdetails.appointment == ""
                            ? ""
                            : DateFormat("dd-MM-yyyy").format(
                                DateTime.parse(widget.eachdetails.appointment),
                              ),
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: maincolor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'ဆောင်ရွက်ရန် :',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: maincolor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.eachdetails.actions,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: maincolor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'မှတ်ချက် :',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: maincolor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.eachdetails.notes,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: maincolor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'ဖိုင် :',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: maincolor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.eachdetails.pdffile,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: maincolor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
                // Divider(
                //   color: seccolor,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // deleteDiary(id) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final response = await API().deleteDiaryApi(id);
  //   var res = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     print(
  //         ">>>>>>>>>>> delete diary response statusCode ${response.statusCode}");
  //     print(">>>>>>>>>>> delete diary response body ${response.body}");

  //     print('>>>>>>>>>>>>>>>>>>>>>>>');
  //     // ignore: use_build_context_synchronously
  //     Navigator.pop(context);
  //     // showToast('successfully deleted', 'darkmain');
  //     // ignore: use_build_context_synchronously
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => DiaryDetails(
  //             diaryId: widget.eachdetails.detailsId,
  //           ),
  //         ),
  //         (route) => false);
  //     // ignore: use_build_context_synchronously
  //     showToast(context, res['message'], Colors.green);
  //   } else if (response.statusCode == 400) {
  //     // ignore: use_build_context_synchronously
  //     Navigator.pop(context);
  //     // ignore: use_build_context_synchronously
  //     showToast(context, res['message'], Colors.red);
  //   }
  //   //  Navigator.pop(context);
  //   //   showToast('${result['returncode']}', 'red');
  //   setState(() {});
  // }
}
