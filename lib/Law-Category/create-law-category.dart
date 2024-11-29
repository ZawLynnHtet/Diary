import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/API/model.dart';
import 'package:law_diary/common.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit-law-category.dart';

class CreateLawCategory extends StatefulWidget {
  const CreateLawCategory({super.key});

  @override
  State<CreateLawCategory> createState() => _CreateLawCategoryState();
}

class _CreateLawCategoryState extends State<CreateLawCategory> {
  final TextEditingController _categorynameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool isLoading = false;
  List<lawcategorylistmodel> mycategory = [];
  lawcategorylistmodel? selectedcategory;

  getcategory() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await API().getAllLawCategoriesApi();
    final res = jsonDecode(response.body);
    print('>>>>>>>>>>>>>>>>>>>>>>$response');
    if (response.statusCode == 200) {
      List categoryList = res['data'];
      print('>>>>>>>>>>>>>>> category list$categoryList');
      if (categoryList.isNotEmpty) {
        for (var i = 0; i < categoryList.length; i++) {
          mycategory.add(
            lawcategorylistmodel(
              categoryId: categoryList[i]['categoryId'],
              categoryName: categoryList[i]['categoryName'],
              categoryDesc: categoryList[i]['categoryDesc'],
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
        elevation: 0,
        centerTitle: true,
        backgroundColor: thirdcolor,
        leading: BackButton(
          color: maincolor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Create Case Type",
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (_categorynameController.text == "") {
                showToast(context, "Enter Category!!", Colors.red);
              } else {
                setState(() {
                  createLawCategory();
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 6, 5, 6),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: isLoading
                      ? const SpinKitRing(
                          size: 23,
                          lineWidth: 3,
                          color: Colors.black,
                        )
                      : Text(
                          'Add',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
                bottom: 10,
                left: 15,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: TextFormField(
                  style: TextStyle(color: backcolor),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: fifthcolor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: fifthcolor),
                    ),
                    labelText: 'Enter Case Type',
                    labelStyle: TextStyle(color: fifthcolor),
                    // border: InputBorder.none,
                  ),
                  controller: _categorynameController,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SafeArea(
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
                                    "categoryId": mycategory[i].categoryId,
                                    "categoryName": mycategory[i].categoryName,
                                    "categoryDesc": mycategory[i].categoryDesc,
                                  });
                                  print(">>>>> my data");
                                  print(mydata);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditLawCategory(
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
                                      contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        top: 15,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          mycategory[i].categoryId ==
                                                  selectedcategory?.categoryId
                                              ? const Text(
                                                  "You have been viewing this category! Do you want to delete?",
                                                  style: TextStyle(
                                                      color: Colors.redAccent,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              : Text(
                                                  "Are You sure to delete this category?",
                                                  style: TextStyle(
                                                      color: seccolor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
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
                                                    Navigator.pop(context);
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
                                                  await deleteLawCategory(
                                                      mycategory[i].categoryId);
                                                  setState(() {
                                                    getcategory();
                                                  });
                                                },
                                                child: Text(
                                                  'Confirm',
                                                  style: TextStyle(
                                                    color: darkmain,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
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
                        child: LawCategoryModel(
                          eachlawcategory: mycategory[i],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  deleteLawCategory(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await API().deleteLawCategoryApi(id);
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (res['status'] == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateLawCategory(),
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

  createLawCategory() async {
    isLoading = true;
    final response = await API().createLawCategoryApi(
      _categorynameController.text,
      _descriptionController.text,
    );
    print("hererere");
    var res = jsonDecode(response.body);
    print(
        ">>>>>>>>>>> create law category response statusCode ${response.statusCode}");
    print(">>>>>>>>>>> create law category response body ${response.body}");
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateLawCategory(),
        ),
      );
    } else if (response.statusCode == 400) {
      showToast(context, res['message'], Colors.red);
    }
    setState(() {
      isLoading = false;
    });
  }
}

class LawCategoryModel extends StatefulWidget {
  lawcategorylistmodel eachlawcategory;
  LawCategoryModel({super.key, required this.eachlawcategory});

  @override
  State<LawCategoryModel> createState() => _LawCategoryModelState();
}

class _LawCategoryModelState extends State<LawCategoryModel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateLawCategory(),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: thirdcolor,
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.eachlawcategory.categoryName,
                        style:
                            GoogleFonts.poppins(fontSize: 13, color: backcolor),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.eachlawcategory.categoryDesc,
                        style:
                            GoogleFonts.poppins(fontSize: 13, color: backcolor),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
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



