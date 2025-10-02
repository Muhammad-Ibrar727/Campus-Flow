// // lib/pages/user_management_page.dart
// import 'package:campus_flow/app/modules/Admin/controllers/manage_users_controller/manage_users_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class UserManagementPage extends StatelessWidget {
//   UserManagementPage({super.key}) {
//     Get.put(ManageUsersController(), permanent: true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ManageUsersController controller = Get.find<ManageUsersController>();

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Stats with live data - now shows filtered counts
//             _buildStatsHeader(controller),
//             const SizedBox(height: 24),

//             // Search and Filter Bar
//             _buildSearchFilterBar(controller),
//             const SizedBox(height: 16),

//             // Users List with live data
//             Expanded(child: _buildUsersList(controller)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStatsHeader(ManageUsersController controller) {
//     return Obx(
//       () => Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildStatItem(
//                 'Total Users',
//                 // Show filtered count if search/filter is active
//                 controller.totalUsers.toString(),
//                 Colors.blue,
//               ),
//               _buildStatItem(
//                 'Approved',
//                 controller.approvedCount.toString(),
//                 Colors.green,
//               ),
//               _buildStatItem(
//                 'Pending',
//                 controller.pendingCount.toString(),
//                 Colors.orange,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatItem(String title, String count, Color color) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Text(
//             count,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 12,
//             color: Colors.grey,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSearchFilterBar(ManageUsersController controller) {
//     return Row(
//       children: [
//         // Search Field
//         Expanded(
//           child: Container(
//             height: 48,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: TextField(
//               onChanged: (value) => controller.setSearchQuery(value),
//               decoration: InputDecoration(
//                 hintStyle: const TextStyle(fontSize: 15, color: Colors.black45),
//                 hintText: 'Search users by email or role...',
//                 prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                 border: InputBorder.none,
//                 suffixIcon: controller.searchQuery.isNotEmpty
//                     ? IconButton(
//                         icon: const Icon(Icons.clear, color: Colors.grey),
//                         onPressed: () => controller.clearSearch(),
//                       )
//                     : null,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 12),

//         // Filter Dropdown
//         Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Obx(
//             () => DropdownButtonHideUnderline(
//               child: DropdownButton<String>(
//                 padding: EdgeInsets.symmetric(vertical: 5),
//                 value: controller.selectedFilter.value,
//                 icon: const Icon(Icons.filter_list, color: Colors.grey),
//                 elevation: 16,
//                 style: const TextStyle(color: Colors.black54, fontSize: 14),
//                 borderRadius: BorderRadius.circular(12),
//                 items: <String>['All Users', 'Approved', 'Pending']
//                     .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: Text(value),
//                         ),
//                       );
//                     })
//                     .toList(),
//                 onChanged: (String? newValue) {
//                   if (newValue != null) {
//                     controller.setFilter(newValue);
//                   }
//                 },
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildUsersList(ManageUsersController controller) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       // Use filtered users instead of all users
//       final filteredUsers = controller.filteredUsers;

//       if (filteredUsers.isEmpty) {
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
//               const SizedBox(height: 16),
//               Text(
//                 controller.searchQuery.isNotEmpty
//                     ? 'No users found for "${controller.searchQuery.value}"'
//                     : 'No users found',
//                 style: const TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 controller.searchQuery.isNotEmpty
//                     ? 'Try a different search term'
//                     : 'Add users or check your Firestore database',
//                 style: TextStyle(fontSize: 14, color: Colors.grey[500]),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         );
//       }

//       return ListView.builder(
//         itemCount: filteredUsers.length,
//         itemBuilder: (context, index) {
//           return _UserCard(user: filteredUsers[index], controller: controller);
//         },
//       );
//     });
//   }
// }

// class _UserCard extends StatelessWidget {
//   final UserModel user;
//   final ManageUsersController controller;

//   const _UserCard({required this.user, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     final canDelete = controller.canDeleteUser(user.id);
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 1,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             // Avatar
//             Container(
//               width: 48,
//               height: 48,
//               decoration: BoxDecoration(
//                 color: _getAvatarColor(user.email),
//                 shape: BoxShape.circle,
//               ),
//               child: Center(
//                 child: Text(
//                   user.email[0].toUpperCase(),
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(width: 12),

