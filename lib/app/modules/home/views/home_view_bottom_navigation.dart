import 'package:campus_flow/app/modules/Admin/controllers/profile_controller/admin_profile_controller.dart';
import 'package:campus_flow/app/modules/Admin/view/admin_panel.dart';
import 'package:campus_flow/app/modules/Admin/view/profile/admin_profile.dart';
import 'package:campus_flow/app/modules/auth/controllers/auth_controller.dart';
import 'package:campus_flow/app/modules/auth/views/login_screen.dart';
import 'package:campus_flow/app/modules/Developer/Developer_profile.dart';
import 'package:campus_flow/app/modules/home/views/Fine/fine_screen.dart';
import 'package:campus_flow/app/modules/home/views/home_view.dart';
import 'package:campus_flow/app/modules/home/views/search%20student/search_student_view.dart';
import 'package:campus_flow/app/modules/home/views/search_student.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewBottomNavigation extends StatefulWidget {
  const HomeViewBottomNavigation({super.key});

  @override
  State<HomeViewBottomNavigation> createState() =>
      _HomeViewBottomNavigationState();
}

class _HomeViewBottomNavigationState extends State<HomeViewBottomNavigation> {
  final _currentIndex = 0.obs;
  final AuthController authController = Get.find<AuthController>();
  final ProfileController Profilecontroller = Get.put(ProfileController());
  late PageController _pageController;

  final List<Widget> Screens = [
    HomeView(),
    SearchStudentScreen(),
    FineManagementScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex.value);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 38, 89, 152),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Text("Campus Flow", style: TextStyle(color: Colors.white)),
            SizedBox(width: 10),
            Icon(Icons.school_rounded, color: Colors.white, size: 30),
          ],
        ),
      ),
      drawer: _buildDrawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _currentIndex.value = index;
        },
        children: Screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Obx(
          () => BottomNavigationBar(
            currentIndex: _currentIndex.value,
            onTap: (index) {
              _currentIndex.value = index;
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey[600],
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_search),
                label: 'Find a Student',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.warning),
                label: 'Fine a Student',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    final currentIndex = 0.obs;

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 🔹 Drawer Header
          Container(
            height: 280,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 38, 89, 152),
                  Color.fromARGB(255, 58, 109, 172),
                  Color.fromARGB(255, 78, 129, 192),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Background pattern
                Positioned(
                  top: -20,
                  right: -20,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -30,
                  left: -30,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile Avatar with Badge
                      Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 3,
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.3),
                                  Colors.white.withOpacity(0.1),
                                  ],
                              ),
                            ),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      // User Information
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Profilecontroller.userName.value,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: 4),

                            Row(
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 16,
                                ),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    Profilecontroller.userEmail.value,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 12),

                            // Role Badge
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    authController.role.value == 'Admin'
                                        ? Icons.admin_panel_settings
                                        : Icons.school,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: 6),
                                  Obx(
                                    () => Text(
                                      authController.role.value.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Decorative elements
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 40,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          // 🔹 Navigation Items
          Obx(
            () => _buildDrawerItem(
              icon: Icons.home_outlined,
              title: 'Home',
              onTap: () {
                _currentIndex.value = 0;
                _pageController.jumpToPage(0);
                Get.back();
              },
              isSelected: _currentIndex.value == 0,
            ),
          ),
          Divider(color: Colors.grey[300]),

          Obx(
            () => _buildDrawerItem(
              icon: Icons.person_search_outlined,
              title: 'Find Student',
              onTap: () {
                _currentIndex.value = 1;
                _pageController.jumpToPage(1);
                Get.back();
              },
              isSelected: _currentIndex.value == 1,
            ),
          ),

          Divider(color: Colors.grey[300]),

          // 🔹 Settings
          _buildDrawerItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {
              Get.back();
              Get.snackbar(
                'Settings',
                'Settings screen coming soon',
                backgroundColor: Colors.blue,
                colorText: Colors.white,
              );
            },
          ),
          Divider(color: Colors.grey[300]),

          // 🔹 Help & Support
          _buildDrawerItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              Get.back();
              Get.snackbar(
                'Help & Support',
                'Help center coming soon',
                backgroundColor: Colors.blue,
                colorText: Colors.white,
              );
            },
          ),
          Divider(color: Colors.grey[300]),

          // 🔹 Settings
          _buildDrawerItem(
            icon: Icons.person_outline,
            title: 'About Developers',
            onTap: () {
              Get.to(() => DeveloperProfile());
            },
          ),

          Divider(color: Colors.grey[300]),

          // 🔹 Logout
          _buildDrawerItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              Get.back();
              _showLogoutDialog();
            },
            color: Colors.red,
          ),

          // 🔹 App Info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Campus Flow v1.0.0',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? (isSelected ? Colors.blue : Colors.grey[700]),
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? (isSelected ? Colors.blue : Colors.black87),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16)
          : null,
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: Colors.blue.withOpacity(0.1),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
          TextButton(
            onPressed: () {
              authController.logout();
              Get.offAll(LoginScreen());
            },
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
