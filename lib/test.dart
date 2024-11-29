// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_localization/flutter_localization.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:law_diary/API/api.dart';
// import 'package:law_diary/API/model.dart';
// import 'package:law_diary/Diary/create_diary.dart';
// import 'package:law_diary/Diary/edit_diary.dart';
// import 'package:law_diary/common.dart';
// import 'package:law_diary/home.dart';
// import 'package:law_diary/localization/locales.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:table_calendar/table_calendar.dart';

// class DailyDiaryPage extends StatefulWidget {
//   const DailyDiaryPage({super.key});

//   @override
//   State<DailyDiaryPage> createState() => _DailyDiaryPageState();
// }

// class _DailyDiaryPageState extends State<DailyDiaryPage> {
//   List<diarylistmodel> mydiary = [];
//   bool isLoading = false;
//   bool hasError = false;
//   String errorMessage = '';
//   DateTime _selectedDate = DateTime.now();
//   Map<DateTime, List<diarylistmodel>> _eventsByDate = {};

//   Future<void> getdiary() async {
//     setState(() {
//       isLoading = true;
//       hasError = false;
//       errorMessage = '';
//       _eventsByDate.clear();
//     });

//     try {
//       final response = await API().getAllDiariesApi();
//       final res = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         List diaryList = res['data'];
//         final Map<DateTime, List<diarylistmodel>> updatedEvents = {};

