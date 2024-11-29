// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:law_diary/common.dart';

// class CreateBookPage extends StatefulWidget {
//   const CreateBookPage({super.key});

//   @override
//   State<CreateBookPage> createState() => _CreateBookPageState();
// }

// class _CreateBookPageState extends State<CreateBookPage> {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//         setState(() {});
//       },
//       child: Scaffold(
//         backgroundColor: maincolor,
//         appBar: AppBar(
//           backgroundColor: subcolor,
//           elevation: 0,
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(
//                   context,
//                 );
//               },
//               icon: Icon(
//                 Icons.chevron_left_outlined,
//                 color: maincolor,
//                 size: 35,
//               )),
//           title: Text(
//             "Create Book",
//             style: GoogleFonts.poppins(
//               fontSize: screenWidth * 0.045,
//               color: maincolor,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Book Title",
//                 style: TextStyle(
//                   fontSize: screenWidth * 0.035,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.005),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       decoration: _buildInputDecoration(),
//                     ),
//                   ),
//                   SizedBox(width: 5,),
//                   Container(
//                     height: 48,
//                     width: 50,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: subcolor
//                     ),
//                     child: Text("Save",
//                     style: TextStyle(
//                       color: maincolor
//                     ),),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Text(
//                 "Section List",
//                 style: TextStyle(
//                   fontSize: screenWidth * 0.035,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.005),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       decoration: _buildInputDecoration(),
//                     ),
//                   ),
//                   SizedBox(width: 5,),
//                   Container(
//                     height: 48,
//                     width: 50,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: subcolor
//                     ),
//                     child: Text("Save",
//                     style: TextStyle(
//                       color: maincolor
//                     ),),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   InputDecoration _buildInputDecoration() {
//     return InputDecoration(
//       filled: true,
//       fillColor: Colors.white,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: fifthcolor),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: const BorderSide(color: Colors.blue),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/Books/create_subsection.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/localization/locales.dart';

class CreateBookPage extends StatefulWidget {
  @override
  _CreateBookPageState createState() => _CreateBookPageState();
}

class _CreateBookPageState extends State<CreateBookPage> {
  bool isLoading = false;
  bool isAddTitle = false;
  String bookid = "";
  final TextEditingController _bookTitleController = TextEditingController();
  TextEditingController _controller = TextEditingController();
  final Map<String, List<String>> _sections =
      {}; // Map of section titles and their subsections
  final Map<String, TextEditingController> _sectionControllers = {};
  final Map<String, Map<String, TextEditingController>> _subsectionControllers =
      {};

  @override
  void dispose() {
    _bookTitleController.dispose();
    _sectionControllers.forEach((_, controller) => controller.dispose());
    _subsectionControllers.forEach((_, map) {
      map.forEach((_, controller) => controller.dispose());
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: maincolor,
        appBar: AppBar(
          backgroundColor: maincolor,
          title: Text(
            "Create Book",
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.045,
              color: seccolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Book Title Section
              Text(
                "Book Title",
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      decoration: _buildInputDecoration(),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 48,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: subcolor),
                    child: Text(
                      "Save",
                      style: TextStyle(color: maincolor),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Sections
              Text(
                'Sections',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _sections.keys.length,
                itemBuilder: (context, sectionIndex) {
                  final sectionTitle = _sections.keys.elementAt(sectionIndex);
                  final subsections = _sections[sectionTitle]!;

                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: ExpansionTile(
                        backgroundColor:
                            const Color.fromARGB(255, 215, 215, 215),
                        shape: Border.all(color: Colors.transparent),
                        title: Text(sectionTitle),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: maincolor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  // itemCount: subsections.length,
                                  itemCount: 2,
                                  itemBuilder: (context, subIndex) {
                                    return ListTile(
                                      title: Text(
                                        // subsections[subIndex],
                                        "Test1",
                                        style: TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: subcolor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateSubsection()),
                                      );
                                    },
                                    title: Text(
                                      "Add Subsections",
                                      style: TextStyle(
                                          color: maincolor,
                                          fontSize: 13,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right_outlined,
                                      size: 19,
                                      color: maincolor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _sectionControllers.putIfAbsent(
                          '', () => TextEditingController()),
                      decoration: _buildInputDecoration(),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      // if (isAddTitle) {
                      _controller = _sectionControllers['']!;
                      if (_controller.text.isNotEmpty) {
                        setState(() {
                          _sections[_controller.text] = [];
                          // _subsectionControllers[controller.text] = {};
                          _controller.clear();
                        });
                      }
                      // } else {
                      //   showToast(context, 'Please first add book title',
                      //       Colors.red);
                      // }
                    },
                    child: Container(
                      height: 48,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: maincolor,
                          border: Border.all(color: fifthcolor)),
                      child: Icon(Icons.add),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: fifthcolor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue),
      ),
    );
  }

  createTitle() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (_bookTitleController.text.isEmpty) {
        showToast(context, LocaleData.bookTitle.getString(context), Colors.red);
        return;
      }

      final response = await API().createTitle(_bookTitleController.text);

      final res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        isAddTitle = true;
        bookid = res['data']['bookid'];
      } else {
        showToast(context, res['message'] ?? 'မှားယွင်းမှုတခုဖြစ်ပွါးနေသည်',
            Colors.red);
      }
    } catch (e) {
      print("Error: $e");
      showToast(context, "ခေါင်းစဉ်ဖန်တီးမှု မအောင်မြင်ပါ", Colors.red);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  createSection(bookid) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (_bookTitleController.text.isEmpty) {
        showToast(context, LocaleData.bookTitle.getString(context), Colors.red);
        return;
      }

      final response = await API().createSection(bookid, _controller.text);

      final res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        isAddTitle = true;
        bookid = res['data']['bookid'];
      } else {
        showToast(context, res['message'] ?? 'မှားယွင်းမှုတခုဖြစ်ပွါးနေသည်',
            Colors.red);
      }
    } catch (e) {
      print("Error: $e");
      showToast(context, "ခေါင်းစဉ်ဖန်တီးမှု မအောင်မြင်ပါ", Colors.red);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
