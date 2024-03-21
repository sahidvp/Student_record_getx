// ignore_for_file: must_be_immutable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_m_getx/controller/controller.dart';
import 'package:student_m_getx/model/student_model.dart';

class AddStudent extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController stdController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final controller = Get.put(ScreenController());
  final _formKey = GlobalKey<FormState>();

  AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                buildTextField(
                  controller: nameController,
                  labelText: 'Name',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    } else if (!RegExp(r'^[A-Z][A-Za-z\s]*$').hasMatch(value)) {
                          return 'Invalid name format';
                        }
                    return null;
                  },
                ),
                buildTextField(
                  controller: ageController,
                  labelText: 'Age',
                  keyboardType: TextInputType.number,
                 validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the age';
  } else if (!RegExp(r'^\d{1,2}$').hasMatch(value)) {
    return 'Invalid age';
  }
  return null;
},
                ),
                buildTextField(
                  controller: stdController,
                  labelText: 'Grade',
                  keyboardType: TextInputType.number,
                  validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the grade';
  } else if (!RegExp(r'^\d{1,2}$').hasMatch(value)) {
    return 'Invalid grade';
  }
  return null;
},

                ),
                buildTextField(
                  controller: placeController,
                  labelText: 'Place',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a place';
                }
                else if (!RegExp(r'^[A-Z][A-Za-z\s]*$').hasMatch(value)) {
                          return 'Invalid place format';
                        }
                return null;
              },
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await pickImage();
                  },
                  icon: const Icon(Icons.upload),
                  label: const Text('Upload Image'),
                ),
                const SizedBox(height: 10),
                GetBuilder<ScreenController>(
                  builder: (controller) {
                    return SizedBox(
                      width: 150,
                      height: 150,
                      child: controller.image.isEmpty
                          ? const Center(child: Text(''))
                          : Image.file(
                              File(controller.image),
                              width: 150,
                              height: 150,
                            ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (controller.image.isNotEmpty) {
                        await onAdd();
                        Get.back();
                        Get.snackbar(
                          'Success',
                          "Student Added",
                          colorText: Colors.white,
                          backgroundColor: Colors.green,
                          icon: const Icon(Icons.done),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } else {
                        Get.snackbar(
                          'Error',
                          "Please Add Image",
                          colorText: Colors.white,
                          backgroundColor: const Color.fromARGB(255, 178, 4, 4),
                          icon: const Icon(Icons.error),
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Add Student'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAdd() async {
    final newStudent = StudentModel(
      name: nameController.text,
      std: stdController.text,
      place: placeController.text,
      age: ageController.text,
      image: controller.image,
    );

    // Clearing the image field after adding the student
    controller.image = '';

    controller.addStudent(newStudent);
  }

  Future<void> pickImage() async {
    await controller.pickImage();
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    required TextInputType keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: controller,
        onChanged: (value) {},
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }
}