//         final updatedDiaryList = diaryList.map((diary) {
//           final diaryDate = DateTime.parse(diary['appointment']);
//           if (!updatedEvents.containsKey(diaryDate)) {
//             updatedEvents[diaryDate] = [];
//           }
//           updatedEvents[diaryDate]!.add(
//             diarylistmodel(
//               diaryid: diary['diaryid'] ?? "",
//               clientname: diary['clientname'] ?? "",
//               action: diary['action'] ?? "",
//               todo: diary["todo"] ?? "",
//               causenum: diary["causenum"] ?? "",
//               appointment: diary["appointment"] ?? "",
//             ),
//           );
//           return diarylistmodel(
//             diaryid: diary['diaryid'] ?? "",
//             clientname: diary['clientname'] ?? "",
//             action: diary['action'] ?? "",
//             todo: diary["todo"] ?? "",
//             causenum: diary["causenum"] ?? "",
//             appointment: diary["appointment"] ?? "",
//           );
//         }).toList();
//         setState(() {
//           mydiary = updatedDiaryList;
//           _eventsByDate = updatedEvents;
//         });
//       } else {
//         setState(() {
//           hasError = true;
//           errorMessage = res['message'];
//         });
//       }
//     } catch (e) {
//       setState(() {
//         hasError = true;
//         errorMessage = 'An error occurred while fetching data: $e';
//       });
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   List<diarylistmodel> _getEventsForDay(DateTime day) {
//     return mydiary
//         .where((diary) =>
//             diary.appointment.isNotEmpty &&
//             DateFormat('yyyy-MM-dd')
//                     .format(DateTime.parse(diary.appointment)) ==
//                 DateFormat('yyyy-MM-dd').format(day))
//         .toList();
//   }

//   bool isLandscape = false;

//   void toggleOrientation() {
//     if (isLandscape) {
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//         DeviceOrientation.portraitDown,
//       ]);
//     } else {
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.landscapeRight,
//         DeviceOrientation.landscapeLeft,
//       ]);
//     }
//     setState(() {
//       isLandscape = !isLandscape;
//     });
//   }

//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     getdiary();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final diariesForSelectedDate = _getEventsForDay(_selectedDate);

//     return Scaffold(
//       backgroundColor: maincolor,
//       appBar: AppBar(
//         backgroundColor: maincolor,
//         elevation: 0,
//         leading: BackButton(
//           color: darkmain,
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const HomeScreen()),
//             );
//           },
//         ),
//         title: Text(
//           LocaleData.ongoingcaseList.getString(context),
//           style: GoogleFonts.poppins(
//             fontSize: 17,
//             color: darkmain,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               isLandscape ? Icons.screen_lock_portrait : Icons.rotate_right,
//               color: darkmain,
//             ),
//             onPressed: toggleOrientation,
//           ),
//         ],
//       ),
//       body: WillPopScope(
//         onWillPop: () async {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const HomeScreen()),
//           );
//           return false;
//         },
//         child: isLoading
//             ? Center(
//                 child: SpinKitRing(size: 50, lineWidth: 5, color: maincolor),
//               )
//             : hasError
//                 ? Center(
//                     child: Text(
//                       errorMessage,
//                       style: GoogleFonts.poppins(
//                         color: Colors.red,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   )
//                 : SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         TableCalendar(
//                           focusedDay: _selectedDate,
//                           firstDay: DateTime(2000),
//                           lastDay: DateTime(2100),
//                           calendarFormat: CalendarFormat.week,
//                           selectedDayPredicate: (day) =>
//                               isSameDay(_selectedDate, day),
//                           onDaySelected: (selectedDay, focusedDay) {
//                             setState(() {
//                               _selectedDate = selectedDay;
//                             });
//                           },
//                           calendarStyle: CalendarStyle(
//                             todayDecoration: BoxDecoration(
//                               color: Colors.blueAccent,
//                               shape: BoxShape.circle,
//                             ),
//                             selectedDecoration: BoxDecoration(
//                               color: Colors.green,
//                               shape: BoxShape.circle,
//                             ),
//                             weekendTextStyle: GoogleFonts.poppins(
//                               color: Colors.redAccent,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             holidayTextStyle: GoogleFonts.poppins(
//                               color: Colors.redAccent,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             outsideTextStyle: GoogleFonts.poppins(
//                               color: Colors.grey,
//                             ),
//                             markerDecoration: BoxDecoration(
//                               color: Colors.redAccent,
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                           headerStyle: HeaderStyle(
//                             formatButtonVisible: false,
//                             titleCentered: true,
//                             leftChevronIcon:
//                                 Icon(Icons.arrow_left, color: Colors.black),
//                             rightChevronIcon:
//                                 Icon(Icons.arrow_right, color: Colors.black),
//                             headerMargin: const EdgeInsets.only(bottom: 10),
//                             titleTextStyle: GoogleFonts.poppins(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           eventLoader: (day) {
//                             return _eventsByDate[day] ?? [];
//                           },
//                           calendarBuilders: CalendarBuilders(
//                             markerBuilder: (context, day, events) {
//                               if (events.isNotEmpty) {
//                                 return Positioned(
//                                   bottom: 4,
//                                   child: Container(
//                                     width: 8,
//                                     height: 8,
//                                     decoration: BoxDecoration(
//                                       color: Colors.deepOrangeAccent,
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                 );
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 10.0),
//                         diariesForSelectedDate.isEmpty
//                             ? Center(
//                                 child: Text(
//                                   LocaleData.empty.getString(context),
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 16,
//                                     color: Colors.grey,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               )
//                             : SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: DataTable(
//                                   headingRowColor:
//                                       MaterialStateColor.resolveWith(
//                                           (states) => Colors.grey.shade200),
//                                   dataRowColor: MaterialStateColor.resolveWith(
//                                       (states) => Colors.grey.shade50),
//                                   border: TableBorder.all(
//                                       color: Colors.grey.shade300, width: 1),
//                                   headingTextStyle: GoogleFonts.poppins(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.blueGrey,
//                                   ),
//                                   dataTextStyle: GoogleFonts.poppins(
//                                     fontSize: 15,
//                                     color: Colors.black87,
//                                   ),
//                                   columnSpacing: 20,
//                                   horizontalMargin: 10,
//                                   columns:  [
//                                     DataColumn(label: Text(LocaleData.client.getString(context),)),
//                                     DataColumn(label: Text(LocaleData.action.getString(context),)),
//                                     DataColumn(label: Text(LocaleData.todo.getString(context),)),
//                                     DataColumn(label: Text(LocaleData.caseNo.getString(context),)),
//                                     DataColumn(label: Text(LocaleData.appointment.getString(context),)),
//                                     DataColumn(label: Text(LocaleData.edit.getString(context),)),
//                                     DataColumn(label: Text(LocaleData.delete.getString(context),)),
//                                   ],
//                                   rows: diariesForSelectedDate.map((diary) {
//                                     return DataRow(cells: [
//                                       DataCell(Text(diary.clientname)),
//                                       DataCell(Text(diary.action)),
//                                       DataCell(Text(diary.todo)),
//                                       DataCell(Text(diary.causenum)),
//                                       DataCell(Text(
//                                         diary.appointment.isNotEmpty
//                                             ? DateFormat('yyyy-MM-dd').format(
//                                                 DateTime.parse(
//                                                     diary.appointment))
//                                             : 'No Appointment',
//                                       )),
//                                       DataCell(
//                                         IconButton(
//                                           icon: Icon(Icons.edit,
//                                               color: Colors.blue),
//                                           onPressed: () async {
//                                             bool success = await Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         EditDiary(
//                                                       editData: jsonEncode({
//                                                         "diaryid":
//                                                             diary.diaryid,
//                                                         "clientname":
//                                                             diary.clientname,
//                                                         "action": diary.action,
//                                                         "todo": diary.todo,
//                                                         "causenum":
//                                                             diary.causenum,
//                                                         "appointment":
//                                                             diary.appointment,
//                                                       }),
//                                                       diaryId: diary.diaryid,
//                                                     ),
//                                                   ),
//                                                 ) ??
//                                                 false;

//                                             if (success) {
//                                               getdiary();
//                                             }
//                                           },
//                                         ),
//                                       ),
//                                       DataCell(
//                                         IconButton(
//                                           icon: Icon(Icons.delete,
//                                               color: Colors.red),
//                                           onPressed: () {
//                                             showDialog(
//                                               context: context,
//                                               builder: (context) => AlertDialog(
//                                                 title: Text(
//                                                     LocaleData.confirmDelete.getString(context),style: TextStyle(
//                                                       fontSize: 18,
//                                                     ),),
//                                                 actions: [
//                                                   TextButton(
//                                                       onPressed: () =>
//                                                           Navigator.pop(
//                                                               context),
//                                                       child: Text(LocaleData.no.getString(context),)),
//                                                   TextButton(
//                                                       onPressed: () {
//                                                         deleteDiary(
//                                                             diary.diaryid);
//                                                         Navigator.pop(context);
//                                                       },
//                                                       child: Text(LocaleData.yes.getString(context),)),
//                                                 ],
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ]);
//                                   }).toList(),
//                                 ),
//                               ),
//                       ],
//                     ),
//                   ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: subcolor,
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const CreateDiary()),
//           );
//         },
//         child: Icon(Icons.add, color: darkmain),
//       ),
//     );
//   }

