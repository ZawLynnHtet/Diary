// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:law_diary/User/register_screen.dart';
// import 'package:law_diary/common.dart';
// import 'package:law_diary/main.dart';
// import 'login_screen.dart';

// class LogRegister extends StatefulWidget {
//   const LogRegister({super.key});

//   @override
//   State<LogRegister> createState() => _LogRegisterState();
// }

// class _LogRegisterState extends State<LogRegister> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: WillPopScope(
//         onWillPop: () async {
//           SystemNavigator.pop();
//           return false;
//         },
//         child: Stack(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height / 2.0,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         Color.fromARGB(255, 33, 32, 32),
//                         Color.fromARGB(255, 33, 32, 32),
//                         Color.fromARGB(255, 33, 32, 32),
//                       ],
//                     ),
//                   ),
//                   child: Center(
//                     child: Image.asset(
//                       'images/lawdiary.png',
//                       width: 250,
//                       height: 250,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height / 2,
//                 padding: const EdgeInsets.only(top: 40, bottom: 30),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Justice For All',
//                       style: GoogleFonts.poppins(
//                         fontSize: 23,
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 1,
//                         wordSpacing: 2,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 40),
//                       child: Text(
//                         'Law is a set of rules that are created and are enforceable by governmental institutions.',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.poppins(
//                           fontSize: 17,
//                           color: Colors.black.withOpacity(0.6),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 60,
//                     ),
//                     // Padding(
//                     //   padding: const EdgeInsets.symmetric(
//                     //     horizontal: 30,
//                     //   ),
//                     //   child: Container(
//                     //     height: size.height * 0.8,
//                     //     width: size.width,
//                     //     decoration: BoxDecoration(
//                     //         borderRadius: BorderRadius.circular(15),
//                     //         color: fifthcolor,
//                     //         border: Border.all(color: maincolor),
//                     //         boxShadow: [
//                     //           BoxShadow(
//                     //             color: seccolor,
//                     //             spreadRadius: 1,
//                     //             blurRadius: 7,
//                     //             offset: const Offset(0, -1),
//                     //           )
//                     //         ]),
//                     //     child: Padding(
//                     //       padding: const EdgeInsets.only(right: 5),
//                     //       child: Row(
//                     //         children: [
//                     //           Container(
//                     //             height: size.height * 0.08,
//                     //             width: size.width / 2.6,
//                     //             color: maincolor,
//                     //             decoration: BoxDecoration(
//                     //               borderRadius: BorderRadius.circular(15),
//                     //             ),
//                     //           )
//                     //         ],
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),

//                     Padding(
//                       padding: const EdgeInsets.only(
//                         right: 15,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 minimumSize: const Size(150, 50),
//                                 shape: const StadiumBorder(),
//                                 backgroundColor: Colors.grey[200],
//                               ),
//                               child: const Text(
//                                 'Register',
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 15),
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           const RegisterScreen(),
//                                     ),
//                                   );
//                                 });
//                               },
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   minimumSize: const Size(150, 50),
//                                   shape: const StadiumBorder(),
//                                   backgroundColor: Colors.white),
//                               child: const Text(
//                                 'Sign In',
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 15),
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => const LoginScreen(),
//                                     ),
//                                   );
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
