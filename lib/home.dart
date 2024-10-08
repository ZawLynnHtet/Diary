// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:law_diary/Books/books.dart';
// import 'package:law_diary/Diary/daily_diary.dart';
// import 'package:law_diary/Note-Category/note-category.dart';
// import 'package:law_diary/User/logregistertest.dart';
// import 'package:law_diary/common.dart';
// import 'package:law_diary/drawer.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F3),
//       appBar: AppBar(
//         backgroundColor: fourthcolor,
//         elevation: 0,
//       ),
//       drawer: const DrawerPage(),
//       body: WillPopScope(
//         onWillPop: () async {
//           SystemNavigator.pop();
//           return false;
//         },
//         child: Stack(
//           children: [
//             Container(
//               height: size.height * .4,
//               decoration: BoxDecoration(
//                 color: fourthcolor,
//               ),
//             ),
//             SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 40),
//                       alignment: Alignment.topLeft,
//                       child: Text(
//                         'Hello!\nHow  is  your  day?',
//                         style: GoogleFonts.poppins(
//                           color: maincolor,
//                           fontSize: 25,
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),
//                     ),
//                     // Container(
//                     //   margin: const EdgeInsets.symmetric(vertical: 40),
//                     //   alignment: Alignment.topLeft,
//                     //   child: Text(
//                     //     'Log Out',
//                     //     style: GoogleFonts.poppins(
//                     //       color: maincolor,
//                     //       fontSize: 25,
//                     //       fontWeight: FontWeight.w900,
//                     //     ),
//                     //   ),
//                     // ),
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 20),
//                       alignment: Alignment.topLeft,
//                       child: Text(
//                         'Law is a set of rules that are created and are enforceable by social or governmental institutions to regulate behavior.',
//                         style: GoogleFonts.poppins(
//                           color: fifthcolor,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: GridView.count(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 20,
//                         mainAxisSpacing: 20,
//                         // childAspectRatio: .85,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         const DailyDiaryPage(),
//                                   ),
//                                 );
//                               });
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: fourthcolor,
//                                     spreadRadius: 1,
//                                     blurRadius: 3,
//                                     offset: const Offset(0, 0),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     child: Image.asset(
//                                       'images/diary.png',
//                                       height: 120,
//                                       width: 100,
//                                     ),
//                                   ),
//                                   Text(
//                                     'နေ့စဉ်မှတ်တမ်း',
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       const NoteCategoryScreen(),
//                                 ),
//                               );
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: fourthcolor,
//                                     spreadRadius: 1,
//                                     blurRadius: 3,
//                                     offset: const Offset(0, 0),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     child: Image.asset(
//                                       'images/notes.png',
//                                       height: 120,
//                                       width: 200,
//                                     ),
//                                   ),
//                                   Text(
//                                     'မှတ်ချက်',
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const BooksScreen(),
//                                 ),
//                               );
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: fourthcolor,
//                                     spreadRadius: 1,
//                                     blurRadius: 3,
//                                     offset: const Offset(0, 0),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     child: Image.asset(
//                                       'images/books.png',
//                                       height: 120,
//                                       width: 200,
//                                     ),
//                                   ),
//                                   Text(
//                                     'ဥပဒေစာအုပ်များ',
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {},
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: fourthcolor,
//                                     spreadRadius: 1,
//                                     blurRadius: 3,
//                                     offset: const Offset(0, 0),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 children: [
//                                   Center(
//                                     child: Text(
//                                       'တခြားအကြောင်းအရာများ',
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: GoogleFonts.poppins(
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // GestureDetector(
//                           //   onTap: () async {
//                           //     final prefs =
//                           //         await SharedPreferences.getInstance();
//                           //     await prefs.clear();
//                           //     setState(() {
//                           //       Navigator.pushReplacement(
//                           //         context,
//                           //         MaterialPageRoute(
//                           //           builder: (context) => const LogRegister(),
//                           //         ),
//                           //       );
//                           //     });
//                           //   },
//                           //   child: Container(
//                           //     margin: const EdgeInsets.symmetric(vertical: 10),
//                           //     alignment: Alignment.bottomRight,
//                           //     child: Text(
//                           //       'Log Out',
//                           //       style: GoogleFonts.poppins(
//                           //         color: seccolor,
//                           //         fontSize: 16,
//                           //         fontWeight: FontWeight.w900,
//                           //       ),
//                           //     ),
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/Books/books.dart';
import 'package:law_diary/Diary/daily_diary.dart';
import 'package:law_diary/Note-Category/note-category.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fourthcolor,
      appBar: AppBar(
        backgroundColor: fourthcolor,
        elevation: 0,
      ),
      drawer: const DrawerPage(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Law & Crime',
                    style: GoogleFonts.poppins(
                      color: maincolor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Foundations and Philosophy',
                    style: GoogleFonts.poppins(
                      color: fifthcolor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 0.85,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DailyDiaryPage(),
                            ),
                          );
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF232227),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Image.asset(
                                'images/diary.png',
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'နေ့စဉ်မှတ်တမ်း',
                                  style: GoogleFonts.poppins(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    fontWeight: FontWeight.bold,
                                    color: maincolor,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Daily Diary',
                                style: GoogleFonts.poppins(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NoteCategoryScreen(),
                            ),
                          );
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF232227),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Image.asset(
                                'images/notes.png',
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'မှတ်ချက်',
                                  style: GoogleFonts.poppins(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    fontWeight: FontWeight.bold,
                                    color: maincolor,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Notes',
                                style: GoogleFonts.poppins(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BooksScreen(),
                            ),
                          );
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF232227),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Image.asset(
                                'images/books.png',
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'ဥပဒေစာအုပ်များ',
                                  style: GoogleFonts.poppins(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    fontWeight: FontWeight.bold,
                                    color: maincolor,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Books',
                                style: GoogleFonts.poppins(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                       
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF232227),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Image.asset(
                                'images/blank.png',
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'စုံစမ်းရန်',
                                  style: GoogleFonts.poppins(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    fontWeight: FontWeight.bold,
                                    color: maincolor,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '09123456789',
                                style: GoogleFonts.poppins(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
