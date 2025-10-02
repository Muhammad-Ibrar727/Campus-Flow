import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' show Data, Excel;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentUploadController extends GetxController {
  // Reactive variables
  var isLoading = false.obs;
  var showPreview = false.obs;
  var excelData = <Map<String, String>>[].obs;
  String? departmentName;

  // Initialize controller with department name
  void initialize(String department) {
    departmentName = department;
  }

  /// Pick Excel file and process data
  Future<void> pickExcelFile() async {
    try {
      isLoading.value = true;

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
        dialogTitle: 'Select Student Excel File',
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        var bytes = file.readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);

        List<Map<String, String>> previewData = [];

        for (var table in excel.tables.keys) {
          final sheet = excel.tables[table];
          if (sheet == null) continue;

          // Skip header row (row 0)
          for (var row in sheet.rows.skip(1)) {
            try {
              if (row.isEmpty) continue;

              String rollNo = _getCellValue(row[1]);
              String name = _getCellValue(row[2]);
              String semester = _getCellValue(row[3]);
              String batchVal = _getCellValue(row[4]);
              String department = _getCellValue(row[5]);

              previewData.add({
                'rollNo': rollNo,
                'name': name,
                'semester': semester,
                'batch': batchVal,
                'department': department,
                'status': (rollNo.isNotEmpty && name.isNotEmpty)
                    ? '✅ Ready'
                    : '❌ Incomplete',
              });
            } catch (e) {
              previewData.add({
                'rollNo': 'Error',
                'name': 'Error processing row',
                'semester': '',
                'batch': '',
                'department': '',
                'status': '❌ Incomplete',
              });
            }
          }
        }

        excelData.value = previewData;
        showPreview.value = true;
        isLoading.value = false;

        Get.snackbar(
          "Preview Ready",
          "Review the data before uploading",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Failed to process file: ${e.toString()}",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[400],
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  Future<void> uploadToFirebase() async {
    try {
      isLoading.value = true;

      int addedCount = 0;
      int errorCount = 0;
      int duplicateCount = 0;

      final batch = FirebaseFirestore.instance.batch();
      final studentsRef = FirebaseFirestore.instance.collection('students');

      // First, check for existing students to avoid duplicates
      final existingStudents = await studentsRef.get();
      final existingStudentIds = existingStudents.docs
          .map((doc) => doc.id)
          .toSet();

      for (var studentData in excelData) {
        try {
          String rollNo = studentData['rollNo'] ?? "";
          String name = studentData['name'] ?? "";
          String semester = studentData['semester'] ?? "";
          String batchVal = studentData['batch'] ?? "";
          String department = studentData['department'] ?? "";

          // Only upload valid records with department
          if (rollNo.isNotEmpty &&
              name.isNotEmpty &&
              department.isNotEmpty &&
              studentData['status'] == '✅ Ready') {
            // Use the department from Excel data
            String finalDepartment = department;

            // Create the document ID
            String docId = '${finalDepartment}_$rollNo';

            // Check if student already exists
            if (existingStudentIds.contains(docId)) {
              duplicateCount++;
              debugPrint('Student already exists: $docId - $name');
              continue; // Skip this student
            }

            // Get the specific department reference for this student
            final departmentRef = FirebaseFirestore.instance
                .collection('GPGC')
                .doc(
                  finalDepartment,
                ) // Use student's department, not the screen department
                .collection('students');

            // Add to specific department collection
            final departmentDoc = departmentRef.doc(docId);
            batch.set(departmentDoc, {
              "roll_number": rollNo,
              "name": name,
              "semester": semester,
              "session": batchVal,
              "department": finalDepartment,
              "created_at": FieldValue.serverTimestamp(),
            });

            // Add to global students collection
            final studentDoc = studentsRef.doc(docId);
            batch.set(studentDoc, {
              "roll_number": rollNo,
              "name": name,
              "semester": semester,
              "session": batchVal,
              "department": finalDepartment,
              "created_at": FieldValue.serverTimestamp(),
            });

            addedCount++;
          }
        } catch (e) {
          errorCount++;
          debugPrint('Error uploading student: $e');
        }
      }

      if (addedCount > 0) {
        await batch.commit();
        Get.snackbar(
          "Success",
          "$addedCount new students uploaded to their respective departments successfully!"
              "${duplicateCount > 0 ? " ($duplicateCount duplicates skipped)" : ""}"
              "${errorCount > 0 ? " ($errorCount errors)" : ""}",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          snackPosition: SnackPosition.TOP,
          borderRadius: 12,
          margin: const EdgeInsets.all(16),
        );

        // Navigate back after successful upload
        Get.back();
      } else if (duplicateCount > 0) {
        Get.snackbar(
          "No New Data",
          "All students already exist in database. $duplicateCount duplicates found.",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          borderRadius: 12,
          margin: const EdgeInsets.all(16),
        );
      } else {
        Get.snackbar(
          "No Data Uploaded",
          "No valid student records found to upload.",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          borderRadius: 12,
          margin: const EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to upload data: ${e.toString()}",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[400],
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Reset and pick new file
  void pickNewFile() {
    showPreview.value = false;
    excelData.clear();
  }

  /// Get cell value from Excel
  String _getCellValue(Data? cell) {
    if (cell == null || cell.value == null) return "";
    return cell.value.toString().trim();
  }

  /// Get statistics
  int get totalStudents => excelData.length;
  int get validStudents =>
      excelData.where((s) => s['status'] == '✅ Ready').length;
  int get errorStudents =>
      excelData.where((s) => s['status'] == '❌ Incomplete').length;
}
