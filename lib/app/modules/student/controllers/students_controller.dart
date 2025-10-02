import 'package:campus_flow/app/data/models/student_model.dart'
    show StudentModel;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observables
  var isLoading = true.obs;
  var students = <StudentModel>[].obs;
  var filteredStudents = <StudentModel>[].obs;
  var selectedSemester = 'All'.obs;
  var searchQuery = ''.obs;

  // Available semesters - now matching the Firestore string values
  final semesters = ['All', '1st', '3rd', '5th', '7th'];

  // Department name
  late String departmentName;

  @override
  void onInit() {
    super.onInit();
    ever(searchQuery, (_) => filterStudents());
  }

  // Initialize with department name
  void initialize(String department) {
    departmentName = department;
    fetchStudents();
  }

  // Fetch students from Firebase
  Future<void> fetchStudents() async {
    try {
      isLoading.value = true;
      students.clear();

      // Get reference to the students subcollection
      final studentsRef = _firestore
          .collection('GPGC')
          .doc(departmentName)
          .collection('students');

      QuerySnapshot querySnapshot;

      if (selectedSemester.value == 'All') {
        // Get all students in this department
        querySnapshot = await studentsRef.get();
      } else {
        // Filter by semester (as string) within this department
        querySnapshot = await studentsRef
            .where('semester', isEqualTo: selectedSemester.value)
            .get();
      }

      students.value = querySnapshot.docs.map((doc) {
        return StudentModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      // Sort students by roll number
      students.sort((a, b) => a.rollNumber.compareTo(b.rollNumber));
      filterStudents();
    } catch (e) {
      debugPrint('Error fetching students: $e');
      Get.snackbar(
        'Error',
        'Failed to load students',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Filter students based on search query
  void filterStudents() {
    if (searchQuery.isEmpty) {
      filteredStudents.value = List<StudentModel>.from(students);
      return;
    }

    filteredStudents.value = students.where((student) {
      final String rollNumber = student.rollNumber.toLowerCase();
      final String name = student.name.toLowerCase();
      return rollNumber.contains(searchQuery.value.toLowerCase()) ||
          name.contains(searchQuery.value.toLowerCase());
    }).toList();
  }

  // Change semester filter
  void changeSemester(String semester) {
    selectedSemester.value = semester;
    searchQuery.value = '';
    fetchStudents();
  }

  // Update search query
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Get avatar color based on name
  Color getAvatarColor(String name) {
    final colors = [
      Colors.blue[500]!,
      Colors.red[500]!,
      Colors.green[500]!,
      Colors.purple[500]!,
      Colors.orange[500]!,
      Colors.teal[500]!,
    ];
    return colors[name.length % colors.length];
  }

  String getSemesterDisplay(String semester) {
    return semester;
  }
}
