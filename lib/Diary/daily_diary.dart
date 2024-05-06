import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/API/model.dart';
import 'package:law_diary/Diary/create_diary.dart';
import 'package:law_diary/Diary/diary_details.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyDiaryPage extends StatefulWidget {
  const DailyDiaryPage({super.key});

  @override
  State<DailyDiaryPage> createState() => _DailyDiaryPageState();
}

class _DailyDiaryPageState extends State<DailyDiaryPage> {
  List<diarylistmodel> mydiary = [];
  diarylistmodel? selecteddiary;

  bool ready = false;
  bool isLoading = false;

  getdiary() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await API().getAllDiariesApi();
    final res = jsonDecode(response.body);
    print('_____________>>>>>>>>>>>>>>>response body ${res}');
    print('>>>>>>>>>>>>>>>>>>>>>>$response');
    if (response.statusCode == 200) {
      List diaryList = res['data'];
      print("----------------");
      print('>>>>>>>>>>>>>>> diary list$diaryList');
      if (diaryList.isNotEmpty) {
        for (var i = 0; i < diaryList.length; i++) {
          setState(() {
            mydiary.add(
              diarylistmodel(
                diaryId: diaryList[i]['diaryId'] ?? "",
                clientName: diaryList[i]['clientName'] ?? "",
                cause: diaryList[i]['cause'] ?? "",
                causeNum: diaryList[i]["causeNum"] ?? "",
                causeType: diaryList[i]["causeType"] ?? "",
              ),
            );
          });
        }
      } else if (response.statusCode == 400) {
        setState(() {
          mydiary = [];
        });
        showToast(context, res['message'], Colors.red);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getdiary();
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
                builder: (context) => const HomeScreen(),
              ),
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
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
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
            : mydiary.isEmpty
                ? Center(
                    child: Text(
                    "Empty",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: fifthcolor,
                    ),
                  ))
                : SingleChildScrollView(
                    child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: mydiary.length,
                        itemBuilder: (context, i) {
                          return DiaryModel(eachdiary: mydiary[i]);
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: darkmain,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateDiary(),
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
}

class DiaryModel extends StatefulWidget {
  final diarylistmodel eachdiary;
  const DiaryModel({
    super.key,
    required this.eachdiary,
  });

  @override
  State<DiaryModel> createState() => _DiaryModelState();
}

class _DiaryModelState extends State<DiaryModel> {
  List<diarylistmodel> mydiary = [];
  bool isLoading = false;
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

  _popUpWidget(diarylistmodel data) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: (value) {
        print("value : $value");
        setState(() {});
        if (value == 0) {
        } else if (value == 1) {
          print(">>>><<<<");
          print(data.diaryId);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    deleteDiary(data.diaryId);
                    setState(() {});
                  },
                  child: isLoading
                      ? const SpinKitDoubleBounce(
                          color: Colors.white,
                          size: 15.0,
                        )
                      : Text(
                          'Yes',
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.red),
                        ),
                ),
              ],
              title: Text(
                'Are you sure to Delete?',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              contentPadding: const EdgeInsets.all(2.0),
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
          'Delete',
          1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiaryDetails(
              diaryId: widget.eachdiary.diaryId,
            ),
          ),
        );
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Image.asset(
                        'images/lawbg.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    _popUpWidget(widget.eachdiary),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'အမှုနံပါတ် :',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: maincolor,
                        ),
                      ),
                      Text(
                        widget.eachdiary.causeNum,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: backcolor,
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
                        'အမှု :',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: maincolor,
                        ),
                      ),
                      Text(
                        widget.eachdiary.cause,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: backcolor,
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
                        'အမှုသည် :',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: maincolor,
                        ),
                      ),
                      Text(
                        widget.eachdiary.clientName,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: backcolor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'အမှုအမျိုးအစား :',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: maincolor,
                        ),
                      ),
                      Text(
                        widget.eachdiary.causeType,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: backcolor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 1,
                )
              ],
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
      // ignore: use_build_context_synchronously
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => DailyDiaryPage(
      //         userId: widget.userId,
      //       ),
      //     ),
      //     (route) => false);
      // showToast(context, res['message'], Colors.green);
      // ignore: use_build_context_synchronously
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
