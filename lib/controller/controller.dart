import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:student_m_getx/model/student_model.dart';

const String dbName = 'student_database';

class ScreenController extends GetxController {
  RxList<StudentModel> allStudentList = <StudentModel>[].obs;

  Future<void> addStudent(StudentModel data) async {
    final db = await Hive.openBox<StudentModel>(dbName);
    data.id = await db.add(data);
    db.put(data.id, data);
    await getStudents();
  }

  Future<void> editStudent(StudentModel data) async {
    final db = await Hive.openBox<StudentModel>(dbName);
    db.put(data.id, data);
    await getStudents();
  }

  Future<void> deleteStudent(int id) async {
    final db = await Hive.openBox<StudentModel>(dbName);
    await db.delete(id);
    await getStudents();
  }

  Future<List<StudentModel>> getAllData() async {
    final db = await Hive.openBox<StudentModel>(dbName);
    return db.values.toList();
  }

  Future<void> getStudents() async {
    allStudentList.clear();
    final allStudents = await getAllData();
    Future.forEach(allStudents, (element) {
      allStudentList.add(element);
    });
  }

  Future<void> searchStudent(String name) async {
    allStudentList.clear();
    final allSrudenList = await getAllData();
    Future.forEach(allSrudenList, (element) {
      if (element.name.toLowerCase().contains(name.toLowerCase())) {
        allStudentList.add(element);
      }
    });
  }

  String image = '';

  void clearImage() {
    image = '';
    update();
  }

  Future<void> pickImage() async {
    final imgFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    image = imgFile!.path;
    update();
  }
}