import 'package:campus_flow/app/modules/Admin/controllers/departments_controller.dart';
import 'package:campus_flow/app/modules/Admin/view/upload_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepartmentView extends StatelessWidget {
  final String departmentName;

  const DepartmentView({super.key, required this.departmentName});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DepartmentController(departmentName));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header with stats
          _buildHeader(controller),

          // Selection actions (when in selection mode)
          Obx(
            () => controller.selectionMode.value
                ? _buildSelectionActions(controller)
                : const SizedBox.shrink(),
          ),

          // Students list
          Expanded(child: _buildStudentsList(controller)),

          // Add Student Button (Fixed at bottom instead of FAB)
          Obx(
            () => controller.selectionMode.value
                ? const SizedBox.shrink()
                : _buildAddStudentButton(context, controller),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(DepartmentController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
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
            Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                Expanded(
                  child: Text(
                    departmentName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => controller.selectionMode.value
                      ? IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => controller.clearSelection(),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Obx(() => _buildStatsRow(controller)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(DepartmentController controller) {
    final stats = [
      {
        'count': controller.students.length.toString(),
        'label': 'Total Students',
      },
      {
        'count': controller.studentsBySemester.length.toString(),
        'label': 'Semesters',
      },
      {
        'count': controller.selectedStudents.length.toString(),
        'label': 'Selected',
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

  Widget _buildSelectionActions(DepartmentController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.orange[50],
      child: Row(
        children: [
          Text(
            "${controller.selectedStudents.length} selected",
            style: TextStyle(
              color: Colors.orange[800],
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.blue[700]),
            onPressed: () {
              Get.snackbar(
                "Info",
                "Bulk edit feature coming soon",
                backgroundColor: Colors.blue,
                colorText: Colors.white,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red[700]),
            onPressed: () => controller.deleteSelected(),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentsList(DepartmentController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.students.isEmpty) {
        return _buildEmptyState();
      }

      final studentsBySemester = controller.studentsBySemester;

      return ListView(
        padding: const EdgeInsets.all(16),
        children: studentsBySemester.entries.map((entry) {
          return _buildSemesterSection(
            entry.key,
            entry.value,
            controller,
            Get.context!,
          );
        }).toList(),
      );
    });
  }

  Widget _buildSemesterSection(
    String semester,
    List<StudentModel> students,
    DepartmentController controller,
    BuildContext context,
  ) {
    final isAllSelected = students.every(
      (student) => controller.selectedStudents.contains(student.id),
    );

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: const Color.fromARGB(0, 186, 32, 32),
        ),
        child: ExpansionTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.school, color: Colors.blue[700]),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  "Semester $semester",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 12,
                      color: Colors.blue[700],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${students.length} enrolled",
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: Obx(() {
            if (controller.selectionMode.value) {
              return Checkbox(
                value: isAllSelected,
                onChanged: (value) => controller.selectAllInSemester(semester),
              );
            } else {
              return const Icon(Icons.expand_more, color: Colors.grey);
            }
          }),
          children: students
              .map((student) => _buildStudentTile(student, controller, context))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildStudentTile(
    StudentModel student,
    DepartmentController controller,
    BuildContext context,
  ) {
    final isSelected = controller.selectedStudents.contains(student.id);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isSelected ? Border.all(color: Colors.blue, width: 1.5) : null,
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: isSelected
              ? const Icon(Icons.check, color: Colors.white, size: 20)
              : Center(
                  child: Text(
                    student.name[0].toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
        title: Text(
          student.name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.blue[800] : Colors.grey[800],
          ),
        ),
        subtitle: Text(
          "Roll: ${student.rollNumber} | Batch: ${student.session}",
          style: TextStyle(
            color: isSelected ? Colors.blue[600] : Colors.grey[600],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!controller.selectionMode.value) ...[
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue[600], size: 20),
                onPressed: () =>
                    _showEditStudentDialog(context, student, controller),
              ),
              const SizedBox(width: 4),
            ],
            Obx(
              () => controller.selectionMode.value
                  ? Checkbox(
                      value: isSelected,
                      onChanged: (value) =>
                          controller.toggleStudentSelection(student.id),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        onTap: () {
          if (controller.selectionMode.value) {
            controller.toggleStudentSelection(student.id);
          }
        },
        onLongPress: () => controller.toggleStudentSelection(student.id),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            "No Students Found",
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            "Add students to get started",
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  // Add Student Button (Fixed container at bottom)
  Widget _buildAddStudentButton(
    BuildContext context,
    DepartmentController controller,
  ) {
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _showAddOptions(context, controller),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey[700],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        icon: const Icon(Icons.add, size: 24),
        label: const Text(
          "Add Student",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _showAddOptions(BuildContext context, DepartmentController controller) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const Text(
                "Add Students",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person_add, color: Colors.blue[700]),
                ),
                title: const Text("Add Manually"),
                subtitle: const Text("Add one student at a time"),
                onTap: () {
                  Navigator.pop(context);
                  _showAddStudentDialog(context, controller);
                },
              ),
              const Divider(),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.file_upload, color: Colors.green),
                ),
                title: const Text("Upload Excel"),
                subtitle: const Text("Bulk upload from spreadsheet"),
                onTap: () {
                  Navigator.pop(context);
                  Get.to(
                    () => StudentUploadScreen(departmentName: departmentName),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddStudentDialog(
    BuildContext context,
    DepartmentController controller,
  ) {
    final nameController = TextEditingController();
    final rollController = TextEditingController();
    final sessionController = TextEditingController();
    final semesterController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Student"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: rollController,
                decoration: const InputDecoration(
                  labelText: "Roll Number",
                  prefixIcon: Icon(Icons.confirmation_number),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: sessionController,
                decoration: const InputDecoration(
                  labelText: "Session",
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: semesterController,
                decoration: const InputDecoration(
                  labelText: "Semester",
                  prefixIcon: Icon(Icons.school),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isEmpty ||
                  rollController.text.isEmpty ||
                  sessionController.text.isEmpty ||
                  semesterController.text.isEmpty) {
                Get.snackbar("Error", "Please fill all fields");
                return;
              }

              await controller.addStudent(
                name: nameController.text,
                roll: rollController.text,
                session: sessionController.text,
                semester: semesterController.text,
              );
              Navigator.pop(context);
            },
            child: const Text("Add Student"),
          ),
        ],
      ),
    );
  }

  void _showEditStudentDialog(
    BuildContext context,
    StudentModel student,
    DepartmentController controller,
  ) {
    final nameController = TextEditingController(text: student.name);
    final rollController = TextEditingController(text: student.rollNumber);
    final sessionController = TextEditingController(text: student.session);
    final semesterController = TextEditingController(text: student.semester);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Student"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: rollController,
                decoration: const InputDecoration(
                  labelText: "Roll Number",
                  prefixIcon: Icon(Icons.confirmation_number),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: sessionController,
                decoration: const InputDecoration(
                  labelText: "Session",
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: semesterController,
                decoration: const InputDecoration(
                  labelText: "Semester",
                  prefixIcon: Icon(Icons.school),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isEmpty ||
                  rollController.text.isEmpty ||
                  sessionController.text.isEmpty ||
                  semesterController.text.isEmpty) {
                Get.snackbar("Error", "Please fill all fields");
                return;
              }

              await controller.editStudent(
                id: student.id,
                name: nameController.text,
                roll: rollController.text,
                session: sessionController.text,
                semester: semesterController.text,
              );
              Navigator.pop(context);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }
}
