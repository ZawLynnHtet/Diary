import 'dart:async';
import 'package:flutter/material.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/User/logregistertest.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/home.dart';
import 'package:law_diary/User/logregister.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final getToken = prefs.getString('token');
    final getuserid = prefs.getString('userId');
    final getemail = prefs.getString('email');
    token = getToken.toString();
    userID = getuserid.toString();
    email = getemail.toString();
    setState(() {});
  }

  startTimer() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() async {
    if (token == 'null') {
      token = '';
      userID = "";
      email = "";
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LogRegister(),
        ),
      );
    } else {
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    startTimer();
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        dividerColor: thirdcolor,
      ),
      child: Scaffold(
        backgroundColor: thirdcolor,
        body: Center(
          child: Image.asset(
            "images/lawdiary.png",
            width: 250,
            height: 250,
          ),
        ),
        persistentFooterButtons: [
          Center(
            child: Image.network(
              'https://cdn-icons-gif.flaticon.com/15571/15571090.gif',
              width: 50,
              height: 50,
            ),
          ),
        ],
        // persistentFooterButtons: [
        //   Center(
        //     child: Image.asset(
        //       "images/car.gif",
        //       width: 90,
        //       height: 90,
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
