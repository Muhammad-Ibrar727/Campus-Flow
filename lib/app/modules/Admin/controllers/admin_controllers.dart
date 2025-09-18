import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;
  var departments = <Map<String, dynamic>>[].obs;
  var allStudents = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDepartments();
    fetchAllStudents();
  }

  // Fixed fetchDepartments method
  Future<void> fetchDepartments() async {
    try {
      isLoading.value = true;
      print('Fetching departments from Firestore...');

      final snapshot = await _firestore.collection('departments').get();
      print('Found ${snapshot.docs.length} departments');

      // Check if documents have a 'name' field, otherwise use document ID
      departments.value = snapshot.docs.map((doc) {
        final data = doc.data();
        print('Department: ${doc.id}, Data: $data');

        return {
          'id': doc.id,
          'name':
              data['name'] ??
              doc.id, // Use 'name' field if exists, otherwise use doc ID
          ...data,
        };
      }).toList();

      print('Departments list: ${departments.value}');
    } catch (e) {
      print('Error fetching departments: $e');
      Get.snackbar('Error', 'Failed to fetch departments: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Improved addDepartment method
  Future<bool> addDepartment(String departmentName) async {
    try {
      // Check if department already exists
      final existingDept = await _firestore
          .collection('departments')
          .where('name', isEqualTo: departmentName)
          .get();

      if (existingDept.docs.isNotEmpty) {
        Get.snackbar('Error', 'Department already exists');
        return false;
      }

      // Create a document with a custom ID or let Firestore generate one
      await _firestore.collection('departments').add({
        'name': departmentName,
        'createdAt': FieldValue.serverTimestamp(),
        'totalStudents': 0,
      });

      fetchDepartments();
      Get.snackbar('Success', 'Department added successfully');
      return true;
    } catch (e) {
      print('Error adding department: $e');
      Get.snackbar('Error', 'Failed to add department: $e');
      return false;
    }
  }

  // Delete department - improved
  Future<bool> deleteDepartment(String departmentId) async {
    try {
      // First check if department has students
      final studentsSnapshot = await _firestore
          .collection('departments')
          .doc(departmentId)
          .collection('students')
          .get();

      if (studentsSnapshot.docs.isNotEmpty) {
        Get.snackbar('Error', 'Cannot delete department with students');
        return false;
      }

      await _firestore.collection('departments').doc(departmentId).delete();
      fetchDepartments();
      Get.snackbar('Success', 'Department deleted successfully');
      return true;
    } catch (e) {
      print('Error deleting department: $e');
      Get.snackbar('Error', 'Failed to delete department: $e');
      return false;
    }
  }

  // Fetch all students across all departments - optimized
  Future<void> fetchAllStudents() async {
    try {
      isLoading.value = true;

      // Use a more efficient approach with collectionGroup query
      // if you have the same subcollection name across departments
      final studentsSnapshot = await _firestore
          .collectionGroup('students')
          .get();

      List<Map<String, dynamic>> studentsList = [];

      for (var studentDoc in studentsSnapshot.docs) {
        // Extract department ID from the document path
        final pathParts = studentDoc.reference.path.split('/');
        final departmentId =
            pathParts[1]; // path format: departments/{deptId}/students/{studentId}

        studentsList.add({
          'id': studentDoc.id,
          'department': departmentId,
          ...studentDoc.data(),
        });
      }

      allStudents.value = studentsList;
    } catch (e) {
      print('Error fetching all students: $e');
      Get.snackbar('Error', 'Failed to fetch students: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Add student to specific department
  Future<bool> addStudent(
    String departmentId,
    Map<String, dynamic> studentData,
  ) async {
    try {
      // Add to department's students subcollection
      await _firestore
          .collection('departments')
          .doc(departmentId)
          .collection('students')
          .add(studentData);

      // Update student count in department
      await _firestore.collection('departments').doc(departmentId).update({
        'totalStudents': FieldValue.increment(1),
      });

      fetchAllStudents();
      Get.snackbar('Success', 'Student added successfully');
      return true;
    } catch (e) {
      print('Error adding student: $e');
      Get.snackbar('Error', 'Failed to add student: $e');
      return false;
    }
  }

  // Delete student
  Future<bool> deleteStudent(String departmentId, String studentId) async {
    try {
      await _firestore
          .collection('departments')
          .doc(departmentId)
          .collection('students')
          .doc(studentId)
          .delete();

      // Update student count
      await _firestore.collection('departments').doc(departmentId).update({
        'totalStudents': FieldValue.increment(-1),
      });

      fetchAllStudents();
      Get.snackbar('Success', 'Student deleted successfully');
      return true;
    } catch (e) {
      print('Error deleting student: $e');
      Get.snackbar('Error', 'Failed to delete student: $e');
      return false;
    }
  }
}
