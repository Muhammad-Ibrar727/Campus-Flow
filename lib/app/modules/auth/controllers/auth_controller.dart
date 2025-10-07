import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final Rx<User?> firebaseUser = Rx<User?>(null);
  final RxString role = ''.obs;
  final RxBool isApproved = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());

    // When user changes, fetch their role and approval status
    ever(firebaseUser, (User? user) {
      if (user != null) {
        fetchUserRole();
        checkUserApproval();
      } else {
        role.value = '';
        isApproved.value = false;
      }
    });
  }

  Future<void> signup(
    String email,
    String password,
    String name,
    String role,
  ) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // 1. Create Firebase auth account
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // 2. Create user document in Firestore with isApproved: false
      await _db.collection("users").doc(userCred.user!.uid).set({
        "name": name.trim(),
        "email": email.trim(),
        "role": role,
        "isApproved": false, // Always false for new signups
        "createdAt": FieldValue.serverTimestamp(),
      });

      // 3. 🚨 CRITICAL FIX: SIGN OUT IMMEDIATELY AFTER SIGNUP
      await _auth.signOut();

      // 4. Clear local state
      firebaseUser.value = null;
      this.role.value = '';
      isApproved.value = false;
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _getSignupErrorMessage(e);
      rethrow;
    } catch (e) {
      errorMessage.value = "An unexpected error occurred during signup.";
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Check if user exists in Firestore and is approved
      final userData = await fetchUserData();
      if (userData == null) {
        await _auth.signOut();
        errorMessage.value = 'User account not found in system';
        _showErrorSnackbar("Login Failed", errorMessage.value);
        return;
      }

      // Check if user is approved
      final bool approved = userData['isApproved'] ?? false;
      if (!approved) {
        await _auth.signOut();
        errorMessage.value =
            'Your account is pending approval. Please contact administrator.';
        _showErrorSnackbar("Approval Pending", errorMessage.value);
        return;
      }

      // Fetch and update role and approval status
      await fetchUserRole();
      await checkUserApproval();

      // Success
      Get.snackbar(
        "Welcome Back!",
        "Login successful",
        snackPosition: SnackPosition.TOP,

        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _getAuthErrorMessage(e);
      _showErrorSnackbar("Login Failed", errorMessage.value);
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred';
      _showErrorSnackbar("Error", errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> fetchUserRole() async {
    try {
      if (firebaseUser.value == null) return null;

      final userDoc = await _db
          .collection("users")
          .doc(firebaseUser.value!.uid)
          .get();
      if (userDoc.exists) {
        role.value = userDoc["role"] ?? '';
        return userDoc["role"];
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching user role: $e');
      return null;
    }
  }

  Future<bool> checkUserApproval() async {
    try {
      if (firebaseUser.value == null) return false;

      final userDoc = await _db
          .collection("users")
          .doc(firebaseUser.value!.uid)
          .get();
      if (userDoc.exists) {
        isApproved.value = userDoc["isApproved"] ?? false;
        return isApproved.value;
      }
      return false;
    } catch (e) {
      debugPrint('Error checking user approval: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      if (firebaseUser.value == null) return null;

      final userDoc = await _db
          .collection("users")
          .doc(firebaseUser.value!.uid)
          .get();
      if (userDoc.exists) {
        return userDoc.data();
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      return null;
    }
  }

  Future<bool> isUserApproved() async {
    return await checkUserApproval();
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      role.value = '';
      isApproved.value = false;
      errorMessage.value = '';

      Get.snackbar(
        "Logged Out",
        "You have been successfully logged out",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue[300],
        colorText: Colors.white,
        isDismissible: true,
      );
    } catch (e) {}
  }

  // Helper methods for error messages
  String _getAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Invalid password';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many attempts. Try again later';
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'weak-password':
        return 'Password is too weak';
      default:
        return 'Authentication failed. Please try again';
    }
  }

  String _getSignupErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already registered. Please use a different email.';
      case 'weak-password':
        return 'Password is too weak. Please use a stronger password.';
      case 'invalid-email':
        return 'Invalid email address format.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      default:
        return 'Signup failed. Please try again.';
    }
  }

  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      isDismissible: true,
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[400],
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
    );
  }

  // Utility methods
  void clearError() {
    errorMessage.value = '';
  }

  bool get isLoggedIn => firebaseUser.value != null;

  bool get isAdmin => role.value == 'Admin' && isApproved.value;

  bool get isTeacher => role.value == 'Teacher' && isApproved.value;

  // Method to check if user can access specific routes
  bool canAccessRoute(String requiredRole) {
    if (!isLoggedIn) return false;
    if (!isApproved.value) return false;
    return role.value == requiredRole;
  }
}