//   deleteDiary(String id) async {
//     final response = await API().deleteDiaryApi(id);
//     var res = jsonDecode(response.body);

//     if (response.statusCode == 200) {
//       await getdiary();
//       setState(() {
//         _selectedDate = _selectedDate;
//       });
//       showToast(context, 'Diary deleted successfully.', Colors.green);
//     } else if (response.statusCode == 400) {
//       Navigator.pop(context);
//       showToast(context, res['message'], Colors.red);
//     }
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
// import 'package:flutter_localization/flutter_localization.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:law_diary/Books/books.dart';
// import 'package:law_diary/Diary/daily_diary.dart';
// import 'package:law_diary/common.dart';
// import 'package:law_diary/drawer.dart';
// import 'package:law_diary/localization/locales.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final _advancedDrawerController = AdvancedDrawerController();

//   void _handleMenuButtonPressed() {
//     _advancedDrawerController.showDrawer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AdvancedDrawer(
//       controller: _advancedDrawerController,
//       backdropColor: darkmain,
//       drawer: const DrawerPage(),
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: subcolor,
//           elevation: 0,
//           leading: IconButton(
//             onPressed: _handleMenuButtonPressed,
//             icon: Icon(
//               Icons.menu,
//               color: darkmain,
//             ),
//           ),
//         ),
//         backgroundColor: subcolor,
//         body: Stack(
//           children: [
//             _buildBackgroundDecoration(),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildHeader(context),
//                   const SizedBox(height: 20),
//                   Divider(color: seccolor, thickness: 1),
//                   const SizedBox(height: 10),
//                   Expanded(
//                     child: ListView(
//                       children: [
//                         _buildHorizontalScrollMenu(context),
//                         _buildSectionTitle(LocaleData.features.getString(context),),
//                         const SizedBox(height: 12),
//                         _buildFeatureCard(
//                           context: context,
//                           image: Image.asset(
//                             'assets/icons/law.png',
//                             width: 50,
//                             height: 50,
//                           ),
//                           title: LocaleData.title.getString(context),
//                           subtitle: LocaleData.des1.getString(context),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const DailyDiaryPage(),
//                               ),
//                             );
//                           },
//                         ),
//                         const SizedBox(height: 16),
//                         _buildFeatureCard(
//                           context: context,
//                           image: Image.asset(
//                             'assets/icons/law-book.png',
//                             width: 50,
//                             height: 50,
//                           ),
//                           title: LocaleData.books.getString(context),
//                           subtitle: LocaleData.des2.getString(context),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const BooksScreen(),
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         bottomNavigationBar: Container(
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color:  const Color.fromARGB(255, 222, 197, 174),
//             border: Border(
//               top: BorderSide(color: seccolor, width: 1),
//             ),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Divider(color: seccolor, thickness: 1),
//               const SizedBox(height: 8),
//               Text(
//                 "Powered by Law Diary",
//                 style: GoogleFonts.poppins(
//                   color: seccolor,
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           LocaleData.title.getString(context),
//           style: GoogleFonts.poppins(
//             color: darkmain,
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           LocaleData.secTitle.getString(context),
//           style: GoogleFonts.poppins(
//             color: darkmain,
//             fontSize: 16,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFeatureCard({
//     required BuildContext context,
//     required Image image,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             image,
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: darkmain,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     subtitle,
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: GoogleFonts.poppins(
//         color: darkmain,
//         fontSize: 20,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }

//   Widget _buildBackgroundDecoration() {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             subcolor,
//             const Color.fromARGB(255, 222, 197, 174)
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//     );
//   }

//   Widget _buildHorizontalScrollMenu(BuildContext context) {
//     return SizedBox(
//       height: 100,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           _buildQuickAccessTile(
//             icon: Icons.event_note,
//             label: "Diary",
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const DailyDiaryPage(),
//                 ),
//               );
//             },
//           ),
//           _buildQuickAccessTile(
//             icon: Icons.book,
//             label: "Books",
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const BooksScreen(),
//                 ),
//               );
//             },
//           ),
//           _buildQuickAccessTile(
//             icon: Icons.person,
//             label: "Profile",
//             onTap: () {
//               // Add navigation to settings here
//             },
//           ),
//         ],
//       ),
//     );
//   }

//    Widget _buildQuickAccessTile({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 80,
//         margin: const EdgeInsets.symmetric(horizontal: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 4,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 36, color: darkmain),
//             const SizedBox(height: 8),
//             Text(
//               label,
//               style: GoogleFonts.poppins(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: darkmain,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