//             // User Info - Made responsive
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Email with flexible width
//                   SizedBox(
//                     width: screenWidth * 0.5, // Use 50% of screen width
//                     child: Row(
//                       children: [
//                         Flexible(
//                           child: Text(
//                             user.email,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                           ),
//                         ),
//                         if (user.isProtected) ...[
//                           const SizedBox(width: 6),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 6,
//                               vertical: 2,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.orange.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(4),
//                               border: Border.all(color: Colors.orange),
//                             ),
//                             child: const Text(
//                               'Protected',
//                               style: TextStyle(
//                                 color: Colors.orange,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 6),

//                   // Role and Status - Wrap on small screens
//                   screenWidth > 400
//                       ? _buildHorizontalRoleStatus() // Horizontal for larger screens
//                       : _buildVerticalRoleStatus(), // Vertical for small screens
//                 ],
//               ),
//             ),

//             // Action Buttons
//             _buildActionButtons(context, canDelete, user),
//           ],
//         ),
//       ),
//     );
//   }

//   // Horizontal layout for larger screens
//   Widget _buildHorizontalRoleStatus() {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: _getRoleColor(user.role),
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: Text(
//             user.role,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: user.isApproved
//                 ? Colors.green.withOpacity(0.1)
//                 : Colors.orange.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(4),
//             border: Border.all(
//               color: user.isApproved ? Colors.green : Colors.orange,
//               width: 1,
//             ),
//           ),
//           child: Text(
//             user.isApproved ? 'Approved' : 'Pending',
//             style: TextStyle(
//               color: user.isApproved ? Colors.green : Colors.orange,
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // Vertical layout for small screens
//   Widget _buildVerticalRoleStatus() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: _getRoleColor(user.role),
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: Text(
//             user.role,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         const SizedBox(height: 4),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: user.isApproved
//                 ? Colors.green.withOpacity(0.1)
//                 : Colors.orange.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(4),
//             border: Border.all(
//               color: user.isApproved ? Colors.green : Colors.orange,
//               width: 1,
//             ),
//           ),
//           child: Text(
//             user.isApproved ? 'Approved' : 'Pending',
//             style: TextStyle(
//               color: user.isApproved ? Colors.green : Colors.orange,
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // Action Buttons with responsive sizing
//   Widget _buildActionButtons(BuildContext context, bool canDelete, UserModel user) {
//     return Container(
//       constraints: const BoxConstraints(
//         maxWidth: 100,
//       ), // Limit button area width
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (!user.isApproved)
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.green.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: IconButton(
//                 icon: const Icon(Icons.check, color: Colors.green, size: 20),
//                 onPressed: () async {
//                   try {
//                     await controller.approveUser(user.id);
//                     Get.snackbar(
//                       'Success',
//                       '${user.email} approved successfully',
//                       backgroundColor: Colors.green,
//                       colorText: Colors.white,
//                       duration: const Duration(seconds: 3),
//                     );
//                   } catch (e) {
//                     Get.snackbar(
//                       'Error',
//                       'Error approving user: $e',
//                       backgroundColor: Colors.red,
//                       colorText: Colors.white,
//                       duration: const Duration(seconds: 4),
//                     );
//                   }
//                 },
//                 tooltip: 'Approve User',
//                 padding: const EdgeInsets.all(6),
//               ),
//             ),
//           const SizedBox(width: 6),
//           Container(
//             decoration: BoxDecoration(
//               color: canDelete
//                   ? Colors.red.withOpacity(0.1)
//                   : Colors.grey.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: IconButton(
//               icon: Icon(
//                 Icons.delete_outline,
//                 color: canDelete ? Colors.red : Colors.grey,
//                 size: 20,
//               ),
//               onPressed: canDelete
//                   ? () async {
//                       bool confirm = await showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                           title: const Text('Delete User'),
//                           content: Text(
//                             'Are you sure you want to delete ${user.email}?',
//                           ),
//                           actions: [
//                             TextButton(
//                               onPressed: () => Navigator.of(context).pop(false),
//                               child: const Text('Cancel'),
//                             ),
//                             TextButton(
//                               onPressed: () => Navigator.of(context).pop(true),
//                               child: const Text(
//                                 'Delete',
//                                 style: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );

//                       if (confirm == true) {
//                         try {
//                           await controller.deleteUser(user.id);
//                           Get.snackbar(
//                             'Success',
//                             '${user.email} deleted successfully',
//                             backgroundColor: Colors.red,
//                             colorText: Colors.white,
//                             duration: const Duration(seconds: 3),
//                           );
//                         } catch (e) {
//                           Get.snackbar(
//                             'Error',
//                             'Error deleting user: $e',
//                             backgroundColor: Colors.red,
//                             colorText: Colors.white,
//                             duration: const Duration(seconds: 4),
//                           );
//                         }
//                       }
//                     }
//                   : null,
//               tooltip: canDelete
//                   ? 'Delete User'
//                   : 'Protected user cannot be deleted',
//               padding: const EdgeInsets.all(6),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Color _getAvatarColor(String email) {
//     final colors = [
//       Colors.blue.shade400,
//       Colors.purple.shade400,
//       Colors.orange.shade400,
//       Colors.teal.shade400,
//     ];
//     return colors[email.hashCode % colors.length];
//   }

//   Color _getRoleColor(String role) {
//     switch (role.toLowerCase()) {
//       case 'admin':
//         return Colors.red.shade400;
//       case 'teacher':
//         return Colors.blue.shade400;
//       default:
//         return Colors.grey.shade600;
//     }
//   }
// }

// lib/pages/user_management_page.dart
import 'package:campus_flow/app/modules/Admin/controllers/manage_users_controller/manage_users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserManagementPage extends StatelessWidget {
  UserManagementPage({super.key}) {
    Get.put(ManageUsersController(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    final ManageUsersController controller = Get.find<ManageUsersController>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Modern Header (same as department view)
          _buildHeader(controller),

          // Search and Filter Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildSearchFilterBar(controller),
          ),

          // Users List with live data
          Expanded(child: _buildUsersList(controller)),
        ],
      ),
    );
  }

  Widget _buildHeader(ManageUsersController controller) {
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
          children: [
            const SizedBox(height: 16),
            Obx(() => _buildStatsRow(controller)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(ManageUsersController controller) {
    final stats = [
      {
        'count': controller.totalUsers.toString(),
        'label': 'Total Users',
        'color': Colors.white,
      },
      {
        'count': controller.approvedCount.toString(),
        'label': 'Approved',
        'color': Colors.green[100]!,
      },
      {
        'count': controller.pendingCount.toString(),
        'label': 'Pending',
        'color': Colors.orange[100]!,
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: stats
          .map(
            (stat) => _buildStatItem(
              stat['count'] as String,
              stat['label'] as String,
              stat['color'] as Color,
            ),
          )
          .toList(),
    );
  }

  Widget _buildStatItem(String count, String label, Color color) {
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

  Widget _buildSearchFilterBar(ManageUsersController controller) {
    return Row(
      children: [
        // Search Field
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) => controller.setSearchQuery(value),
              decoration: InputDecoration(
                hintStyle: const TextStyle(fontSize: 15, color: Colors.black45),
                hintText: 'Search users by email or role...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                suffixIcon: controller.searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () => controller.clearSearch(),
                      )
                    : null,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Filter Dropdown
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Obx(
            () => DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                padding: const EdgeInsets.symmetric(vertical: 5),
                value: controller.selectedFilter.value,
                icon: const Icon(Icons.filter_list, color: Colors.grey),
                elevation: 16,
                style: const TextStyle(color: Colors.black54, fontSize: 14),
                borderRadius: BorderRadius.circular(12),
                items: <String>['All Users', 'Approved', 'Pending']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(value),
                        ),
                      );
                    })
                    .toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.setFilter(newValue);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUsersList(ManageUsersController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Use filtered users instead of all users
      final filteredUsers = controller.filteredUsers;

      if (filteredUsers.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                controller.searchQuery.isNotEmpty
                    ? 'No users found for "${controller.searchQuery.value}"'
                    : 'No users found',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                controller.searchQuery.isNotEmpty
                    ? 'Try a different search term'
                    : 'Add users or check your Firestore database',
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filteredUsers.length,
        itemBuilder: (context, index) {
          return _UserCard(user: filteredUsers[index], controller: controller);
        },
      );
    });
  }
}

class _UserCard extends StatelessWidget {
  final UserModel user;
  final ManageUsersController controller;

  const _UserCard({required this.user, required this.controller});

  @override
  Widget build(BuildContext context) {
    final canDelete = controller.canDeleteUser(user.id);
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getAvatarColor(user.email),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  user.email[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // User Info - Made responsive
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email with flexible width
                  SizedBox(
                    width: screenWidth * 0.5, // Use 50% of screen width
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            user.email,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        if (user.isProtected) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.orange),
                            ),
                            child: const Text(
                              'Protected',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Role and Status - Wrap on small screens
                  screenWidth > 400
                      ? _buildHorizontalRoleStatus() // Horizontal for larger screens
                      : _buildVerticalRoleStatus(), // Vertical for small screens
                ],
              ),
            ),

            // Action Buttons
            _buildActionButtons(context, canDelete, user),
          ],
        ),
      ),
    );
  }

  // Horizontal layout for larger screens
  Widget _buildHorizontalRoleStatus() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getRoleColor(user.role),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            user.role,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: user.isApproved
                ? Colors.green.withOpacity(0.1)
                : Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: user.isApproved ? Colors.green : Colors.orange,
              width: 1,
            ),
          ),
          child: Text(
            user.isApproved ? 'Approved' : 'Pending',
            style: TextStyle(
              color: user.isApproved ? Colors.green : Colors.orange,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // Vertical layout for small screens
  Widget _buildVerticalRoleStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getRoleColor(user.role),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            user.role,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: user.isApproved
                ? Colors.green.withOpacity(0.1)
                : Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: user.isApproved ? Colors.green : Colors.orange,
              width: 1,
            ),
          ),
          child: Text(
            user.isApproved ? 'Approved' : 'Pending',
            style: TextStyle(
              color: user.isApproved ? Colors.green : Colors.orange,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // Action Buttons with responsive sizing
  Widget _buildActionButtons(
    BuildContext context,
    bool canDelete,
    UserModel user,
  ) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 120,
      ), // Limit button area width
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!user.isApproved)
            Container(
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.check, color: Colors.green, size: 20),
                onPressed: () async {
                  try {
                    await controller.approveUser(user.id);
                    Get.snackbar(
                      'Success',
                      '${user.email} approved successfully',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 3),
                    );
                  } catch (e) {
                    Get.snackbar(
                      'Error',
                      'Error approving user: $e',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 4),
                    );
                  }
                },
                tooltip: 'Approve User',
                padding: const EdgeInsets.all(6),
              ),
            ),
          const SizedBox(width: 6),
          Container(
            decoration: BoxDecoration(
              color: canDelete
                  ? Colors.red.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: canDelete ? Colors.red : Colors.grey,
                size: 20,
              ),
              onPressed: canDelete
                  ? () async {
                      bool confirm = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete User'),
                          content: Text(
                            'Are you sure you want to delete ${user.email}?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        try {
                          await controller.deleteUser(user.id);
                          Get.snackbar(
                            'Success',
                            '${user.email} deleted successfully',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 3),
                          );
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            'Error deleting user: $e',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 4),
                          );
                        }
                      }
                    }
                  : null,
              tooltip: canDelete
                  ? 'Delete User'
                  : 'Protected user cannot be deleted',
              padding: const EdgeInsets.all(6),
            ),
          ),
        ],
      ),
    );
  }

  Color _getAvatarColor(String email) {
    final colors = [
      Colors.blue.shade400,
      Colors.purple.shade400,
      Colors.orange.shade400,
      Colors.teal.shade400,
    ];
    return colors[email.hashCode % colors.length];
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Colors.red.shade400;
      case 'teacher':
        return Colors.blue.shade400;
      default:
        return Colors.grey.shade600;
    }
  }
}
