// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:law_diary/API/model.dart';
// import 'package:law_diary/Law-Category/create-law-category.dart';
// import 'package:law_diary/Law-Category/edit-law-category.dart';
// import 'package:law_diary/common.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../API/api.dart';
// import '../home.dart';

// class LawCategoryScreen extends StatefulWidget {
//   const LawCategoryScreen({super.key});

//   @override
//   State<LawCategoryScreen> createState() => _LawCategoryScreenState();
// }

// class _LawCategoryScreenState extends State<LawCategoryScreen> {
//   List<lawcategorylistmodel> mycategory = [];
//   lawcategorylistmodel? selectedcategory;

//   bool ready = false;
//   bool isLoading = false;

//   getcategory() async {
//     isLoading = true;
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final response = await API().getAllLawCategoriesApi();
//     final res = jsonDecode(response.body);
//     print('>>>>>>>>>>>>>>>>>>>>>>$response');
//     if (response.statusCode == 200) {
//       List categoryList = res['data'];
//       print('>>>>>>>>>>>>>>> category list$categoryList');
//       if (categoryList.isNotEmpty) {
//         for (var i = 0; i < categoryList.length; i++) {
//           mycategory.add(
//             lawcategorylistmodel(
//               categoryId: categoryList[i]['categoryId'],
//               categoryName: categoryList[i]['categoryName'],
//               categoryDesc: categoryList[i]['categoryDesc'],
//             ),
//           );
//         }
//       } else if (response.statusCode == 400) {
//         mycategory = [];

//         showToast(context, res['message'], Colors.red);
//       }
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     getcategory();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: thirdcolor,
//       appBar: AppBar(
//         backgroundColor: thirdcolor,
//         elevation: 0,
//         leading: BackButton(
//           color: backcolor,
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const HomeScreen(),
//               ),
//             );
//           },
//         ),
//         title: Text(
//           'Category',
//           style: GoogleFonts.poppins(
//             fontSize: 20,
//             color: backcolor,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: isLoading
//           ? const SpinKitRing(
//               size: 23,
//               lineWidth: 3,
//               color: Colors.black,
//             )
//           : mycategory.isEmpty
//               ? Center(
//                   child: Text(
//                   "Empty",
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: fifthcolor,
//                   ),
//                 ))
//               : SafeArea(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height,
//                       width: MediaQuery.of(context).size.width,
//                       child: ListView.builder(
//                         itemCount: mycategory.length,
//                         itemBuilder: (context, i) {
//                           return Slidable(
//                             endActionPane: ActionPane(
//                               // extentRatio: 0.26,
//                               motion: const StretchMotion(),
//                               children: [
//                                 SlidableAction(
//                                   onPressed: (context) {
//                                     setState(() {
//                                       print(">>>>> my data");
//                                       var mydata = jsonEncode({
//                                         "categoryId": mycategory[i].categoryId,
//                                         "categoryName":
//                                             mycategory[i].categoryName,
//                                         "categoryDesc":
//                                             mycategory[i].categoryDesc,
//                                       });
//                                       print(">>>>> my data");
//                                       print(mydata);
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => EditLawCategory(
//                                             editData: mydata,
//                                           ),
//                                         ),
//                                       );
//                                     });
//                                   },
//                                   backgroundColor: Colors.blue,
//                                   icon: Icons.edit,
//                                 ),
//                                 SlidableAction(
//                                   onPressed: (context) {
//                                     showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           contentPadding: const EdgeInsets.only(
//                                             left: 10,
//                                             top: 15,
//                                           ),
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                           content: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               mycategory[i].categoryId ==
//                                                       selectedcategory
//                                                           ?.categoryId
//                                                   ? const Text(
//                                                       "You have been viewing this category! Do you want to delete?",
//                                                       style: TextStyle(
//                                                           color:
//                                                               Colors.redAccent,
//                                                           fontSize: 15,
//                                                           fontWeight:
//                                                               FontWeight.w500),
//                                                     )
//                                                   : Text(
//                                                       "Are You sure to delete this category?",
//                                                       style: TextStyle(
//                                                           color: seccolor,
//                                                           fontSize: 15,
//                                                           fontWeight:
//                                                               FontWeight.w500),
//                                                     ),
//                                               const SizedBox(
//                                                 height: 10,
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.end,
//                                                 children: [
//                                                   TextButton(
//                                                       onPressed: () {
//                                                         Navigator.pop(context);
//                                                       },
//                                                       child: Text(
//                                                         "Cancel",
//                                                         style: TextStyle(
//                                                           color: seccolor,
//                                                           fontSize: 14,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                         ),
//                                                       )),
//                                                   TextButton(
//                                                     onPressed: () async {
//                                                       Navigator.pop(context);
//                                                       await deleteLawCategory(
//                                                           mycategory[i]
//                                                               .categoryId);
//                                                       setState(() {
//                                                         getcategory();
//                                                       });
//                                                     },
//                                                     child: Text(
//                                                       'Confirm',
//                                                       style: TextStyle(
//                                                         color: darkmain,
//                                                         fontSize: 14,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                     );
//                                   },
//                                   backgroundColor: Colors.redAccent,
//                                   icon: Icons.delete,
//                                 ),
//                                 const SizedBox(
//                                   height: 0,
//                                 ),
//                               ],
//                             ),
//                             child: LawCategoryModel(
//                               eachlawcategory: mycategory[i],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: darkmain,
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const CreateLawCategory(),
//             ),
//           );
//         },
//         label: const Text('Add'),
//         icon: const Icon(Icons.add),
//       ),
//     );
//   }

//   deleteLawCategory(id) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final response = await API().deleteLawCategoryApi(id);
//     var res = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       if (res['status'] == 'success') {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => LawCategoryScreen(),
//           ),
//         );
//       }
//       showToast(context, res['message'], Colors.green);
//     } else if (response.statusCode == 400) {
//       Navigator.pop(context);
//       showToast(context, res['message'], Colors.red);
//     }
//     //  Navigator.pop(context);
//     //   showToast('${result['returncode']}', 'red');
//     setState(() {});
//   }
// }

// // ------------------------------------

// class LawCategoryModel extends StatefulWidget {
//   lawcategorylistmodel eachlawcategory;
//   LawCategoryModel({super.key, required this.eachlawcategory});

//   @override
//   State<LawCategoryModel> createState() => _LawCategoryModelState();
// }

// class _LawCategoryModelState extends State<LawCategoryModel> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const LawCategoryScreen(),
//           ),
//         );
//       },
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: thirdcolor,
//             ),
//             padding: const EdgeInsets.all(10),
//             margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
//             child: Row(
//               children: [
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       alignment: Alignment.topLeft,
//                       child: Text(
//                         widget.eachlawcategory.categoryName,
//                         style:
//                             GoogleFonts.poppins(fontSize: 13, color: backcolor),
//                       ),
//                     ),
//                     Container(
//                       alignment: Alignment.topLeft,
//                       child: Text(
//                         widget.eachlawcategory.categoryDesc,
//                         style:
//                             GoogleFonts.poppins(fontSize: 13, color: backcolor),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 3,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
//             child: const Divider(
//               color: Colors.grey,
//               thickness: 0.2,
//               height: 0,
//               indent: 30,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
