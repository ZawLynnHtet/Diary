import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color seccolor = Colors.black;

Color fourthcolor = const Color.fromARGB(255, 42, 42, 42);

Color fifthcolor = Colors.grey;

Color thirdcolor = const Color.fromARGB(255, 33, 32, 32);

Color maincolor = const Color(0xFFffffff);

Color darkmain = const Color.fromARGB(255, 146, 121, 97);

Color backcolor = const Color(0xFFF5F5F3);

Color btncolor = const Color.fromARGB(255, 219, 213, 213);

var fcmtoken;
String token = "";
String userID = "";
String email = "";
String name = "";

void showToast(BuildContext context, msg, color) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: color,
      duration: (const Duration(seconds: 1)),
      content: Text(msg),
    ),
  );
}

TextStyle buttonTextStyle =
    TextStyle(color: maincolor, fontSize: 15, fontWeight: FontWeight.w500);

TextStyle firstTextstyle = GoogleFonts.poppins(
    color: seccolor, fontSize: 14, fontWeight: FontWeight.w400);

// defaultCategoryName() async {
//   // final prefs = await SharedPreferences.getInstance();
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   final response = await API().getDefaultCategoryApi();
//   final defCategory = jsonDecode(response.body);
//   if (response.statusCode == 200) {
//     List<Map<String, dynamic>> _defCategories = defCategory['data'];
//     await prefs.setString("defaultcategories", jsonEncode(_defCategories));
//   } else if (response.statusCode != 200) {
//     // ignore: use_build_context_synchronously
//   }
// }
void defaultCategoryName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final response = await API().getDefaultCategoryApi();
  final defCategory = jsonDecode(response.body);
  if (response.statusCode == 200) {
    List<dynamic> jsonData = defCategory['data'];
    List<Map<String, dynamic>> _defCategories = jsonData.cast<Map<String, dynamic>>();
    await prefs.setString("defaultcategories", jsonEncode(_defCategories));
  } else if (response.statusCode != 200) {
    // handle error here
  }
}
