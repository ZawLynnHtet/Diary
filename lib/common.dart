import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



Color seccolor = Colors.black;

Color fourthcolor = const Color.fromARGB(255, 42, 42, 42);

Color fifthcolor = Colors.grey;

Color thirdcolor = const Color.fromARGB(255, 33, 32, 32);

Color maincolor = const Color(0xFFffffff);

Color darkmain = const Color.fromARGB(255, 146, 121, 97);

Color backcolor = const  Color(0xFFF5F5F3);

Color btncolor = const Color.fromARGB(255, 219, 213, 213);



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

TextStyle buttonTextStyle = TextStyle(
    color: maincolor,
    fontSize: 15,
    fontWeight: FontWeight.w500);

TextStyle firstTextstyle = GoogleFonts.poppins(
    color: seccolor,
    fontSize: 14,
    fontWeight: FontWeight.w400);

