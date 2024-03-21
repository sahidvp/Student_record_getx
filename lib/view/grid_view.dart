import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_m_getx/controller/controller.dart';
import 'package:student_m_getx/view/student_details.dart';
import 'edit_student.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          final students = Get.find<ScreenController>().allStudentList;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 2.15),
            ),
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return Card(
                margin: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentProfile(
                            name: student.name,
                            age: student.age,
                            std: student.std,
                            place: student.place,
                            image: student.image,
                          ),
                        ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 13.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: ClipOval(
                                child: Image(
                                  image: FileImage(File(student.image)),
                                fit: BoxFit.fill,
                                 width: 2 * 37, // to make the image fit within the circle avatar
                                height: 2 * 36,
                                ),
                              ),
                            ),
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                             
                              Text(
                                student.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.to(EditStudent(
                                name: student.name,
                                age: student.age,
                                std: student.std,
                                place: student.place,
                                image: student.image,
                                id: student.id ?? 0,
                              ));
                            },
                            icon: const Icon(Icons.edit),
                            iconSize: 17,
                          ),
                          IconButton(
                            onPressed: () {
                              showDeleteConfirmationDialog(context, student.id);
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            iconSize: 17,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, int? studentId) {
    Get.defaultDialog(
      title: 'Delete Student',
      middleText: 'Are you sure you want to delete this student?',
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.find<ScreenController>().deleteStudent(studentId ?? 0);
            Get.back(); // Close the dialog
            showDeleteSnackbar(); // Show a Snackbar after deletion
          },
          child: const Text('Yes'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: const Text('No'),
        ),
      ],
    );
  }

  void showDeleteSnackbar() {
    Get.snackbar(
      'Deleted',
      'Student has been deleted',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
