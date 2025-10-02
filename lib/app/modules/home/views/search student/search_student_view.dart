import 'package:campus_flow/app/modules/home/controllers/search%20student/search_student_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchStudentScreen extends StatelessWidget {
  final SearchStudentController controller = Get.put(SearchStudentController());

  SearchStudentScreen({super.key});

  // Department icons mapping
  final Map<String, IconData> departmentIcons = {
    'Pakistan Studies': Icons.public,
    'Computer Science': Icons.computer,
    'Statistics': Icons.bar_chart,
    'Islamic Studies': Icons.auto_stories,
    'English': Icons.menu_book,
    'Economics': Icons.attach_money,
    'Political Science': Icons.gavel,
    'Zoology': Icons.pets,
    'Botany': Icons.grass,
    'Pashto': Icons.translate,
    'Urdu': Icons.language,
    'Mathematics': Icons.calculate,
    'Chemistry': Icons.science,
    'AI': Icons.memory,
    'Physics': Icons.bolt,
  };

  // Department colors mapping
  final Map<String, Color> departmentColors = {
    'Pakistan Studies': Colors.indigo,
    'Computer Science': Colors.blue,
    'Statistics': Colors.green,
    'Islamic Studies': Colors.teal,
    'English': Colors.deepPurple,
    'Economics': Colors.amber,
    'Political Science': Colors.redAccent,
    'Zoology': Colors.brown,
    'Botany': Colors.green,
    'Pashto': Colors.orange,
    'Urdu': Colors.pink,
    'Mathematics': Colors.blueGrey,
    'Chemistry': Colors.deepOrange,
    'AI': Colors.cyan,
    'Physics': Colors.yellow.shade700,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // // Header
            // _buildHeader(),
            const SizedBox(height: 20),

            // Search Bar
            _buildSearchBar(),
            const SizedBox(height: 16),

            // Results Info
            _buildResultsInfo(),
            const SizedBox(height: 8),

            // Students List
            Expanded(child: _buildStudentsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Find students across all departments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: TextField(
          onChanged: controller.onSearchChanged,
          decoration: InputDecoration(
            hintText: "Find student across all departments....",
            hintStyle: TextStyle(color: Colors.grey.shade500),
            prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
          style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
        ),
      ),
    );
  }

  Widget _buildResultsInfo() {
    return Obx(() {
      final count = controller.filteredStudents.length;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Text(
              '$count student${count == 1 ? '' : 's'}',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildStudentsList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
              ),
              SizedBox(height: 16),
              Text(
                'Loading students...',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        );
      }

      final students = controller.filteredStudents;

      if (students.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  controller.searchQuery.isNotEmpty
                      ? Icons.search_off_rounded
                      : Icons.people_outline_rounded,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  controller.searchQuery.isNotEmpty
                      ? 'No students found'
                      : 'No students available',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  controller.searchQuery.isNotEmpty
                      ? 'Try adjusting your search'
                      : 'Students will appear here once added',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return _buildStudentCard(student);
        },
      );
    });
  }

  Widget _buildStudentCard(Student student) {
    final departmentColor = departmentColors[student.department] ?? Colors.grey;
    final departmentIcon = departmentIcons[student.department] ?? Icons.school;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar with department color
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: departmentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: departmentColor.withOpacity(0.2)),
                  ),
                  child: Icon(departmentIcon, size: 20, color: departmentColor),
                ),
                const SizedBox(width: 12),

                // Student Info (Name, Roll Number, Department)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            student.rollNumber,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 120,
                              ), // Adjust as needed
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: departmentColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                student.department,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: departmentColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Semester and Batch (Right Side)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Semester
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        student.semester.isNotEmpty
                            ? 'Sem ${student.semester}'
                            : 'N/A',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Batch
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Batch ${student.session}',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:campus_flow/app/modules/home/controllers/search%20student/search_student_controllers.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SearchStudentScreen extends StatelessWidget {
//   final SearchStudentController controller = Get.put(SearchStudentController());

//   SearchStudentScreen({super.key});

