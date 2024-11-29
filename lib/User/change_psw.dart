import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/drawer.dart';
import 'package:law_diary/home.dart';
import 'package:law_diary/localization/locales.dart';

class ChangePsw extends StatefulWidget {
  const ChangePsw({super.key});

  @override
  State<ChangePsw> createState() => _ChangePswState();
}

class _ChangePswState extends State<ChangePsw> {
  final TextEditingController _oldpswController = TextEditingController();
  final TextEditingController _newpswController = TextEditingController();
  bool _obscureText = true;

  final _advancedDrawerController = AdvancedDrawerController();

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: subcolor,
      appBar: AppBar(
        backgroundColor: subcolor,
        elevation: 0,
        leading: BackButton(
          color: darkmain,
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Text(
                  LocaleData.changePsw.getString(context),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: maincolor,
                  ),
                ),
                const SizedBox(height: 30),
                _buildPasswordField(
                  controller: _oldpswController,
                  hintText: LocaleData.oldPsw.getString(context),
                ),
                const SizedBox(height: 20),
                _buildPasswordField(
                  controller: _newpswController,
                  hintText: LocaleData.newPsw.getString(context),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      changePsw();
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: btncolor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        LocaleData.update.getString(context),
                        style: TextStyle(
                          color: seccolor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: _obscureText,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }
          return null;
        },
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
