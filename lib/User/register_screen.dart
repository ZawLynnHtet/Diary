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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
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
              children: [
                Center(
                  child: Image.asset(
                    'images/lawdiary.png',
                    width: 250,
                    height: 250,
                  ),
                ),
                Column(
                  children: [
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
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Name',
                            ),
                            controller: _nameController,
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please enter Name?'
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
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
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
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          final credential =
                              await auth.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        } finally {
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                          debugPrint('email verification');
                          register();
                        }
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
                              : const Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  register() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    final response = await API().registerUser(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
    );
    var res = jsonDecode(response.body);
    print('>>>>>>>>>userid>>>>>>>>>><${res['user']['userid']}');
    if (response.statusCode == 200) {
      token = prefs.getString("token")!;
      userid = prefs.getString("userid")!;
      name = prefs.getString('name')!;
      email = prefs.getString('email')!;
      password = prefs.getString('password')!;
      print('>>>>>>>>>>>>>>>>>>>>>>>>.token$token');
      print('>>>>>>>>>>>>>>>>>>>>>>>>.userid$userid');
      print('>>>>>>>>>>>>>>>>>>>>>>>>.email$email');
      print('>>>>>>>>>>>>>>>>>>>>>>>>.password$password');


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
      showToast(context, res['message'], Colors.green);
    } else if (response.statusCode != 200) {
      showToast(context, res['message'], Colors.red);
    }
    defaultCategoryName();
    setState(() {
      isLoading = false;
    });
  }
}
