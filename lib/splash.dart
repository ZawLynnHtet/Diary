import 'dart:async';
import 'package:flutter/material.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/home.dart';
import 'package:law_diary/User/logregister.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.3, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    startTimer();
    getToken();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final getToken = prefs.getString('token');
    final getuserid = prefs.getString('userid');
    final getemail = prefs.getString('email');
    final getname = prefs.getString('name');
    final getpassword = prefs.getString('password');

    token = getToken.toString();
    userid = getuserid.toString();
    email = getemail.toString();
    name = getname.toString();
    password = getpassword.toString();
    setState(() {});
  }

  void startTimer() async {
    var duration = const Duration(seconds: 2);
    Timer(duration, route);
  }

  void route() {
    if (token == 'null') {
      token = '';
      userid = "";
      email = "";
      name = "";
      password = "";
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LogRegister(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
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
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation.value,
                child: Image.asset(
                  "images/law_bg.png",
                  width: 250,
                  height: 250,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}