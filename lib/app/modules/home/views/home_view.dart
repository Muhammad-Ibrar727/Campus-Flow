import 'package:campus_flow/app/data/providers/old_upload.dart';
import 'package:campus_flow/app/data/providers/student_data_uploader.dart';
import 'package:campus_flow/app/data/providers/upload_data.dart';
import 'package:campus_flow/app/modules/home/controllers/home_controller.dart';
import 'package:campus_flow/app/modules/student/views/students_of_department.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/views/login_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Text("Campus Flow", style: TextStyle(color: Colors.white)),
            SizedBox(width: 10),
            Icon(Icons.school_rounded, color: Colors.white, size: 30),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(UploadStudentsView());
            },
            icon: Icon(Icons.upload),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authController.logout();
              Get.offAll(() => LoginScreen());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // // 🔹 Header
            // const Text(
            //   "Welcome, Chief Proctor 👋",
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 8),
            // const Text(
            //   "Manage Departments & Students",
            //   style: TextStyle(fontSize: 14, color: Colors.grey),
            // ),
            // const SizedBox(height: 20),

            // 🔹 Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search by Roll Number or Department...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (query) {
                controller.searchQuery.value = query;
              },
            ),
            const SizedBox(height: 20),

            // 🔹 Departments Grid
            Expanded(
              child: Obx(() {
                final departments = controller.filteredDepartments;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 per row
                    childAspectRatio: 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: departments.length,
                  itemBuilder: (context, index) {
                    final dept = departments[index];
                    return GestureDetector(
                      onTap: () {
                        // 🔹 Navigate to department detail
                        Get.to(
                          StudentsOfDepartment(department_name: dept.name),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        surfaceTintColor: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(dept.icon, size: 40, color: dept.color),
                            const SizedBox(height: 8),
                            Text(
                              dept.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
