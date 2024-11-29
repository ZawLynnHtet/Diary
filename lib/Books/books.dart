import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:law_diary/Books/books-details.dart';
import 'package:law_diary/Books/create_book.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/localization/locales.dart';

import '../API/api.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  bool ready = false;
  bool isLoading = false;
  bool _addtitle = false;
  List _booklist = [];
  String _bookid = "";
  bool _search = false;
  List _filteredBooklist = [];
  final TextEditingController _searchController = TextEditingController();

  Future<void> _getAllBooks() async {
    setState(() {
      isLoading = true;
    });

    final response = await API().getAllBooks();
    final res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      _booklist = res['data'] ?? [];
      _filteredBooklist = _booklist;
      print(_filteredBooklist);
      ready = true;
    } else {
      showToast(context, res['message'], Colors.red);
    }
    setState(() {
      isLoading = false;
    });
  }

  void _filterBooks(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredBooklist = _booklist;
      });
    } else {
      setState(() {
        _filteredBooklist = _booklist
            .where((book) => book['title']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllBooks();
    setState(() {});
    _searchController.addListener(() {
      _filterBooks(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          _search = false;
        });
      },
      child: Scaffold(
        backgroundColor: maincolor,
        appBar: AppBar(
          backgroundColor: subcolor,
          elevation: 0,
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
          title: _search
              ? TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: LocaleData.search.getString(context),
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: _filterBooks,
                  controller: _searchController,
                )
              : Text(
                  LocaleData.books.getString(context),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: maincolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          actions: _search
              ? []
              : [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _search = true;
                        });
                      },
                      icon: Icon(
                        Icons.search_outlined,
                        size: 30,
                        color: maincolor,
                      ))
                ],
        ),
        body: isLoading
            ? SpinKitRing(
                size: 23,
                lineWidth: 3,
                color: fifthcolor,
              )
            : _filteredBooklist.isEmpty
                ? Center(
                    child: Text(
                      LocaleData.emptymsg.getString(context),
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
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _filteredBooklist.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 3),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                              child: ExpansionTile(
                                shape: Border.all(color: Colors.transparent),
                                title: Text(
                                  _filteredBooklist[index]['title'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0D1B40),
                                    fontFamily: "SFProText",
                                  ),
                                ),
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: _filteredBooklist[index]
                                              ['sections']
                                          .length,
                                      itemBuilder: (context, i) {
                                        return ExpansionTile(
                                          shape: Border(
                                              top:
                                                  BorderSide(color: fifthcolor),
                                              bottom: BorderSide(
                                                  color: fifthcolor)),
                                          title: Text(
                                            (i + 1).toString() +
                                                "." +
                                                " " +
                                                _filteredBooklist[index]
                                                        ['sections'][i]
                                                    ['sectionname'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF0D1B40),
                                                fontFamily: "SFProText",
                                                fontWeight: FontWeight.w700),
                                          ),
                                          children: [
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    _filteredBooklist[index]
                                                                ['sections'][i]
                                                            ['subsections']
                                                        .length,
                                                itemBuilder: (context, j) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        var passData =
                                                            _filteredBooklist[
                                                                        index][
                                                                    'sections'][i]
                                                                [
                                                                'subsections'][j];
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      DetailsPage(
                                                                        item:
                                                                            passData,
                                                                      )),
                                                        );
                                                      },
                                                      child: ListTile(
                                                        title: Text(
                                                          _filteredBooklist[
                                                                          index]
                                                                      [
                                                                      'sections'][i]
                                                                  [
                                                                  'subsections'][j]
                                                              [
                                                              'subsectionname'],
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF0D1B40),
                                                              fontFamily:
                                                                  "SFProText",
                                                              fontSize: 13,
                                                              letterSpacing: 1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        trailing: Icon(
                                                          Icons
                                                              .chevron_right_outlined,
                                                          color:
                                                              Color(0xFF0D1B40),
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })
                                          ],
                                        );
                                      })
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
        floatingActionButton: FloatingActionButton(
          // backgroundColor: darkmain,
          backgroundColor: subcolor,
          foregroundColor: maincolor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateBookPage()),
            );
          },
          shape: CircleBorder(),
          child: Icon(Icons.add),
          // label: Text('', style: GoogleFonts.poppins(color: seccolor)),
          // icon: Icon(Icons.add, color: seccolor),
        ),
      ),
    );
  }

  // String formatDate(DateTime date) {
  //   final currentYear = DateTime.now().year;
  //   if (date.year == currentYear) {
  //     return DateFormat('MMMM d').format(date);
  //   } else {
  //     return DateFormat('MMMM d, yyyy').format(date);
  //   }
  // }

  deleteTitle(String id) async {
    final response = await API().deleteTitle(id);
    var res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      _getAllBooks();
      showToast(context, 'Title deleted successfully.', Colors.green);
    } else if (response.statusCode == 400) {
      Navigator.pop(context);
      showToast(context, res['message'], Colors.red);
    }
  }
}
