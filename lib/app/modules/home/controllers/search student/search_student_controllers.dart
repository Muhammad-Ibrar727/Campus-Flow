import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchStudentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;
  var searchQuery = ''.obs;
  var selectedDepartment = 'All'.obs;
  var studentsList = <Student>[].obs;

  // Predefined departments list
  final List<String> departmentsList = [
    'All',
    'Pakistan Studies',
    'Computer Science',
    'Statistics',
    'Islamic Studies',
    'English',
    'Economics',
    'Political Science',
    'Zoology',
    'Botany',
    'Pashto',
    'Urdu',
    'Mathematics',
    'Chemistry',
    'AI',
    'Physics',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchAllStudents();
  }

  // Fetch all students from the students collection
  Future<void> fetchAllStudents() async {
    try {
      isLoading.value = true;
      final querySnapshot = await _firestore.collection('students').get();

      studentsList.value = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Student(
          id: doc.id,
          name: data['name'] ?? '',
          rollNumber: data['roll_number'] ?? '',
          department: data['department'] ?? '',
          semester: data['semester'] ?? '',
          session: data['session'] ?? '',
        );
      }).toList();

      debugPrint('Fetched ${studentsList.length} students');
    } catch (e) {
      debugPrint('Error fetching students: $e');
      Get.snackbar(
        'Error',
        'Failed to fetch students: $e',
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

  // Get filtered students based on search and department
  List<Student> get filteredStudents {
    if (searchQuery.isEmpty && selectedDepartment.value == 'All') {
      return studentsList;
    }

    return studentsList.where((student) {
      final matchesSearch =
          searchQuery.isEmpty ||
          student.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          student.rollNumber.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesDepartment =
          selectedDepartment.value == 'All' ||
          student.department.toLowerCase() ==
              selectedDepartment.value.toLowerCase();

      return matchesSearch && matchesDepartment;
    }).toList();
  }

  // Update search query
  void onSearchChanged(String query) {
    searchQuery.value = query;
  }

  // Update selected department
  void onDepartmentChanged(String? department) {
    if (department != null) {
      selectedDepartment.value = department;
    }
  }

  // Extract department from document ID (department_rollnumber format)
  String extractDepartmentFromId(String docId) {
    final parts = docId.split('_');
    if (parts.length > 1) {
      return parts[0]; // Return the department part
    }
    return 'Unknown';
  }
}

class Student {
  final String id;
  final String name;
  final String rollNumber;
  final String department;
  final String semester;
  final String session;

  Student({
    required this.id,
    required this.name,
    required this.rollNumber,
    required this.department,
    required this.semester,
    required this.session,
  });

  // Factory method to create Student from Firestore document
  factory Student.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Student(
      id: doc.id,
      name: data['name'] ?? '',
      rollNumber: data['roll_number'] ?? '',
      department: data['department'] ?? '',
      semester: data['semester'] ?? '',
      session: data['session'] ?? '',
    );
  }
}
