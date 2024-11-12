import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/home.dart';
import 'package:law_diary/User/logregister.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool isLoading = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;

  userAuth() {
    currentUser = auth.currentUser;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
    userAuth();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LogRegister(),
            ),
          );
          return false;
        },
        child: Scaffold(
          backgroundColor: thirdcolor,
          appBar: AppBar(
            backgroundColor: thirdcolor,
            elevation: 0,
            leading: BackButton(
              color: maincolor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LogRegister(),
                  ),
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'images/lawdiary.png',
                    width: 250,
                    height: 250,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Form(
                    child: Column(
                      children: [
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
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Email',
                                  border: InputBorder.none,
                                ),
                                controller: _emailController,
                                validator: (value) {
                                  return value!.isEmpty
                                      ? 'Please enter Email?'
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
                                  hintText: 'Enter Password',
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
                                controller: _passwordController,
                                obscureText: _obscureText,
                                validator: (value) {
                                  return value!.isEmpty
                                      ? 'Please enter password'
                                      : null;
                                },
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 25),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Text(
                        //         'Forgot Password?',
                        //         style: TextStyle(
                        //           color: Colors.blue[600],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            login();
                            setState(() {});
                            // if (_emailController.text == "") {
                            //   showToast(context, "Enter Email", Colors.red);
                            // } else if (_passwordController.text == "") {
                            //   showToast(context, "Enter Password", Colors.red);
                            // } else {
                            //   setState(() {
                            // register();
                            //   });
                            // }
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
                              child: isLoading
                                  ? const SpinKitRing(
                                      size: 23,
                                      lineWidth: 3,
                                      color: Colors.black,
                                    )
                                  : Text(
                                      'Sign In',
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    final response = await API().loginUser(
      _emailController.text,
      _passwordController.text,
    );
    print(response);
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('>>>>>>>>>>>>>>>>>>>>>>>>.token$token');
      print("+++++++++++${res['user']['userid']}");
      token = res["token"];
      userID = res['user']['userid'];
      email = res['user']['email'];
      name = res['user']['name'];
      await prefs.setString("token", token.toString());
      await prefs.setString("userid", userID.toString());
      await prefs.setString('email', res['user']['email']);
      await prefs.setString('name', res['user']['name']);
      print('>>>>>>>>>>>>>>>>>>>>>>>>.token$token');
      print('>>>>>>>>>>>>>>>>>>>>>>>>.userid$userID');
      print('>>>>>>>>>>>>>>>>>>>>>>>>.email$email');
      print('>>>>>>>>>>>>>>>>>>>>>>>>.name$name');
      print(prefs.getString("token"));
      // print(">>>>. firebase fcm token 1 $fcmtoken");
      try {
        fcmtoken = await FirebaseMessaging.instance.getToken();
      } catch (e) {
        print(">>>>e fcmtoken error $e");
        fcmtoken = "";
      }
      print(">>>>. firebase fcm token 2 $fcmtoken");
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else if (response.statusCode != 200) {
      // ignore: use_build_context_synchronously
      showToast(context, res['message'], Colors.red);
    }
    // defaultCategoryName();
    setState(() {
      isLoading = false;
    });
  }
}
