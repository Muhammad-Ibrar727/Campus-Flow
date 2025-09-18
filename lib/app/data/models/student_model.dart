class StudentModel {
  final String id;
  final String name;
  final String rollNumber;
  final String department;
  final String batch;
  final String semester;

  StudentModel({
    required this.id,
    required this.name,
    required this.rollNumber,
    required this.department,
    required this.batch,
    required this.semester,
  });

  factory StudentModel.fromMap(Map<String, dynamic> data, String documentId) {
    return StudentModel(
      id: documentId,
      name: data['name'] ?? '',
      rollNumber: data['roll_number'] ?? '',
      department: data['department'] ?? '',
      batch: data['session'] ?? '',
      semester: data['semester']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rollNumber': rollNumber,
      'department': department,
      'batch': batch,
      'semester': semester,
    };
  }
}
