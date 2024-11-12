import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/User/change_psw.dart';
import 'package:law_diary/User/forgot-psw.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/home.dart';
import 'package:law_diary/User/logregister.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // backgroundColor: thirdcolor,
      child: Container(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                name,
                style: GoogleFonts.poppins(fontSize: 16, color: maincolor),
              ),
              accountEmail: Text(
                email,
                style: GoogleFonts.poppins(fontSize: 13, color: maincolor),
              ),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  setState(() {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const UploadProfile(),
                    //   ),
                    // );
                  });
                },
                child: CircleAvatar(
                  child: ClipOval(
                    child: Text(
                      name == '' ? "" : name[0].toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                      ),
                    ),
                    // child: Image.asset(
                    //   'images/profile.jpg',
                    //   height: 120,
                    //   width: 120,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),

                // CircleAvatar(
                //   child: ClipOval(
                //     child: Image.asset(
                //       'images/profile.jpg',
                //       height: 120,
                //       width: 120,
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                });
              },
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: maincolor,
                ),
                title: Text(
                  'Home',
                  style: GoogleFonts.poppins(
                    color: maincolor,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePsw(),
                    ),
                  );
                });
              },
              child: ListTile(
                leading: Icon(
                  Icons.password,
                  color: maincolor,
                ),
                title: Text(
                  'Change Password',
                  style: GoogleFonts.poppins(
                    color: maincolor,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.only(
                        left: 10,
                        top: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Are You sure to reset your password?",
                            style: TextStyle(
                              color: seccolor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "No",
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  forgotPsw();
                                  setState(() {});
                                },
                                child: Text(
                                  'Yes',
                                  style: GoogleFonts.poppins(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.password,
                  color: maincolor,
                ),
                title: Text(
                  'Forgot Password',
                  style: GoogleFonts.poppins(
                    color: maincolor,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.only(
                        left: 10,
                        top: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Are You sure to Log Out?",
                            style: TextStyle(
                              color: seccolor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "No",
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  logout();
                                },
                                child: Text(
                                  'Yes',
                                  style: GoogleFonts.poppins(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: maincolor,
                ),
                title: Text(
                  'Log Out',
                  style: GoogleFonts.poppins(
                    color: maincolor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  logout() async {
    final response = await API().logoutUser(
      userID,
    );
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('>>>>>>>>>>>>>>>>>>>>>>>>.userId////####$userID');
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LogRegister(),
          ),
        );
      });
    } else if (response.statusCode != 200) {
      // ignore: use_build_context_synchronously
      showToast(context, "Something Wrong!", Colors.red);
    }
  }

  forgotPsw() async {
    final response = await API().forgotPsw(
      email,
      userID,
    );
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ForgotPsw(),
          ),
        );
      });
    } else if (response.statusCode != 200) {
      // ignore: use_build_context_synchronously
      showToast(context, res['message'], Colors.red);
    }
  }
}
