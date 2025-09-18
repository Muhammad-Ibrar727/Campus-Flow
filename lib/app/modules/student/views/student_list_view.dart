// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/student_controller.dart';
// import '../../../data/models/student_model.dart';

// class StudentListView extends StatelessWidget {
//   const StudentListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(StudentController());
//     final String department = Get.arguments ?? "";

//     return Scaffold(
//       appBar: AppBar(title: Text("$department Students")),
//       body: Obx(() {
//         // Filter students by department
//         final deptStudents = controller.students
//             .where((s) => s.department == department)
//             .toList();
//         if (deptStudents.isEmpty) {
//           return const Center(child: Text("No students found"));
//         }
//         // Group students by semester
//         final Map<int, List<StudentModel>> semesterMap = {};
//         for (var s in deptStudents) {
//           semesterMap.putIfAbsent(s.semester, () => []).add(s);
//         }
//         final semesters = semesterMap.keys.toList()..sort();
//         return ListView.builder(
//           itemCount: semesters.length,
//           itemBuilder: (context, semIndex) {
//             final sem = semesters[semIndex];
//             final students = semesterMap[sem]!;
//             return ExpansionTile(
//               title: Text("Semester $sem"),
//               children: students.map((student) {
//                 return ListTile(
//                   title: Text(student.name),
//                   subtitle: Text(
//                     "Roll: ${student.rollNumber} | Session: ${student.batch}",
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete),
//                     onPressed: () => controller.deleteStudent(student.id),
//                   ),
//                 );
//               }).toList(),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
