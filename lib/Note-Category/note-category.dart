import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:law_diary/API/model.dart';
import 'package:law_diary/Note-Category/create-category.dart';
import 'package:law_diary/Notes/create_notes.dart';
import 'package:law_diary/Notes/notes.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/api.dart';
import '../home.dart';
import 'edit-note-category.dart';

class NoteCategoryScreen extends StatefulWidget {
  String userId;
  NoteCategoryScreen({super.key, required this.userId});

  @override
  State<NoteCategoryScreen> createState() => _NoteCategoryScreenState();
}

class _NoteCategoryScreenState extends State<NoteCategoryScreen> {
  List<notecategorylistmodel> mycategory = [];
  notecategorylistmodel? selectedcategory;

  bool ready = false;
  bool isLoading = false;

  getcategory() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await API().getAllNotesCategoryApi(widget.userId);
    final res = jsonDecode(response.body);
    print('>>>>>>>>>>>>>>>>>>>>>>$response');
    if (response.statusCode == 200) {
      List categoryList = res['data'];
      print('>>>>>>>>>>>>>>> category list$categoryList');
      if (categoryList.isNotEmpty) {
        for (var i = 0; i < categoryList.length; i++) {
          mycategory.add(
            notecategorylistmodel(
              categoryId: categoryList[i]['categoryId'],
              categoryName: categoryList[i]['categoryName'],
            ),
          );
        }
      } else if (response.statusCode == 400) {
        mycategory = [];

        showToast(context, res['message'], Colors.red);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getcategory();
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
                builder: (context) => HomeScreen(
                  userId: widget.userId,
                ),
              ),
            );
          },
        ),
        title: Text(
          'မှတ်ချက်',
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
              builder: (context) => HomeScreen(
                userId: widget.userId,
              ),
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
            : mycategory.isEmpty
                ? Center(
                    child: Text(
                      "Empty",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: fifthcolor,
                      ),
                    ),
                  )
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: mycategory.length,
                          itemBuilder: (context, i) {
                            return Slidable(
                              endActionPane: ActionPane(
                                // extentRatio: 0.26,
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      setState(() {
                                        print(">>>>> my data");
                                        var mydata = jsonEncode({
                                          "categoryId":
                                              mycategory[i].categoryId,
                                          "categoryName":
                                              mycategory[i].categoryName,
                                        });
                                        print(">>>>> my data");
                                        print(mydata);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditNoteCategory(
                                              editData: mydata,
                                              userId: widget.userId,
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                    backgroundColor: Colors.blue,
                                    icon: Icons.edit,
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.only(
                                              left: 10,
                                              top: 15,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                mycategory[i].categoryId ==
                                                        selectedcategory
                                                            ?.categoryId
                                                    ? const Text(
                                                        "You have been viewing this category! Do you want to delete?",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    : Text(
                                                        "Are You sure to delete this category?",
                                                        style: TextStyle(
                                                            color: seccolor,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                            color: seccolor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        )),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        await deleteNoteCategory(
                                                            mycategory[i]
                                                                .categoryId);
                                                        setState(() {
                                                          getcategory();
                                                        });
                                                      },
                                                      child: Text(
                                                        'Confirm',
                                                        style: TextStyle(
                                                          color: darkmain,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    backgroundColor: Colors.redAccent,
                                    icon: Icons.delete,
                                  ),
                                  const SizedBox(
                                    height: 0,
                                  ),
                                ],
                              ),
                              child: NoteCategoryModel(
                                eachnotecategory: mycategory[i],
                                userId: widget.userId,
                              ),
                            );
                          },
                        ),
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
              builder: (context) => CreateCategory(
                userId: widget.userId,
              ),
            ),
          );
        },
        label:  Text('Add',style: GoogleFonts.poppins(color: seccolor),),
        icon:  Icon(Icons.add,color: seccolor,),
      ),
    );
  }

  deleteNoteCategory(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await API().deleteNoteCategoryApi(id);
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (res['status'] == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteCategoryScreen(
              userId: widget.userId,
            ),
          ),
        );
      }
      showToast(context, res['message'], Colors.green);
    } else if (response.statusCode == 400) {
      Navigator.pop(context);
      showToast(context, res['message'], Colors.red);
    }
    //  Navigator.pop(context);
    //   showToast('${result['returncode']}', 'red');
    setState(() {});
  }
}

// ------------------------------------

class NoteCategoryModel extends StatefulWidget {
  notecategorylistmodel eachnotecategory;
  String userId;
  NoteCategoryModel(
      {super.key, required this.eachnotecategory, required this.userId});

  @override
  State<NoteCategoryModel> createState() => _NoteCategoryModelState();
}

class _NoteCategoryModelState extends State<NoteCategoryModel> {
  var time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotesScreen(
              categoryId: widget.eachnotecategory.categoryId,
              userId: widget.userId,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height * 0.1,
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: thirdcolor,
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // margin: const EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.eachnotecategory.categoryName,
                        style:
                            GoogleFonts.poppins(fontSize: 13, color: backcolor),
                      ),
                    ),
                    // Container(
                    //   // margin: const EdgeInsets.only(left: 10),
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     '${DateFormat('yMMMd').format(time)}',
                    //     style:
                    //         GoogleFonts.poppins(fontSize: 13, color: backcolor),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Container(
                          // margin: const EdgeInsets.only(left: 10),
                          alignment: Alignment.topLeft,
                          child: const Image(
                            image: AssetImage('images/folder.png'),
                            height: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 1,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Notes',
                            style: GoogleFonts.poppins(
                                fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: const Divider(
              color: Colors.grey,
              thickness: 0.2,
              height: 0,
              indent: 30,
            ),
          )
        ],
      ),
    );
  }
}
