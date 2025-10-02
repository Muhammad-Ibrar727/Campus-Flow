import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchStudentController extends GetxController {
  var isLoading = false.obs;
  var searchResult = <Map<String, dynamic>>[].obs;

  Future<void> searchStudent(String rollNumber) async {
    isLoading.value = true;
    searchResult.clear();

    try {
      final departments = await FirebaseFirestore.instance
          .collection('GPGC')
          .get();

      for (var dept in departments.docs) {
        debugPrint(dept.id); // Debugging line to check department IDs
        final studentsSnap = await FirebaseFirestore.instance
            .collection('GPGC')
            .doc(dept.id)
            .collection('students')
            .where('roll_number', isEqualTo: rollNumber)
            .get();

        for (var student in studentsSnap.docs) {
          searchResult.add({"department": dept.id, ...student.data()});
        }
      }

      if (searchResult.isEmpty) {
        Get.snackbar("Not Found", "No student found with roll $rollNumber");
      }
    } catch (e) {
      Get.snackbar("Error", "Search failed: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
