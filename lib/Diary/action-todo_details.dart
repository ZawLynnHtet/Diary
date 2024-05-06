import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/model.dart';
import 'package:law_diary/common.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ActionTodoDetails extends StatefulWidget {
  String actions;
  String toDo;
  String notes;
  String pdffile;
  ActionTodoDetails({
    super.key,
    required this.actions,
    required this.toDo,
    required this.notes,
    required this.pdffile,
  });

  @override
  State<ActionTodoDetails> createState() => _ActionTodoDetailsState();
}

class _ActionTodoDetailsState extends State<ActionTodoDetails> {
  List<diarydetailslistmodel> mydetails = [];
  diarydetailslistmodel? selecteddetails;

  List<diarylistmodel> mydiary = [];
  diarylistmodel? selecteddiary;

  bool ready = false;
  bool isLoading = false;

  late PDFViewController _pdfViewController;
  String? _pdfPath;

  Future<void> _initPdf() async {
    final url = widget.pdffile;
    final filename = url.substring(url.lastIndexOf('/') + 1);
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/$filename';
    final file = File(filePath);

    if (await file.exists()) {
      // If the file already exists, just set the path
      setState(() {
        _pdfPath = filePath;
      });
    } else {
      // If the file does not exist, download it
      final response = await http.get(Uri.parse(url));
      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        _pdfPath = filePath;
      });
    }
  }

  @override
  void initState() {
    print('>>>>>>>>>><<<<<<<<<<<<<<,,${widget.actions}');
    _initPdf();
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
          Navigator.pop(context);
          return false;
        },
        child: isLoading
            ? SpinKitRing(
                size: 23,
                lineWidth: 3,
                color: maincolor,
              )
            : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'ဆောင်ရွက်ချက်',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: darkmain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      widget.actions,
                      maxLines: 10,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: maincolor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'ဆောင်ရွက်ရန်',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: darkmain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      widget.toDo,
                      maxLines: 10,
                      style:
                          GoogleFonts.poppins(fontSize: 15, color: maincolor),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'မှတ်ချက်',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: darkmain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      widget.notes,
                      maxLines: 10,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: maincolor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'ဖိုင်',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: darkmain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 1,
                      child: _pdfPath != null
                          ? PDFView(
                              filePath: _pdfPath!,
                              autoSpacing: true,
                              enableSwipe: true,
                              pageSnap: true,
                              swipeHorizontal: false,
                              onViewCreated:
                                  (PDFViewController pdfViewController) {
                                _pdfViewController = pdfViewController;
                              },
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
