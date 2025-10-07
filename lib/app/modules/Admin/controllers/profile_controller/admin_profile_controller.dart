// controllers/profile_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var userName = ''.obs;
  var userEmail = ''.obs;
  var userRole = ''.obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    FetchUserData();
    // TODO: implement onInit
    super.onInit();
  }

  void FetchUserData() async {
    try {
      isLoading(true);
      errorMessage('');

      final currentUser = _auth.currentUser;

      if (currentUser == null) {
        throw Exception('No user Logged in');
      }

      final userDoc = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();
      if (userDoc.exists) {
        final data = userDoc.data()!;

        userName.value = data['name'] ?? 'No Name';
        userEmail.value = data['email'] ?? 'No Email';
        userRole.value = data['role'] ?? 'user';
      } else {
        throw Exception('User data not found in Database');
      }
    } catch (e) {
      errorMessage(e.toString());
      Get.snackbar(
        'Error',
        'Failed to load user data',
        colorText: Colors.white,
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[400],
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoading(false);
    }
  }

  void logout() async {
    try {
      await _auth.signOut();
      Get.offAllNamed('/login');
      Get.snackbar(
        'Success',
        'Logged out successfully',
        backgroundColor: Colors.blue[300],
        colorText: Colors.white,
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Logout failed: $e',
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[400],
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
    }
  }
}
