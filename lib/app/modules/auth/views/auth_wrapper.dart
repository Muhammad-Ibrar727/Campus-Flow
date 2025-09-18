// import 'package:campus_flow/app/modules/Admin/view/admin_panel.dart';
// import 'package:campus_flow/app/modules/auth/views/login_screen.dart';
// import 'package:campus_flow/app/modules/auth/views/welcome_screen.dart';
// import 'package:campus_flow/app/modules/home/views/home_view.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/auth_controller.dart';

// class AuthWrapper extends StatefulWidget {
//   const AuthWrapper({super.key});

//   @override
//   _AuthWrapperState createState() => _AuthWrapperState();
// }

// class _AuthWrapperState extends State<AuthWrapper> {
//   final AuthController authController = Get.put(AuthController());
//   bool showWelcome = true;

//   @override
//   void initState() {
//     super.initState();
//     // Show welcome for 2 seconds, then proceed
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       Future.delayed(Duration(seconds: 2), () {
//         setState(() {
//           showWelcome = false;
//         });
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (showWelcome) {
//       return WelcomeScreen();
//     }
//     return Obx(() {
//       if (authController.firebaseUser.value == null) {
//         return LoginScreen();
//       } else {
//         if (authController.role.value == "admin") {
//           return AdminDashboard();
//         } else {
//           return HomeView();
//         }
//       }
//     });
//   }
// }
