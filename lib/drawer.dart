import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/User/change_psw.dart';
import 'package:law_diary/User/forgot-psw.dart';
import 'package:law_diary/User/upload_profile.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/home.dart';
import 'package:law_diary/User/logregister.dart';
import 'package:law_diary/localization/locales.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  bool isLoading = false;
  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;

  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
  }

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UploadProfilePage()),
                  );
                },
                child: CircleAvatar(
                  child: ClipOval(
                    child: Text(
                      name == '' ? "" : name[0].toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
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
                  LocaleData.home.getString(context),
                  style: GoogleFonts.poppins(
                    color: maincolor,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
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
                  LocaleData.changePassword.getString(context),
                  style: GoogleFonts.poppins(
                    color: maincolor,
                    fontSize: 15,
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
                            LocaleData.confirmResetPassword.getString(context),
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
                                  LocaleData.no.getString(context),
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
                                  LocaleData.yes.getString(context),
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
                  LocaleData.forgotPassword.getString(context),
                  style: GoogleFonts.poppins(
                    color: maincolor,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: DropdownButton(
                value: _currentLocale,
                dropdownColor: subcolor, // Change this to your preferred color
                style: TextStyle(
                    color: seccolor), // Text color for the selected item
                items: [
                  DropdownMenuItem(
                    value: "en",
                    child: Text("English", style: TextStyle(color: maincolor)),
                  ),
                  DropdownMenuItem(
                    value: "my",
                    child: Text("မြန်မာ", style: TextStyle(color: maincolor)),
                  ),
                ],
                onChanged: (value) {
                  _setLocale(value);
                },
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
                            LocaleData.confirmLogout.getString(context),
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
                                  LocaleData.no.getString(context),
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
                                  LocaleData.yes.getString(context),
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
                  LocaleData.logout.getString(context),
                  style: GoogleFonts.poppins(
                    color: maincolor,
                    fontSize: 15,
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
      userid,
    );
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('>>>>>>>>>>>>>>>>>>>>>>>>.userid////####$userid');
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
      userid,
    );
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        Navigator.push(
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

  void _setLocale(String? value) {
    if (value == null) return;
    if (value == "en") {
      _flutterLocalization.translate("en");
    } else if (value == "my") {
      _flutterLocalization.translate("my");
    } else {
      return;
    }
    setState(() {
      _currentLocale = value;
    });
  }
}
