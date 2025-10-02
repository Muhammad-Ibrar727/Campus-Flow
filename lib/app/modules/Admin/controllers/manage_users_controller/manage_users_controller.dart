// lib/controllers/manage_users_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserModel {
  final String id;
  final String email;
  final String role;
  final bool isApproved;

  UserModel({
    required this.id,
    required this.email,
    required this.role,
    required this.isApproved,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      isApproved: data['isApproved'] ?? false,
    );
  }

  // Add this getter to check if user is protected
  bool get isProtected => email.toLowerCase() == 'chiefproctor@gmail.com';
}

class ManageUsersController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  var teachers = <UserModel>[].obs;
  var admins = <UserModel>[].obs;
  var isLoading = false.obs;

  // New observable variables for search and filter
  var searchQuery = ''.obs;
  var selectedFilter = 'All Users'.obs; // 'All Users', 'Approved', 'Pending'

  // Get filtered and searched users
  List<UserModel> get filteredUsers {
    List<UserModel> allUsers = [...teachers, ...admins];

    // Apply filter
    List<UserModel> filtered = allUsers;
    if (selectedFilter.value == 'Approved') {
      filtered = allUsers.where((user) => user.isApproved).toList();
    } else if (selectedFilter.value == 'Pending') {
      filtered = allUsers.where((user) => !user.isApproved).toList();
    }

    // Apply search
    if (searchQuery.value.isNotEmpty) {
      filtered = filtered
          .where(
            (user) =>
                user.email.toLowerCase().contains(
                  searchQuery.value.toLowerCase(),
                ) ||
                user.role.toLowerCase().contains(
                  searchQuery.value.toLowerCase(),
                ),
          )
          .toList();
    }

    return filtered;
  }

  // Get filtered counts for stats
  int get filteredTotalUsers => filteredUsers.length;
  int get filteredApprovedCount =>
      filteredUsers.where((u) => u.isApproved).length;
  int get filteredPendingCount =>
      filteredUsers.where((u) => !u.isApproved).length;

  // Original counts (all users)
  int get totalUsers => teachers.length + admins.length;
  int get approvedCount =>
      teachers.where((u) => u.isApproved).length +
      admins.where((u) => u.isApproved).length;
  int get pendingCount =>
      teachers.where((u) => !u.isApproved).length +
      admins.where((u) => !u.isApproved).length;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      final usersSnap = await _db.collection('users').get();
      final users = usersSnap.docs
          .map((doc) => UserModel.fromMap(doc.data(), doc.id))
          .toList();
      teachers.value = users.where((u) => u.role == 'Teacher').toList();
      admins.value = users.where((u) => u.role == 'Admin').toList();
    } catch (e) {
      debugPrint('Error fetching users: $e');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Search methods
  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void clearSearch() {
    searchQuery.value = '';
  }

  // Filter methods
  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  Future<void> approveUser(String id) async {
    try {
      await _db.collection('users').doc(id).update({'isApproved': true});
      _updateUserApprovalStatus(id, true);
    } catch (e) {
      debugPrint('Error approving user: $e');
      rethrow;
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      // Check if user is protected before deleting
      final allUsers = [...teachers, ...admins];
      final user = allUsers.firstWhere((u) => u.id == id);

      if (user.isProtected) {
        throw Exception('Cannot delete protected user: ${user.email}');
      }

      await _db.collection('users').doc(id).delete();
      _removeUserFromLists(id);
    } catch (e) {
      debugPrint('Error deleting user: $e');
      rethrow;
    }
  }

  // Helper method to check if user can be deleted (for UI)
  bool canDeleteUser(String id) {
    try {
      final allUsers = [...teachers, ...admins];
      final user = allUsers.firstWhere((u) => u.id == id);
      return !user.isProtected;
    } catch (e) {
      return true; // If user not found, allow delete attempt
    }
  }

  Future<void> addUser(String email, String password, String role) async {
    try {
      await _db.collection('users').add({
        'email': email,
        'role': role,
        'isApproved': false,
        'password': password,
      });
      fetchUsers();
    } catch (e) {
      debugPrint('Error adding user: $e');
      rethrow;
    }
  }

  // Helper methods for immediate UI updates
  void _updateUserApprovalStatus(String id, bool isApproved) {
    final teacherIndex = teachers.indexWhere((user) => user.id == id);
    if (teacherIndex != -1) {
      final updatedUser = UserModel(
        id: teachers[teacherIndex].id,
        email: teachers[teacherIndex].email,
        role: teachers[teacherIndex].role,
        isApproved: isApproved,
      );
      teachers[teacherIndex] = updatedUser;
      teachers.refresh();
    }

    final adminIndex = admins.indexWhere((user) => user.id == id);
    if (adminIndex != -1) {
      final updatedUser = UserModel(
        id: admins[adminIndex].id,
        email: admins[adminIndex].email,
        role: admins[adminIndex].role,
        isApproved: isApproved,
      );
      admins[adminIndex] = updatedUser;
      admins.refresh();
    }
  }

  void _removeUserFromLists(String id) {
    teachers.removeWhere((user) => user.id == id);
    admins.removeWhere((user) => user.id == id);
    teachers.refresh();
    admins.refresh();
  }
}
