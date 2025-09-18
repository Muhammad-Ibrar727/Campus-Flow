import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student_model.dart';

class StudentRepository {
  final _students = FirebaseFirestore.instance.collection('students');

  Future<void> addStudent(StudentModel student) async {
    await _students.add(student.toMap());
  }

  Stream<List<StudentModel>> getStudents() {
    return _students.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => StudentModel.fromMap(doc.data(), doc.id))
          .toList(),
    );
  }

  Future<void> deleteStudent(String id) async {
    await _students.doc(id).delete();
  }
}
