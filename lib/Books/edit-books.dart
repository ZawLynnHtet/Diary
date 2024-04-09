// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:law_diary/Books/books.dart';
// import 'package:law_diary/Note-Category/note-category.dart';

// import '../API/api.dart';
// import '../common.dart';

// class EditBooks extends StatefulWidget {
//   String editData;
//   EditBooks({super.key, required this.editData});

//   @override
//   State<EditBooks> createState() => _EditBooksState();
// }

// class _EditBooksState extends State<EditBooks> {
//   final TextEditingController _attachmentnameController = TextEditingController();
//   bool isLoading = false;
//   var editData;

//   initData() {
//     print(">>>>>> editdata");
//     editData = jsonDecode(widget.editData);
//     print(">>>>>>>>>>>> edit data $editData");

//     setState(() {
//       if (editData != null) {
//         _attachmentnameController.text = editData["attachmentName"] ?? '';
//       }
//     });
//   }

//   @override
//   void initState() {
//     initData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: maincolor,
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: true,
//         backgroundColor: maincolor,
//         iconTheme: IconThemeData(
//           color: seccolor,
//           size: 30,
//         ),
//         title: Text(
//           "Update Category",
//           style: GoogleFonts.poppins(
//             fontSize: 20,
//             color: seccolor,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 30),
//           Padding(
//             padding: const EdgeInsets.only(
//               right: 15,
//               bottom: 10,
//               left: 15,
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.black),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: TextFormField(
//                   keyboardType: TextInputType.name,
//                   decoration: const InputDecoration(
//                     hintText: 'Enter Attachment Name',
//                     border: InputBorder.none,
//                   ),
//                   controller: _attachmentnameController,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 20.0),
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width - 30,
//               height: MediaQuery.of(context).size.height * 0.06,
//               child: MaterialButton(
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 color: darkmain,
//                 onPressed: () {
//                   if (_attachmentnameController.text.isEmpty) {
//                     showToast(
//                         context, 'Please Enter Attachment Name!!', Colors.red);
//                   } else {
//                     updateAttachment();
//                   }
//                 },
//                 child: isLoading
//                     ? const SpinKitRing(
//                         size: 23,
//                         lineWidth: 3,
//                         color: Colors.black,
//                       )
//                     : Text(
//                         'Update',
//                         style: GoogleFonts.poppins(
//                             color: maincolor,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500),
//                       ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//         ],
//       ),
//     );
//   }

//   updateAttachment() async {
//     print(">>>>>>>>>>> name");
//     print(_attachmentnameController.text);
//     isLoading = true;
//     final response = await API().editNoteCategoryApi(
//       editData["attachmentId"].toString(),
//       _attachmentnameController.text,
//     );
//     print("hererere");
//     var res = jsonDecode(response.body);
//     print(
//         ">>>>>>>>>>> edit attachment response statusCode ${response.statusCode}");
//     print(">>>>>>>>>>> edit attachment response body ${response.body}");
//     if (response.statusCode == 200) {
//       print("herer 0--");
//       // ignore: use_build_context_synchronously
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const BooksScreen(),
//         ),
//       );
//       showToast(context, res['message'], Colors.green);
//     } else if (response.statusCode == 400) {
//       showToast(context, res['message'], Colors.red);
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }
// }
