import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController authController = Get.find();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String selectedRole = "Teacher";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔹 Title
                  Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Fill in your details to sign up",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 30),

                  // 🔹 Name Field
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Full Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // 🔹 Email Field
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // 🔹 Password Field
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // 🔹 Role Dropdown
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: DropdownButton<String>(
                      value: selectedRole,
                      isExpanded: true,
                      underline: SizedBox(),
                      onChanged: (val) {
                        setState(() {
                          selectedRole = val!;
                        });
                      },
                      items: ["Admin", "Teacher"].map((role) {
                        return DropdownMenuItem(
                          value: role,
                          child: Row(
                            children: [
                              Icon(
                                role == "Admin"
                                    ? Icons.admin_panel_settings
                                    : Icons.school,
                                color: Colors.blue[700],
                              ),
                              const SizedBox(width: 8),
                              Text(role),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // 🔹 Signup Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.blue[800],
                      ),
                      onPressed: () async {
                        await authController.signup(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          nameController.text.trim(),
                          selectedRole,
                        );
                        // Clear all fields
                        nameController.clear();
                        emailController.clear();
                        passwordController.clear();
                        setState(() {
                          selectedRole = "Teacher";
                        });
                        // Show snackbar
                        Get.snackbar(
                          "Success",
                          "Your account has been created!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green[400],
                          colorText: Colors.white,
                        );
                        // Move to sign in screen
                        Future.delayed(Duration(milliseconds: 500), () {
                          Get.offAllNamed('/login');
                        });
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // 🔹 Back to Login
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      "Already have an account? Login",
                      style: TextStyle(color: Colors.blue[700]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
