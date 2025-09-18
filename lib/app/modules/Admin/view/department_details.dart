import 'package:campus_flow/app/modules/student/controllers/students_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class DepartmentDetails extends StatelessWidget {
  final String department;
  final StudentsController controller = Get.put(StudentsController());

  DepartmentDetails({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    controller.initialize(department);

    return Scaffold(
      appBar: AppBar(title: Text('$department Students')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.filteredStudents.length,
          itemBuilder: (context, index) {
            final student = controller.filteredStudents[index];
            return ListTile(
              title: Text(student.name),
              subtitle: Text('Roll: ${student.rollNumber}'),
            );
          },
        );
      }),
    );
  }
}