//   // Department icons mapping
//   final Map<String, IconData> departmentIcons = {
//     'Pakistan Studies': Icons.public,
//     'Computer Science': Icons.computer,
//     'Statistics': Icons.bar_chart,
//     'Islamic Studies': Icons.auto_stories,
//     'English': Icons.menu_book,
//     'Economics': Icons.attach_money,
//     'Political Science': Icons.gavel,
//     'Zoology': Icons.pets,
//     'Botany': Icons.grass,
//     'Pashto': Icons.translate,
//     'Urdu': Icons.language,
//     'Mathematics': Icons.calculate,
//     'Chemistry': Icons.science,
//     'AI': Icons.memory,
//     'Physics': Icons.bolt,
//   };

//   // Department colors mapping
//   final Map<String, Color> departmentColors = {
//     'Pakistan Studies': Colors.indigo,
//     'Computer Science': Colors.blue,
//     'Statistics': Colors.green,
//     'Islamic Studies': Colors.teal,
//     'English': Colors.deepPurple,
//     'Economics': Colors.amber,
//     'Political Science': Colors.redAccent,
//     'Zoology': Colors.brown,
//     'Botany': Colors.green,
//     'Pashto': Colors.orange,
//     'Urdu': Colors.pink,
//     'Mathematics': Colors.blueGrey,
//     'Chemistry': Colors.deepOrange,
//     'AI': Colors.cyan,
//     'Physics': Colors.yellow.shade700,
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header
//             _buildHeader(),
//             const SizedBox(height: 20),

//             // Search Bar
//             _buildSearchBar(),
//             const SizedBox(height: 16),

//             // Results Info
//             _buildResultsInfo(),
//             const SizedBox(height: 8),

//             // Students List
//             Expanded(child: _buildStudentsList()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Search Students',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.grey.shade900,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 'Find students across all departments',
//                 style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
//               ),
//             ],
//           ),
//           const Spacer(),
//           Container(
//             width: 44,
//             height: 44,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               shape: BoxShape.circle,
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: Icon(
//               Icons.person_outline,
//               color: Colors.grey.shade700,
//               size: 20,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.grey.shade200),
//               ),
//               child: TextField(
//                 onChanged: controller.onSearchChanged,
//                 decoration: InputDecoration(
//                   hintText: "Search students...",
//                   hintStyle: TextStyle(color: Colors.grey.shade500),
//                   prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
//                   border: InputBorder.none,
//                   contentPadding: const EdgeInsets.symmetric(vertical: 15),
//                 ),
//                 style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Obx(() => _buildFilterButton()),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterButton() {
//     return Container(
//       height: 50,
//       width: 50,
//       decoration: BoxDecoration(
//         color: controller.selectedDepartment.value != 'All'
//             ? departmentColors[controller.selectedDepartment.value]
//                   ?.withOpacity(0.1)
//             : Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: controller.selectedDepartment.value != 'All'
//               ? departmentColors[controller.selectedDepartment.value]!
//                     .withOpacity(0.3)
//               : Colors.grey.shade200,
//         ),
//       ),
//       child: PopupMenuButton<String>(
//         icon: Icon(
//           Icons.filter_list_rounded,
//           color: controller.selectedDepartment.value != 'All'
//               ? departmentColors[controller.selectedDepartment.value]
//               : Colors.grey.shade500,
//           size: 20,
//         ),
//         onSelected: controller.onDepartmentChanged,
//         itemBuilder: (BuildContext context) {
//           return controller.departmentsList.map((String department) {
//             return PopupMenuItem<String>(
//               value: department,
//               child: Row(
//                 children: [
//                   if (department != 'All')
//                     Container(
//                       width: 32,
//                       height: 32,
//                       decoration: BoxDecoration(
//                         color: departmentColors[department]?.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Icon(
//                         departmentIcons[department] ?? Icons.school,
//                         color: departmentColors[department],
//                         size: 16,
//                       ),
//                     ),
//                   if (department != 'All') const SizedBox(width: 12),
//                   Expanded(
//                     child: Text(
//                       department,
//                       style: TextStyle(
//                         fontWeight:
//                             department == controller.selectedDepartment.value
//                             ? FontWeight.w600
//                             : FontWeight.normal,
//                         color: department == controller.selectedDepartment.value
//                             ? Colors.blue.shade700
//                             : Colors.grey.shade700,
//                       ),
//                     ),
//                   ),
//                   if (department == controller.selectedDepartment.value)
//                     Icon(
//                       Icons.check_rounded,
//                       color: Colors.blue.shade700,
//                       size: 18,
//                     ),
//                 ],
//               ),
//             );
//           }).toList();
//         },
//       ),
//     );
//   }

//   Widget _buildResultsInfo() {
//     return Obx(() {
//       final count = controller.filteredStudents.length;
//       final totalCount = controller.studentsList.length;

//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Row(
//           children: [
//             Text(
//               '$count student${count == 1 ? '' : 's'}',
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const Spacer(),
//             if (controller.selectedDepartment.value != 'All')
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 6,
//                 ),
//                 decoration: BoxDecoration(
//                   color: departmentColors[controller.selectedDepartment.value]
//                       ?.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       departmentIcons[controller.selectedDepartment.value],
//                       color:
//                           departmentColors[controller.selectedDepartment.value],
//                       size: 14,
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       controller.selectedDepartment.value,
//                       style: TextStyle(
//                         color:
//                             departmentColors[controller
//                                 .selectedDepartment
//                                 .value],
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       );
//     });
//   }

