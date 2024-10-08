import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/drawer.dart';
import 'package:law_diary/home.dart';
import 'package:pinput/pinput.dart';

class ForgotPsw extends StatefulWidget {
  const ForgotPsw({super.key});

  @override
  State<ForgotPsw> createState() => _ForgotPswState();
}

class _ForgotPswState extends State<ForgotPsw> {
  bool _obscureText = true;
  final TextEditingController _newPswController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _comfirmPassword = TextEditingController();
  bool _verify = false;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 53,
        height: 60,
        textStyle: const TextStyle(
          fontSize: 22,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          color: btncolor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.transparent),
        ));
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
                child: _verify == false
                    ? Column(
                        children: [
                          Text(
                            "Verification",
                            style: GoogleFonts.poppins(
                              color: maincolor,
                              fontSize: MediaQuery.of(context).size.width * 0.07
                            ),
                          ),
                          Text(
                            'သင့်Emailထံသို့ဂဏန်းခြောက်လုံးပါသော OTP Code ပို့လိုက်ပါပြီ',
                            style: GoogleFonts.poppins(
                                color: maincolor,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              child: Pinput(
                                length: 6,
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: defaultPinTheme.copyWith(
                                  decoration:
                                      defaultPinTheme.decoration!.copyWith(
                                    border: Border.all(color: fifthcolor),
                                  ),
                                ),
                                onCompleted: (pin) => debugPrint(pin),
                                controller: _otpController,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () async {
                              verifyOtp();
                              setState(() {});
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: btncolor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              margin:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: Center(
                                  child: Icon(
                                Icons.check,
                                size: 40,
                                color: Colors.green,
                              )),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Form(
                        child: Column(
                        children: [
                          Text(
                            'Change your New Password',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: maincolor,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
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
                                  controller: _newPswController,
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
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
                                  controller: _comfirmPassword,
                                  obscureText: _obscureText,
                                  validator: (value) {
                                    return value!.isEmpty
                                        ? 'Comfirm password'
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
                                setNewPsw();
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: BoxDecoration(
                                color: btncolor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin:
                                  const EdgeInsets.only(left: 25, right: 25),
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

  setNewPsw() async {
    if (_newPswController.text == _comfirmPassword.text) {
      final response = await API().setNewPws(
        email,
        _otpController.text,
        _newPswController.text,
      );
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          showToast(context, res['message'], Colors.green);
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
    } else {
      showToast(context, "Your password is not match", Colors.red);
    }
  }

  verifyOtp() async {
    final response = await API().verify(
      email,
      _otpController.text,
    );
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _verify = true;
      });
      showToast(context, res['message'], Colors.green);
    } else {
      // ignore: use_build_context_synchronously
      showToast(context, res['message'], Colors.red);
    }
  }
}
