import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentModel {
  final String id;
  final String name;
  final String rollNumber;
  final String session;
  final String semester;
  final DateTime? createdAt;

  StudentModel({
    required this.id,
    required this.name,
    required this.rollNumber,
    required this.session,
    required this.semester,
    this.createdAt,
  });

  factory StudentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StudentModel(
      id: doc.id,
      name: data['name'] ?? '',
      rollNumber: data['roll_number'] ?? '',
      session: data['session'] ?? '',
      semester: data['semester'] ?? '',
      createdAt: data['created_at']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'roll_number': rollNumber,
      'session': session,
      'semester': semester,
      'created_at': FieldValue.serverTimestamp(),
    };
  }
}

class DepartmentController extends GetxController {
  final String departmentName;
  var isLoading = false.obs;
  var selectedStudents = <String>[].obs;
  var selectionMode = false.obs;
  var students = <StudentModel>[].obs;

  // For editing
  var isEditing = false.obs;
  var editingStudent = StudentModel(
    id: '',
    name: '',
    rollNumber: '',
    session: '',
    semester: '',
  ).obs;

  DepartmentController(this.departmentName);

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    try {
      isLoading.value = true;
      final snapshot = await FirebaseFirestore.instance
          .collection('GPGC')
          .doc(departmentName)
          .collection('students')
          .get();

      students.value = snapshot.docs
          .map((doc) => StudentModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch students: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Group students by semester
  Map<String, List<StudentModel>> get studentsBySemester {
    final grouped = <String, List<StudentModel>>{};
    for (var student in students) {
      grouped.putIfAbsent(student.semester, () => []).add(student);
    }

    // Sort semesters numerically
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) {
        final aNum = int.tryParse(a.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
        final bNum = int.tryParse(b.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
        return aNum.compareTo(bNum);
      });

    final sortedMap = <String, List<StudentModel>>{};
    for (var key in sortedKeys) {
      sortedMap[key] = grouped[key]!;
    }

    return sortedMap;
  }

  // Selection methods
  void toggleStudentSelection(String studentId) {
    if (selectedStudents.contains(studentId)) {
      selectedStudents.remove(studentId);
    } else {
      selectedStudents.add(studentId);
    }
    selectionMode.value = selectedStudents.isNotEmpty;
  }

  void selectAllInSemester(String semester) {
    final semesterStudents = students
        .where((student) => student.semester == semester)
        .map((student) => student.id)
        .toList();

    final allSelected = semesterStudents.every(selectedStudents.contains);

    if (allSelected) {
      selectedStudents.removeWhere(semesterStudents.contains);
    } else {
      selectedStudents.addAll(
        semesterStudents.where((id) => !selectedStudents.contains(id)),
      );
    }
    selectionMode.value = selectedStudents.isNotEmpty;
  }

  void selectAll() {
    if (selectedStudents.length == students.length) {
      selectedStudents.clear();
    } else {
      selectedStudents.value = students.map((student) => student.id).toList();
    }
    selectionMode.value = selectedStudents.isNotEmpty;
  }

  void clearSelection() {
    selectedStudents.clear();
    selectionMode.value = false;
  }

  Future<void> addStudent({
    required String name,
    required String roll,
    required String session,
    required String semester,
  }) async {
    try {
      isLoading.value = true;

      // Create document ID in the same format as Excel upload
      String docId = '${departmentName}_$roll';

      final batch = FirebaseFirestore.instance.batch();

      // 1. Add to department collection (GPGC/{department}/students)
      final departmentRef = FirebaseFirestore.instance
          .collection('GPGC')
          .doc(departmentName)
          .collection('students')
          .doc(docId); // Use the same docId format

      batch.set(departmentRef, {
        "roll_number": roll,
        "name": name,
        "semester": semester,
        "session": session,
        "department": departmentName,
        "created_at": FieldValue.serverTimestamp(),
      });

      // 2. Add to global students collection with same docId format
      final studentsRef = FirebaseFirestore.instance.collection('students');
      final studentDoc = studentsRef.doc(docId);

      batch.set(studentDoc, {
        "roll_number": roll,
        "name": name,
        "semester": semester,
        "session": session,
        "department": departmentName,
        "created_at": FieldValue.serverTimestamp(),
      });

      await batch.commit();
      await fetchStudents(); // Refresh the list

      Get.snackbar(
        "Success",
        "Student added successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to add student: $e",
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

  Future<void> editStudent({
    required String
    id, // This should be the document ID in format {department}_{roll}
    required String name,
    required String roll,
    required String session,
    required String semester,
  }) async {
    try {
      isLoading.value = true;

      // Create new document ID in case roll number changed
      String newDocId = '${departmentName}_$roll';

      final batch = FirebaseFirestore.instance.batch();

      // If roll number changed, we need to delete old docs and create new ones
      if (id != newDocId) {
        // Delete old documents
        final oldDepartmentRef = FirebaseFirestore.instance
            .collection('GPGC')
            .doc(departmentName)
            .collection('students')
            .doc(id);

        final oldStudentRef = FirebaseFirestore.instance
            .collection('students')
            .doc(id);

        batch.delete(oldDepartmentRef);
        batch.delete(oldStudentRef);
      }

      // Update/Create in department collection
      final departmentRef = FirebaseFirestore.instance
          .collection('GPGC')
          .doc(departmentName)
          .collection('students')
          .doc(newDocId);

      batch.set(departmentRef, {
        "roll_number": roll,
        "name": name,
        "semester": semester,
        "session": session,
        "department": departmentName,
        "created_at": FieldValue.serverTimestamp(),
      });

      // Update/Create in global students collection
      final studentRef = FirebaseFirestore.instance
          .collection('students')
          .doc(newDocId);

      batch.set(studentRef, {
        "roll_number": roll,
        "name": name,
        "semester": semester,
        "session": session,
        "department": departmentName,
        "created_at": FieldValue.serverTimestamp(),
      });

      await batch.commit();
      await fetchStudents(); // Refresh the list
      isEditing.value = false;

      Get.snackbar(
        "Success",
        "Student updated successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update student: $e",
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

  // Set student for editing
  void setEditingStudent(StudentModel student) {
    editingStudent.value = student;
    isEditing.value = true;
  }

  // Cancel editing
  void cancelEditing() {
    isEditing.value = false;
    editingStudent.value = StudentModel(
      id: '',
      name: '',
      rollNumber: '',
      session: '',
      semester: '',
    );
  }

  Future<void> deleteStudent(String studentId) async {
    try {
      final batch = FirebaseFirestore.instance.batch();

      // Delete from department collection
      final departmentRef = FirebaseFirestore.instance
          .collection('GPGC')
          .doc(departmentName)
          .collection('students')
          .doc(studentId);

      // Delete from global students collection
      final globalRef = FirebaseFirestore.instance
          .collection('students')
          .doc(studentId);

      batch.delete(departmentRef);
      batch.delete(globalRef);

      await batch.commit();

      // Remove from local lists
      students.removeWhere((student) => student.id == studentId);

      Get.snackbar(
        "Success",
        "Student deleted successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete student: $e",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[400],
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  // Also update the deleteSelected method to be consistent
  Future<void> deleteSelected() async {
    if (selectedStudents.isEmpty) return;

    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text(
          "Delete ${selectedStudents.length} student(s)? This action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      isLoading.value = true;
      final batch = FirebaseFirestore.instance.batch();

      final departmentRef = FirebaseFirestore.instance
          .collection('GPGC')
          .doc(departmentName)
          .collection('students');

      final globalRef = FirebaseFirestore.instance.collection('students');

      for (String id in selectedStudents) {
        batch.delete(departmentRef.doc(id));
        batch.delete(globalRef.doc(id));
      }

      await batch.commit();
      await fetchStudents(); // Refresh the list
      clearSelection();

      Get.snackbar(
        "Success",
        "${selectedStudents.length} student(s) deleted successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete students: $e",
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
}
