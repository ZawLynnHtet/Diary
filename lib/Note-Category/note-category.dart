import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/Notes/notes.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit-note-category.dart';

class NoteCategoryScreen extends StatefulWidget {
  const NoteCategoryScreen({super.key});

  @override
  State<NoteCategoryScreen> createState() => _NoteCategoryScreenState();
}

class _NoteCategoryScreenState extends State<NoteCategoryScreen> {
  final TextEditingController _categorynameController = TextEditingController();
  // List<notecategorylistmodel> mycategory = [];
  List? selectedcategory;
  List mycategory = [];

  bool ready = false;
  bool isLoading = false;

  defCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('defaultcategories');
    List<dynamic> jsonData = jsonDecode(jsonString!);
    List<Map<String, dynamic>> categoryList =
        jsonData.cast<Map<String, dynamic>>();
    mycategory = categoryList;
    print("++++++++++++${mycategory}");
    getcategory();
    setState(() {});
  }

  getcategory() async {
    isLoading = true;
    final response = await API().getAllNotesCategoryApi();
    final res = jsonDecode(response.body);
    print('>>>>>>>>>>>>>>>>>>>>>>$response');
    if (response.statusCode == 200) {
      List categoryList = res['data'];
      if (categoryList.isNotEmpty) {
        for (var i = 0; i < categoryList.length; i++) {
          mycategory.add(categoryList[i]);
          print("mycategory++++++===$mycategory");
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
    defCategories();
    super.initState();
    setState(() {
      // ready = true;
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       leading: BackButton(
  //         color: darkmain,
  //         onPressed: () {
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => const HomeScreen(),
  //             ),
  //           );
  //         },
  //       ),
  //       title: Text("hello"),
  //     ),
  //     body: ListView.builder(
  //       shrinkWrap: true,
  //         itemCount: mycategory.length,
  //         itemBuilder: (ctx, index) {
  //           return Container(
  //             width: 40,
  //             height: 40,
  //             decoration: BoxDecoration(
  //               color: Colors.blue,
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: Text(
  //               mycategory[index]['categoryName'],
  //               style: TextStyle(color: Colors.red),
  //             ),
  //           );
  //         }),
  //   );
  // }

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
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
            : mycategory!.isEmpty
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
                          itemCount: mycategory!.length,
                          itemBuilder: (context, i) {
                            return Slidable(
                              enabled: mycategory[i]['default'] == true
                                  ? false
                                  : true,
                              endActionPane: ActionPane(
                                // extentRatio: 0.26,
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      setState(() {
                                        print(">>>>> my data");
                                        var mydata = jsonEncode({
                                          "categoryId": mycategory![i]
                                              ['categoryId'],
                                          "categoryName": mycategory![i]
                                              ['categoryName'],
                                        });
                                        print(">>>>> my data");
                                        print(mydata);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditNoteCategory(
                                              editData: mydata,
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
                                                mycategory![i]['categoryId'] ==
                                                        selectedcategory?[0]
                                                            ['categoryId']
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
                                                              FontWeight.w500,
                                                        ),
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
                                                        child: const Text(
                                                          "No",
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        )),
                                                    TextButton(
                                                      onPressed: () async {
                                                        // Navigator.pop(context);
                                                        await deleteNoteCategory(
                                                          mycategory![i]
                                                              ['categoryId'],
                                                        );
                                                        setState(() {
                                                          getcategory();
                                                        });
                                                      },
                                                      child: const Text(
                                                        'Yes',
                                                        style: TextStyle(
                                                          color: Colors.red,
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
                                eachnotecategory: mycategory![i],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: darkmain,
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const CreateCategory(),
      //       ),
      //     );
      //   },
      //   label: Text(
      //     'Add',
      //     style: GoogleFonts.poppins(color: seccolor),
      //   ),
      //   icon: Icon(
      //     Icons.add,
      //     color: seccolor,
      //   ),
      // ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: darkmain,
        onPressed: () {
          _showDialog(context);
        },
        label: Text(
          'Add',
          style: GoogleFonts.poppins(color: seccolor),
        ),
        icon: Icon(
          Icons.add,
          color: seccolor,
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: maincolor,
          title: Text(
            'Enter Category Name',
            style: GoogleFonts.poppins(color: seccolor),
          ),
          content: TextFormField(
            style: TextStyle(color: seccolor),
            keyboardType: TextInputType.name,
            minLines: 1,
            maxLines: 10,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: fifthcolor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: fifthcolor),
              ),
              labelText: 'ခေါင်းစဉ်',
              labelStyle: TextStyle(color: fifthcolor),
            ),
            controller: _categorynameController,
          ),
          actions: [
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            //   child: Text(
            //     'Cancel',
            //     style: GoogleFonts.poppins(),
            //   ),
            // ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkmain,
              ),
              onPressed: () {
                createNoteCategory();
                // if (_categorynameController.text == "") {
                //   showToast(context, "ခေါင်းစဉ်ထည့်ပါ!!", Colors.red);
                // } else {
                //   setState(() {
                //     createNoteCategory();
                //   });
                // }
              },
              child: isLoading
                  ? SpinKitRing(
                      size: 23,
                      lineWidth: 3,
                      color: maincolor,
                    )
                  : Text(
                      'Done',
                      style: GoogleFonts.poppins(),
                    ),
            ),
          ],
        );
      },
    );
  }

  createNoteCategory() async {
    isLoading = true;
    final response = await API().createNoteCategoryApi(
      _categorynameController.text,
    );
    print("hererere");
    var res = jsonDecode(response.body);
    print(
        ">>>>>>>>>>> create note category response statusCode ${response.statusCode}");
    print(">>>>>>>>>>> create note category response body ${response.body}");
    if (response.statusCode == 200) {
      print("herer 0--");
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NoteCategoryScreen(),
        ),
      );
    } else if (response.statusCode == 400) {
      showToast(context, res['message'], Colors.red);
    }
    setState(() {
      isLoading = false;
    });
  }

  deleteNoteCategory(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await API().deleteNoteCategoryApi(id);
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (res['status'] == 'success') {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NoteCategoryScreen(),
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
  final eachnotecategory;
  const NoteCategoryModel({
    super.key,
    required this.eachnotecategory,
  });

  @override
  State<NoteCategoryModel> createState() => _NoteCategoryModelState();
}

class _NoteCategoryModelState extends State<NoteCategoryModel> {
  var time = DateTime.now();
  var _eachnotecategory = {};

  @override
  void initState() {
    print(widget.eachnotecategory);
    setState(() {
      _eachnotecategory = widget.eachnotecategory;
      print("-----------$_eachnotecategory");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print('>>>>>>>>>>>>>>>>>>>>${_eachnotecategory['categoryId']}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotesScreen(
              categoryId: _eachnotecategory['categoryId'],
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
                        _eachnotecategory['categoryName'],
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
          ),
        ],
      ),
    );
  }
}
