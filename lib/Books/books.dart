import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/model.dart';
import 'package:law_diary/Books/books-details.dart';
import 'package:law_diary/Books/edit-books.dart';
import 'package:law_diary/Law-Category/create-law-category.dart';
import 'package:law_diary/Law-Category/edit-law-category.dart';
import 'package:law_diary/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/api.dart';
import '../home.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  List<attachmentlistmodel> myattachment = [];
  attachmentlistmodel? selectedattachment;

  bool ready = false;
  bool isLoading = false;

  getattachment() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await API().getAttachmentApi();
    final res = jsonDecode(response.body);
    print('>>>>>>>>>>>>>>>>>>>>>>$response');
    if (response.statusCode == 200) {
      List attachmentList = res['data'];
      print('>>>>>>>>>>>>>>> attachment list$attachmentList');
      if (attachmentList.isNotEmpty) {
        for (var i = 0; i < attachmentList.length; i++) {
          myattachment.add(
            attachmentlistmodel(
              attachmentId: attachmentList[i]['attachmentId'] ?? "",
              attachmentName: attachmentList[i]['attachmentName'] ?? "",
              attachmentFile: attachmentList[i]['attachmentFile'] ?? "",
            ),
          );
        }
      } else if (response.statusCode == 400) {
        myattachment = [];

        showToast(context, res['message'], Colors.red);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getattachment();
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
            Navigator.pop(context);
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: myattachment.length,
              itemBuilder: (context, i) {
                return BooksModel(eachattachment: myattachment[i]);
              },
            ),
          ),
        ),
      ),
    );
  }

  // deleteLawCategory(id) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final response = await API().deleteLawCategoryApi(id);
  //   var res = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     if (res['status'] == 'success') {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => LawCategoryScreen(),
  //         ),
  //       );
  //     }
  //     showToast(context, res['message'], Colors.green);
  //   } else if (response.statusCode == 400) {
  //     Navigator.pop(context);
  //     showToast(context, res['message'], Colors.red);
  //   }
  //   //  Navigator.pop(context);
  //   //   showToast('${result['returncode']}', 'red');
  //   setState(() {});
  // }
}

// ------------------------------------

class BooksModel extends StatefulWidget {
  attachmentlistmodel eachattachment;
  BooksModel({super.key, required this.eachattachment});

  @override
  State<BooksModel> createState() => _BooksModelState();
}

class _BooksModelState extends State<BooksModel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PDFViewerPage(pdfUrl: widget.eachattachment.attachmentFile),
          ),
        );
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: thirdcolor),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.eachattachment.attachmentName,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: maincolor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.2,
              height: 0,
            ),
          ],
        ),
      ),
    );
  }
}
