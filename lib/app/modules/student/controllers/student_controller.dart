import 'package:get/get.dart';
import '../../../data/models/student_model.dart';
import '../../../data/repositories/student_repository.dart';

class StudentController extends GetxController {
  final StudentRepository _repository = StudentRepository();

  var students = <StudentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    students.bindStream(_repository.getStudents());
  }

  void addStudent(StudentModel student) {
    _repository.addStudent(student);
  }

  void deleteStudent(String id) {
    _repository.deleteStudent(id);
  }
}
