import 'package:campus_flow/app/modules/home/controllers/search_student_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchStudentView extends StatelessWidget {
  SearchStudentView({super.key});

  final SearchStudentController controller = Get.put(SearchStudentController());
  final TextEditingController rollController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Student"),
        backgroundColor: Colors.blueGrey[50],
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: rollController,
              decoration: InputDecoration(
                labelText: "Enter Roll Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.blue),
                  onPressed: () {
                    if (rollController.text.isNotEmpty) {
                      controller.searchStudent(rollController.text.trim());
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.searchResult.isEmpty) {
                  return const Center(child: Text("No student found"));
                }
                return ListView.builder(
                  itemCount: controller.searchResult.length,
                  itemBuilder: (context, index) {
                    final student = controller.searchResult[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.person, color: Colors.blue),
                        title: Text(student["name"] ?? "Unknown"),
                        subtitle: Text(
                          "Roll: ${student["roll_number"]} | "
                          "Session: ${student["session"]} | "
                          "Semester: ${student["semester"]} | "
                          "Dept: ${student["department"]}",
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
