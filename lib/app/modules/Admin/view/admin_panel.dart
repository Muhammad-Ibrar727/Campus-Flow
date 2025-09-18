import 'package:campus_flow/app/modules/Admin/controllers/admin_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatelessWidget {
  // Changed to StatelessWidget
  AdminDashboard({super.key});

  final AdminController _adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _adminController.fetchDepartments();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDepartmentDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (_adminController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_adminController.departments.isEmpty) {
          return const Center(
            child: Text('No departments found', style: TextStyle(fontSize: 18)),
          );
        }

        return ListView.builder(
          itemCount: _adminController.departments.length,
          itemBuilder: (context, index) {
            final department = _adminController.departments[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                title: Text(
                  department['name'] ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Students: ${department['totalStudents'] ?? 0}',
                  style: const TextStyle(fontSize: 14),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteConfirmationDialog(
                      context,
                      department['id'],
                    ); // Changed to use ID instead of name
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showAddDepartmentDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Department'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Enter department name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.trim().isNotEmpty) {
                  Navigator.of(context).pop();
                  final success = await _adminController.addDepartment(
                    nameController.text.trim(),
                  );
                  if (success) {
                    Get.snackbar(
                      'Success',
                      'Department added successfully',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  } else {
                    Get.snackbar(
                      'Error',
                      'Failed to add department',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context,
    String departmentId, // Changed parameter name to reflect it's now an ID
  ) {
    // Get the department name for display purposes
    final department = _adminController.departments.firstWhere(
      (dept) => dept['id'] == departmentId,
      orElse: () => {'name': 'Unknown Department'},
    );

    final departmentName = department['name'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete $departmentName?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final success = await _adminController.deleteDepartment(
                  departmentId, // Pass ID instead of name
                );
                if (success) {
                  Get.snackbar(
                    'Success',
                    'Department deleted successfully',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
