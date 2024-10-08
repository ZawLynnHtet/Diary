import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/drawer.dart';
import 'package:law_diary/home.dart';
import 'package:law_diary/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePsw extends StatefulWidget {
  const ChangePsw({super.key});

  @override
  State<ChangePsw> createState() => _ChangePswState();
}

class _ChangePswState extends State<ChangePsw> {
  final TextEditingController _oldpswController = TextEditingController();
  final TextEditingController _newpswController = TextEditingController();
  bool _obscureText = true;
  // bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thirdcolor,
      appBar: AppBar(
        backgroundColor: thirdcolor,
        elevation: 0,
      ),
      drawer: const DrawerPage(),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Form(
                    child: Column(
                  children: [
                    Text(
                      'Change your New Password',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        color: maincolor,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: btncolor,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter Old Password',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            controller: _oldpswController,
                            obscureText: _obscureText,
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please enter old password'
                                  : null;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: btncolor,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter New Password',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            controller: _newpswController,
                            obscureText: _obscureText,
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please enter new password'
                                  : null;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          changePsw();
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: btncolor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        child: Center(
                          child: Text(
                            'Update',
                            style: TextStyle(
                              color: seccolor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  changePsw() async {
    final response = await API().changePsw(
      email,
      _oldpswController.text,
      _newpswController.text,
    );
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      });
    } else if (response.statusCode != 200) {
      // ignore: use_build_context_synchronously
      showToast(context, res['message'], Colors.red);
    }
  }
}
