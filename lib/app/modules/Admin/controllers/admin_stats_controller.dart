import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminStatsController extends GetxController {
  var totalStudents = 0.obs;
  var totalAdmins = 0.obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllData();
  }

  Future<void> loadAllData() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Run sequentially to avoid race conditions
      await fetchTotalStudents();
      await fetchTotalAdmins();
    } catch (e) {
      errorMessage.value = "Failed to load data: $e";
      debugPrint("❌ Error loading data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTotalStudents() async {
    try {
      QuerySnapshot studentsSnapshot = await FirebaseFirestore.instance
          .collection('students')
          .get();

      totalStudents.value = studentsSnapshot.docs.length;
      debugPrint("✅ Total students: ${totalStudents.value}");
    } catch (e) {
      debugPrint("❌ Error fetching total students: $e");
      rethrow; // Re-throw to handle in loadAllData
    }
  }

  Future<void> fetchTotalAdmins() async {
    try {
      QuerySnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .get();

      int admins = 0;
      for (var admin in adminSnapshot.docs) {
        var adminData = admin.data() as Map<String, dynamic>;

        // Check both case variations
        if (adminData['role'] == 'Admin' || adminData['role'] == 'admin') {
          admins++;
        }
      }

      totalAdmins.value = admins;
      debugPrint("✅ Total admins: ${totalAdmins.value}");
    } catch (e) {
      debugPrint("❌ Error fetching total admins: $e");
      rethrow; // Re-throw to handle in loadAllData
    }
  }

  // Alternative more efficient method using query
  Future<void> fetchTotalAdminsOptimized() async {
    try {
      QuerySnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Admin')
          .get();

      totalAdmins.value = adminSnapshot.docs.length;
      debugPrint("✅ Total admins: ${totalAdmins.value}");
    } catch (e) {
      debugPrint("❌ Error fetching total admins: $e");
      rethrow;
    }
  }
}
