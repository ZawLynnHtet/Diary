import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/User/login_screen.dart';
import 'package:law_diary/User/register_screen.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/main.dart';

class LogRegister extends StatefulWidget {
  const LogRegister({super.key});

  @override
  State<LogRegister> createState() => _LogRegisterState();
}

class _LogRegisterState extends State<LogRegister> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: maincolor,
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: size.height * 0.53,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      // bottomLeft: Radius.circular(40),
                      // bottomRight: Radius.circular(40),
                      ),
                  color: thirdcolor,
                  image: const DecorationImage(
                    image: AssetImage(
                      "images/lawdiary.png",
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.6,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Justice For All',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: seccolor,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Law is a set of rules that are created and\n are enforceable by governmental institutions.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: fifthcolor,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        height: size.height * 0.07,
                        width: size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: maincolor,
                            border: Border.all(color: maincolor),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.05),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: const Offset(0, -1),
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Row(
                            children: [
                              Container(
                                height: size.height * 0.07,
                                width: size.width / 2.2,
                                decoration: BoxDecoration(
                                  color: Colors.black12.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen(),
                                          ),
                                        );
                                      });
                                    },
                                    child: Text(
                                      'Register',
                                      style: GoogleFonts.poppins(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: seccolor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  });
                                },
                                child: Text(
                                  'Sign In',
                                  style: GoogleFonts.poppins(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: seccolor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
