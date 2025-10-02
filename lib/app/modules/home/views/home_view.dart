import 'package:campus_flow/app/modules/home/controllers/home_controller.dart';
import 'package:campus_flow/app/modules/student/views/students_of_department.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/controllers/auth_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text(
              //   'Search Departments',
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black54,
              //   ),
              // ),

              // 🔹 Enhanced Search Bar
              _buildSearchBar(controller),
              const SizedBox(height: 28),

              // 🔹 Departments Section Header
              _buildSectionHeader(controller),
              const SizedBox(height: 16),

              // 🔹 Beautiful Departments Grid
              Expanded(
                child: Obx(() {
                  final departments = controller.filteredDepartments;
                  return _buildDepartmentsGrid(departments);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(HomeController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search departments...",
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            child: Icon(Icons.search_rounded, color: Colors.grey.shade500),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onChanged: (query) {
          controller.searchQuery.value = query;
        },
      ),
    );
  }

  Widget _buildSectionHeader(HomeController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Departments',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Obx(
            () => Text(
              '${controller.filteredDepartments.length} departments',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDepartmentsGrid(List<Department> departments) {
    if (departments.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: departments.length,
      itemBuilder: (context, index) {
        final dept = departments[index];
        return _buildDepartmentCard(dept);
      },
    );
  }

  Widget _buildDepartmentCard(Department dept) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.099),
            blurRadius: 15,
            offset: const Offset(1, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            Get.to(
              () => StudentsOfDepartment(department_name: dept.name),
              transition: Transition.zoom,
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔹 Icon Container with Background
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: dept.color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(dept.icon, size: 28, color: dept.color),
              ),
              const SizedBox(height: 12),

              // 🔹 Department Name
              Text(
                dept.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              // 🔹 Student Count (you can add this to your Department model later)
              const SizedBox(height: 6),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    _getDepartmentDescription(dept.name),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No departments found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  String _getDepartmentDescription(String departmentName) {
    // You can replace this with actual student counts from your database
    final descriptions = {
      "Pakistan Studies": "History & Culture",
      "Computer Science": "Tech & Programming",
      "Statistics": "Data & Analysis",
      "Islamic Studies": "Religion & Philosophy",
      "English": "Language & Literature",
      "Economics": "Markets & Finance",
      "Political Science": "Government & Policy",
      "Zoology": "Animal Biology",
      "Botany": "Plant Science",
      "Pashto": "Language Studies",
      "Urdu": "Literature & Language",
      "Mathematics": "Logic & Calculations",
      "Chemistry": "Science & Elements",
      "AI": "Machine Learning",
      "Physics": "Science & Laws",
    };

    return descriptions[departmentName] ?? "Academic Department";
  }
}
