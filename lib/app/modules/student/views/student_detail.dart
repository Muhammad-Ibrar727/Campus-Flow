import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentDetailsScreen extends StatelessWidget {
  final String studentName;
  final String studentSemeter;
  final String studentDepartment;
  final String studentBatch;
  final String studentRollNo;

  // Change from Map to List of Maps for multiple fines
  final RxList<Map<String, String>> finesList = <Map<String, String>>[
    {
      'title': 'Disciplinary violation',
      'date': '01 Aug 2023',
      'amount': 'PKR 100.00',
    },
  ].obs; // Make it observable

  StudentDetailsScreen({
    super.key,
    required this.studentRollNo,
    required this.studentName,
    required this.studentSemeter,
    required this.studentDepartment,
    required this.studentBatch,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Student Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Student Name Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              studentName,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'ID: $studentRollNo',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Section Title
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Academic Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Academic Information Table
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      // Table Header
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[700],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Field',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Details',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Table Rows
                      _buildTableRow('Department', studentDepartment),
                      _buildDivider(),
                      _buildTableRow('Semester', studentSemeter),
                      _buildDivider(),
                      _buildTableRow('Batch', studentBatch),
                      _buildDivider(),
                      _buildTableRow('Roll Number', studentRollNo),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Fine History Section (Now dynamic)
              _buildFineHistorySection(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build table rows
  Widget _buildTableRow(String field, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              field,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build dividers between table rows
  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, color: Colors.grey[200]);
  }

  // Fine History Section with dynamic list
  Widget _buildFineHistorySection() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),

          // Section Title with fine count
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Text(
                  'Fine History',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // Fine History Card
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: finesList.isEmpty
                ? _buildEmptyFinesState()
                : Column(
                    children: [
                      // Fine Items
                      ...finesList.asMap().entries.map((entry) {
                        final index = entry.key;
                        final fine = entry.value;
                        return Column(
                          children: [
                            _buildFineItem(
                              title: fine['title'] ?? 'No Title',
                              date: fine['date'] ?? 'Unknown Date',
                              amount: fine['amount'] ?? 'PKR 0',
                              onDelete: () => _removeFine(index),
                            ),
                            if (index < finesList.length - 1) _buildDivider(),
                          ],
                        );
                      }),

                      // Total and Assign Fine Section
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // Total Fine
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Fine',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Text(
                                  _calculateTotalFine(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[700],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 15),

                            // Assign Fine Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _showAssignFineDialog,
                                icon: const Icon(Icons.add_circle_outline),
                                label: const Text('Assign Fine'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[700],
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
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
    );
  }

  // Empty state for no fines
  Widget _buildEmptyFinesState() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Icon(Icons.money_off, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No Fines Assigned',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Assign fines to track student penalties',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Helper method to build individual fine items with delete option
  Widget _buildFineItem({
    required String title,
    required String date,
    required String amount,
    required VoidCallback onDelete,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon with number
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.red[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              size: 20,
              color: Colors.red[600],
            ),
          ),

          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // Amount and Delete Button
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                ),
              ),
              const SizedBox(height: 4),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: Colors.grey[500],
                ),
                onPressed: onDelete,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Calculate total fine amount
  String _calculateTotalFine() {
    double total = 0;
    for (var fine in finesList) {
      String amount = fine['amount'] ?? 'PKR 0';
      amount = amount.replaceAll('PKR', '').replaceAll(',', '').trim();
      total += double.tryParse(amount) ?? 0;
    }
    return 'PKR ${total.toStringAsFixed(2)}';
  }

  // Remove fine from list
  void _removeFine(int index) {
    if (index >= 0 && index < finesList.length) {
      finesList.removeAt(index);
      // Force UI update since we're using Obx
      finesList.refresh();
    }
  }

  // Add new fine to list
  void _addFine(String title, String amount) {
    final newFine = {
      'title': title,
      'date': _getCurrentDate(),
      'amount': 'PKR $amount',
    };
    finesList.add(newFine);
    finesList.refresh(); // Force UI update
  }

  // Get current date in formatted string
  String _getCurrentDate() {
    final now = DateTime.now();
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }

  void _showAssignFineDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    Get.defaultDialog(
      title: 'Assign New Fine',
      titleStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Fine Title',
              hintText: 'e.g L/A .....',
              prefixIcon: const Icon(Icons.description, color: Colors.blue),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Fine Amount (PKR)',
              hintText: 'e.g., 500',
              prefixIcon: const Icon(Icons.attach_money, color: Colors.green),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green.shade400, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
      textCancel: 'Cancel',
      cancelTextColor: Colors.grey.shade700,
      textConfirm: 'Assign Fine',
      confirmTextColor: Colors.white,
      buttonColor: Colors.blue.shade600,
      radius: 15,
      onCancel: () {
        titleController.dispose();
        amountController.dispose();
        Get.back();
      },
      onConfirm: () {
        final fineTitle = titleController.text.trim();
        final fineAmount = amountController.text.trim();

        if (fineTitle.isEmpty || fineAmount.isEmpty) {
          Get.snackbar(
            'Error',
            'Please fill in all fields',
            backgroundColor: Colors.red.shade400,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }

        if (double.tryParse(fineAmount) == null) {
          Get.snackbar(
            'Invalid Amount',
            'Please enter a valid number for fine amount',
            backgroundColor: Colors.orange.shade400,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }

        // Add the fine to the list
        _addFine(fineTitle, fineAmount);

        titleController.dispose();
        amountController.dispose();

        Get.back(); // close dialog

        Get.snackbar(
          'Fine Assigned',
          'Fine "$fineTitle" of PKR $fineAmount assigned successfully',
          backgroundColor: Colors.green.shade400,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }
}
