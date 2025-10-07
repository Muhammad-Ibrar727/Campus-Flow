// import 'package:campus_flow/app/modules/Admin/controllers/admin_stats_controller.dart';
// import 'package:campus_flow/app/modules/Admin/view/departments.dart';
// import 'package:campus_flow/app/modules/auth/views/login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/admin_controller.dart';

// class AdminDashboard extends StatelessWidget {
//   final AdminController controller = Get.put(AdminController());
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final AdminStatsController statsController = Get.put(AdminStatsController());

//   AdminDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isSmall = size.width < 600; // 📱 Mobile
//     final isMedium = size.width >= 600 && size.width < 1000; // 📊 Tablet
//     final isLarge = size.width >= 1000; // 💻 Desktop

//     int gridCount = isSmall ? 2 : (isMedium ? 3 : 5);

//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ✅ Stats Section → Wrap to avoid overflow
//               Obx(
//                 () => Wrap(
//                   spacing: 12,
//                   runSpacing: 12,
//                   children: [
//                     _buildStatCard(
//                       "Departments",
//                       controller.departments.length.toString(),
//                       Icons.apartment,
//                       size,
//                     ),
//                     _buildStatCard(
//                       "students",
//                       statsController.totalStudents.value.toString(),
//                       Icons.apartment,
//                       size,
//                     ),

//                     _buildStatCard(
//                       "Admins",
//                       statsController.totalAdmins.value.toString(),
//                       Icons.admin_panel_settings,
//                       size,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),

//               const Text(
//                 "Departments",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 12),

//               // ✅ Responsive Grid
//               Obx(() {
//                 return GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: gridCount,
//                     childAspectRatio: isSmall ? 1.1 : 1.1, // better fit
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                   ),
//                   itemCount: controller.departments.length,
//                   itemBuilder: (context, index) {
//                     final dept = controller.departments[index];
//                     return Card(
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(16),
//                         onTap: () {
//                           Get.to(
//                             () => DepartmentView(departmentName: dept.name),
//                           );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(18.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CircleAvatar(
//                                 radius: isSmall ? 22 : 28,
//                                 backgroundColor: dept.color.withOpacity(0.2),
//                                 child: Icon(
//                                   dept.icon,
//                                   size: isSmall ? 24 : 32,
//                                   color: dept.color,
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               Flexible(
//                                 fit: FlexFit.loose,
//                                 child: Text(
//                                   dept.name,
//                                   textAlign: TextAlign.center,
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 1,
//                                   style: TextStyle(
//                                     fontSize: isSmall ? 12 : 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ✅ Responsive Stat Card
//   Widget _buildStatCard(String title, String value, IconData icon, Size size) {
//     double cardWidth = size.width < 600 ? size.width / 2 - 24 : 200;

//     return Container(
//       width: cardWidth,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: Colors.blueGrey[100],
//             child: Icon(icon, color: Colors.blueGrey[800]),
//           ),
//           const SizedBox(width: 12),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(title, style: const TextStyle(color: Colors.black54)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:campus_flow/app/modules/Admin/controllers/admin_stats_controller.dart';
import 'package:campus_flow/app/modules/Admin/view/departments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_controller.dart';

class AdminDashboard extends StatelessWidget {
  final AdminController controller = Get.put(AdminController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AdminStatsController statsController = Get.put(AdminStatsController());

  AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600; // 📱 Mobile
    final isMedium = size.width >= 600 && size.width < 1000; // 📊 Tablet
    final isLarge = size.width >= 1000; // 💻 Desktop

    int gridCount = isSmall ? 2 : (isMedium ? 3 : 5);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Modern Header (same as department and user management)
          _buildHeader(),

          // Content Area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  const Text(
                    "Departments",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ✅ Responsive Grid
                  Obx(() {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCount,
                        childAspectRatio: isSmall ? 1.1 : 1.1,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: controller.departments.length,
                      itemBuilder: (context, index) {
                        final dept = controller.departments[index];
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              Get.to(
                                () => DepartmentView(departmentName: dept.name),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: isSmall ? 22 : 28,
                                    backgroundColor: dept.color.withOpacity(
                                      0.2,
                                    ),
                                    child: Icon(
                                      dept.icon,
                                      size: isSmall ? 24 : 32,
                                      color: dept.color,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Flexible(
                                    child: Text(
                                      dept.name,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: isSmall ? 12 : 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [Colors.blue[700]!, Colors.purple[600]!],
        // ),
        color: Colors.blueGrey[700],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const SizedBox(height: 16), Obx(() => _buildStatsRow())],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    final stats = [
      {
        'count': controller.departments.length.toString(),
        'label': 'Departments',
      },
      {
        'count': statsController.totalStudents.value.toString(),
        'label': 'Students',
      },
      {
        'count': statsController.totalAdmins.value.toString(),
        'label': 'Admins',
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: stats
          .map((stat) => _buildStatItem(stat['count']!, stat['label']!))
          .toList(),
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
        ),
      ],
    );
  }
}
