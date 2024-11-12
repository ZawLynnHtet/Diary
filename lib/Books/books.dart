import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:law_diary/API/model.dart';
import 'package:law_diary/common.dart';

import '../API/api.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  bool ready = false;
  bool isLoading = false;
  bool isSectLoading = false;
  int _expandedIndex = -1;
  bool _isExpand = false;
  final url = 'https://www.unionsupremecourt.gov.mm/dailys';
  List<booklistmodel> _booklist = [];
  List<sectionlistmodel> _sectionlist = [];

  Future<void> _getAllBooks() async {
    setState(() {
      isLoading = true;
    });

    final response = await API().getAllBooks();
    final res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List tembooklist = res['data'];
      _booklist = tembooklist.map((book) {
        return booklistmodel(
          bookid: book['bookid'] ?? "",
          title: book['title'] ?? "",
          createdAt: book['createdAt'] ?? "",
          updatedAt: book['updatedAt'] ?? "",
        );
      }).toList();
    } else {
      showToast(context, res['message'], Colors.red);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _getAllSections(bookid) async {
    setState(() {
      isSectLoading = true;
    });
    final response = await API().getAllSections(bookid);
    final res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List tempsectionlist = res['data'];
      _sectionlist = tempsectionlist.map((section) {
        return sectionlistmodel(
          sectionid: section['sectionid'] ?? "",
          sectionname: section['sectionname'] ?? "",
          createdAt: section['createdAt'] ?? "",
          updatedAt: section['updatedAt'] ?? "",
        );
      }).toList();
    } else {
      showToast(context, res['message'], Colors.red);
    }
    setState(() {
      isSectLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllBooks();
    setState(() {});
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
          'ဥပဒေစာအုပ်များ',
          style: GoogleFonts.poppins(
            fontSize: 20,
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
          : _booklist.isEmpty
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
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: _booklist.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_expandedIndex == index) {
                                  _expandedIndex = -1;
                                } else {
                                  _expandedIndex = index;
                                  _sectionlist = [];
                                  _getAllSections(_booklist[index].bookid);
                                }
                              });
                            },
                            child: Card(
                              // color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                (index + 1).toString() +
                                                    "." +
                                                    _booklist[index].title,
                                                style: TextStyle(
                                                    color: darkmain,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Icon(
                                                _expandedIndex == index
                                                    ? Icons
                                                        .arrow_drop_down_rounded
                                                    : Icons.arrow_right_rounded,
                                                size: 35,
                                              )
                                            ],
                                          ),
                                          Text(
                                            formatDate(DateTime.parse(
                                                _booklist[index].createdAt)),
                                            style: TextStyle(
                                                color: darkmain,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                      _expandedIndex == index
                                          ? Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(20),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    isSectLoading
                                                        ? SpinKitRing(
                                                            size: 23,
                                                            lineWidth: 3,
                                                            color: fifthcolor,
                                                          )
                                                        : _sectionlist.isEmpty
                                                            ? Center(
                                                                child: Text(
                                                                  "Empty",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    fontSize:
                                                                        16,
                                                                    color:
                                                                        fifthcolor,
                                                                  ),
                                                                ),
                                                              )
                                                            : ListView.builder(
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                itemCount:
                                                                    _sectionlist
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        i) {
                                                                  return Text(
                                                                    _sectionlist[
                                                                            i]
                                                                        .sectionname,
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          darkmain,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                    Divider(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: TextFormField(
                                                            style: TextStyle(
                                                                color:
                                                                    backcolor),
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            decoration: InputDecoration(
                                                                hintText: "Add sections",
                                                                hintStyle: TextStyle(
                                                                  color: darkmain,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w300,
                                                                  fontStyle: FontStyle.italic
                                                                ),
                                                                border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    borderSide: BorderSide(
                                                                      color:
                                                                          fifthcolor,
                                                                    ))),
                                                          ),
                                                        ),
                                                        Icon(Icons.add),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: darkmain,
        backgroundColor: darkmain,
        foregroundColor: Colors.white,
        onPressed: () {
          _showAlertDialog(context);
        },
        child: Icon(Icons.add),
        // label: Text('', style: GoogleFonts.poppins(color: seccolor)),
        // icon: Icon(Icons.add, color: seccolor),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: maincolor,
          title: Text(
            'Enter Book Name',
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
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkmain,
              ),
              onPressed: () {},
              child: Text(
                'Done',
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        );
      },
    );
  }

  String formatDate(DateTime date) {
    final currentYear = DateTime.now().year;
    if (date.year == currentYear) {
      // Format as "Month Day" if the date is in the current year
      return DateFormat('MMMM d').format(date);
    } else {
      // Format as "Month Day, Year" if it's from a previous year
      return DateFormat('MMMM d, yyyy').format(date);
    }
  }
}
