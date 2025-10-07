import 'package:campus_flow/app/modules/auth/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final AuthController authController = Get.find();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final selectedRole = "Teacher".obs;
  final obscurePassword = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🔹 Header Section
                Column(
                  children: [
                    Icon(
                      Icons.school_rounded,
                      size: 120,
                      color: Colors.blue[700],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Join Campus Flow",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Create your account to get started",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // 🔹 Signup Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 18,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200]!,
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    border: Border.all(color: Colors.grey[100]!),
                  ),
                  child: Column(
                    children: [
                      // Name Field
                      _buildTextField(
                        controller: nameController,
                        icon: Icons.person_outline_rounded,
                        hintText: "Full Name",
                      ),

                      const SizedBox(height: 16),

                      // Email Field
                      _buildTextField(
                        controller: emailController,
                        icon: Icons.email_outlined,
                        hintText: "Email Address",
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 16),

                      // Password Field
                      _buildPasswordField(),

                      const SizedBox(height: 16),

                      // Role Selection
                      _buildRoleSelector(),

                      const SizedBox(height: 24),

                      // Sign Up Button
                      _buildSignupButton(),

                      const SizedBox(height: 20),

                      // Divider
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey[300])),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              "OR",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey[300])),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Login Redirect
                      _buildLoginRedirect(),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 🔹 Features Section
                Column(
                  children: [
                    Text(
                      "Get access to powerful features",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildFeatureChip(
                          "Student Management",
                          Icons.people_alt_rounded,
                        ),

                        _buildFeatureChip(
                          "Admin Tools",
                          Icons.admin_panel_settings_rounded,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: TextField(
          controller: passwordController,
          obscureText: obscurePassword.value,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            prefixIcon: Icon(
              Icons.lock_outline_rounded,
              color: Colors.grey[600],
            ),
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.grey[500]),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.grey[600],
              ),
              onPressed: () {
                obscurePassword.toggle();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleSelector() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedRole.value,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down_rounded, color: Colors.grey[600]),
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            onChanged: (val) {
              selectedRole.value = val!;
            },
            items: ["Teacher", "Admin"].map((role) {
              return DropdownMenuItem(
                value: role,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          role == "Admin"
                              ? Icons.admin_panel_settings_outlined
                              : Icons.school_outlined,
                          color: Colors.blue[700],
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        role,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupButton() {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadowColor: Colors.blue[700]!.withOpacity(0.3),
          ),
          onPressed: authController.isLoading.value ? null : _handleSignup,
          child: authController.isLoading.value
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios_rounded, size: 20),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildLoginRedirect() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyle(color: Colors.grey[600]),
          ),
          GestureDetector(
            onTap: authController.isLoading.value ? null : () => Get.back(),
            child: Text(
              "Sign In",
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.blue[700]),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: Colors.blue[700],
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignup() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
        isDismissible: true,
      );
      return;
    }

    try {
      await authController.signup(
        emailController.text.trim(),
        passwordController.text.trim(),
        nameController.text.trim(),
        selectedRole.value,
      );

      // 🎯 UPDATED SUCCESS MESSAGE
      Get.snackbar(
        "Success!",
        "Account created! Please wait for admin approval before logging in.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[400],
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
        isDismissible: true,
      );

      // Clear form
      nameController.clear();
      emailController.clear();
      passwordController.clear();

      Get.offAll(() => LoginScreen()); // This replaces the current fix
    } catch (e) {
      // Error handling remains the same...
      if (authController.errorMessage.value.isNotEmpty) {
        Get.snackbar(
          "Signup Failed",
          authController.errorMessage.value,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[400],
          colorText: Colors.white,
          borderRadius: 12,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 4),
          isDismissible: true,
        );
      } else {
        Get.snackbar(
          "Signup Failed",
          "An unexpected error occurred",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[400],
          colorText: Colors.white,
          borderRadius: 12,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
          isDismissible: true,
        );
      }
      debugPrint('Signup error: $e');
    }
  }
}
