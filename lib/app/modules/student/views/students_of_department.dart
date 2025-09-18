import 'package:campus_flow/app/modules/student/controllers/students_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentsOfDepartment extends StatelessWidget {
  final String department_name;
  final StudentsController controller = Get.put(StudentsController());

  StudentsOfDepartment({super.key, required this.department_name});

  @override
  Widget build(BuildContext context) {
    controller.initialize(department_name);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          department_name,
          style: TextStyle(fontSize: 19, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 38, 89, 152),
        elevation: 2,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // color: Colors.grey[50],
              color: Colors.white,
              // border: Border(
              //   bottom: BorderSide(color: Colors.grey[200]!, width: 1.0),
              // ),
            ),
            child: TextField(
              onChanged: controller.updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search by roll number...',
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[500],
                  size: 24,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue[400]!, width: 1.5),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 20,
                ),
                constraints: const BoxConstraints(maxHeight: 40),
              ),
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
          // Student Count and Semester Filter
          Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              color: Colors.white,
              child: Row(
                children: [
                  // Student Count
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                      children: [
                        const TextSpan(text: 'Total Students: '),
                        TextSpan(
                          text: '${controller.filteredStudents.length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // // Search indicator (if searching)
                  // if (controller.searchQuery.isNotEmpty)
                  //   Padding(
                  //     padding: const EdgeInsets.only(left: 8.0),
                  //     child: Text(
                  //       '• Searching: "${controller.searchQuery.value}"',
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 14,
                  //         color: Colors.blue[600],
                  //         fontStyle: FontStyle.italic,
                  //       ),
                  //     ),
                  //   ),
                  const Spacer(),

                  // Semester Dropdown
                  Row(
                    children: [
                      const Text(
                        'Semester:',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: controller.selectedSemester.value,
                            isDense: true,
                            items: controller.semesters.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                controller.changeSemester(value!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // // Divider
          // const Divider(height: 1, thickness: 1),
          // Students List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Loading students...',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                );
              }
              if (controller.filteredStudents.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        controller.searchQuery.isEmpty
                            ? Icons.people_outline
                            : Icons.search_off,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        controller.searchQuery.isEmpty
                            ? 'No students found'
                            : 'No students found for "${controller.searchQuery.value}"',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.selectedSemester.value == 'All'
                            ? 'This department has no students yet'
                            : 'No students in Semester ${controller.selectedSemester.value}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = controller.filteredStudents[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      leading: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: controller.getAvatarColor(student.name),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            student.name[0].toUpperCase(), // Use student.name
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        student.name, // Use student.name
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            'Roll No: ${student.rollNumber}', // Use student.rollNumber
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Wrap(
                            spacing: 8,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Sem ${student.semester}', // Use student.semester with helper method
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Batch: ${student.batch}', // Use student.batch (changed from session)
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                      onTap: () {
                        // Navigate to student details page
                        // Get.to(() => StudentDetailsPage(student: student));
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