//   Widget _buildStudentsList() {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Loading students...',
//                 style: TextStyle(color: Colors.grey, fontSize: 14),
//               ),
//             ],
//           ),
//         );
//       }

//       final students = controller.filteredStudents;

//       if (students.isEmpty) {
//         return Center(
//           child: Padding(
//             padding: const EdgeInsets.all(32.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   controller.searchQuery.isNotEmpty ||
//                           controller.selectedDepartment.value != 'All'
//                       ? Icons.search_off_rounded
//                       : Icons.people_outline_rounded,
//                   size: 64,
//                   color: Colors.grey.shade400,
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   controller.searchQuery.isNotEmpty ||
//                           controller.selectedDepartment.value != 'All'
//                       ? 'No students found'
//                       : 'No students available',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   controller.searchQuery.isNotEmpty ||
//                           controller.selectedDepartment.value != 'All'
//                       ? 'Try adjusting your search or filter'
//                       : 'Students will appear here once added',
//                   style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         );
//       }

//       return ListView.builder(
//         padding: const EdgeInsets.all(20),
//         itemCount: students.length,
//         itemBuilder: (context, index) {
//           final student = students[index];
//           return _buildStudentCard(student);
//         },
//       );
//     });
//   }

//   Widget _buildStudentCard(Student student) {
//     final departmentColor = departmentColors[student.department] ?? Colors.grey;
//     final departmentIcon = departmentIcons[student.department] ?? Icons.school;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(12),
//         child: InkWell(
//           onTap: () {
//             // Navigate to student details
//           },
//           borderRadius: BorderRadius.circular(12),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 // Avatar with department color
//                 Container(
//                   width: 44,
//                   height: 44,
//                   decoration: BoxDecoration(
//                     color: departmentColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: departmentColor.withOpacity(0.2)),
//                   ),
//                   child: Icon(departmentIcon, size: 20, color: departmentColor),
//                 ),
//                 const SizedBox(width: 12),

//                 // Student Info (Name, Roll Number, Department)
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         student.name,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black87,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 6),
//                       Row(
//                         children: [
//                           Text(
//                             student.rollNumber,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey.shade600,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: departmentColor.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: Text(
//                               student.department,
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: departmentColor,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 // Semester and Batch (Right Side)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     // Semester
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.blue.shade50,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         student.semester.isNotEmpty
//                             ? 'Sem ${student.semester}'
//                             : 'N/A',
//                         style: TextStyle(
//                           color: Colors.blue.shade700,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 6),

//                     // Batch
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.green.shade50,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         'Batch ${student.session}',
//                         style: TextStyle(
//                           color: Colors.green.shade700,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
