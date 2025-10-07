import 'package:campus_flow/app/modules/Admin/view/admin_panel_bottom_navigation.dart';
import 'package:campus_flow/app/modules/home/views/home_view_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () async {
      if (authController.firebaseUser.value != null) {
        String? role = await authController.fetchUserRole();
        if (role == "Admin") {
          Get.offAll(() => AdminPanelBottomNavigation());
        } else if (role == "Teacher") {
          Get.offAll(() => HomeViewBottomNavigation());
        }
      } else {
        Get.offAll(() => LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue.shade300, width: 2),
              ),
              child: Icon(Icons.school, size: 45, color: Colors.blue.shade700),
            ),
           

            SizedBox(height: 30),

            Text(
              "CAMPUS FLOW",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
                letterSpacing: 1.2,
              ),
            ),

            SizedBox(height: 10),


            Text(
              "GPGC Mansehra",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700, 
                color: Colors.grey.shade700,
                letterSpacing: 1.0,
              ),
            ),

            SizedBox(height: 100),

            // Loading indicator
            SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
              ),
            ),

            SizedBox(height: 20),
            Text(
              "Loading...",
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
