import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:law_diary/User/logregister.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Law Diary',
      debugShowCheckedModeBanner: false,
      // home: LogRegister(),
      home: LogRegister(),
    );
    
  }
}
