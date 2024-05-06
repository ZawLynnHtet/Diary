import 'dart:async';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:law_diary/common.dart';
import 'package:path_provider/path_provider.dart';

class PDFViewerPage extends StatefulWidget {
  final String pdfUrl;

  PDFViewerPage({required this.pdfUrl});

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PDFViewController _pdfViewController;
  String? _pdfPath;

  @override
  void initState() {
    super.initState();
    _initPdf();
  }

  Future<void> _initPdf() async {
    final url = 'https://tmm.tastysoft.co/uploads/${widget.pdfUrl}';
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
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
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
            fontSize: 17,
            color: darkmain,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _pdfPath != null
          ? PDFView(
              filePath: _pdfPath!,
              autoSpacing: true,
              enableSwipe: true,
              pageSnap: true,
              swipeHorizontal: false,
              onViewCreated: (PDFViewController pdfViewController) {
                _pdfViewController = pdfViewController;
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}


