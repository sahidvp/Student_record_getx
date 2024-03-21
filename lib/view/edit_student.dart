// ignore_for_file: must_be_immutable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_m_getx/controller/controller.dart';
import 'package:student_m_getx/model/student_model.dart';

class EditStudent extends StatelessWidget {
  final String name;
  final String age;
  final String std;
  final String place;
  final String image;
  final int id;

  EditStudent({
    super.key,
    required this.name,
    required this.age,
    required this.std,
    required this.place,
    required this.image,
    required this.id,
  });

  TextEditingController nameCont = TextEditingController();
  TextEditingController ageCont = TextEditingController();
  TextEditingController stdCont = TextEditingController();
  TextEditingController placeCont = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final controller = Get.put(ScreenController());

  @override
  Widget build(BuildContext context) {
    nameCont.text = name;
    ageCont.text = age;
    stdCont.text = std;
    placeCont.text = place;
    controller.image = image;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Student',
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            controller.image = '';
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: nameCont,
                          onChanged: (value) {
                            formKey.currentState!.validate();
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Name'),
                          ),
                           validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                else if (!RegExp(r'^[A-Z][A-Za-z\s]*$').hasMatch(value)) {
                          return 'Invalid name format';
                        }
                return null;
              },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: ageCont,
                          onChanged: (value) {
                            formKey.currentState!.validate();
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Age'),
                          ),
                          validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the age';
  } else if (!RegExp(r'^\d{1,2}$').hasMatch(value)) {
    return 'Invalid age format';
  }
  return null;
},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: stdCont,
                          onChanged: (value) {
                            formKey.currentState!.validate();
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Grade'),
                          ),
                          validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the age';
  } else if (!RegExp(r'^\d{1,2}$').hasMatch(value)) {
    return 'Invalid age format';
  }
  return null;
},

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: placeCont,
                          onChanged: (value) {
                            formKey.currentState!.validate();
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Place'),
                          ),
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
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await controller.pickImage();
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
                            ? const Center(child: Text('No Image Uploaded'))
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
                      if (formKey.currentState!.validate() &&
                          controller.image.isNotEmpty) {
                        await onAdd();
                        Get.back();
                        Get.snackbar(
                          'Success',
                          "Data Updated",
                          colorText: Colors.white,
                          backgroundColor: Colors.blue,
                          icon: const Icon(Icons.done),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } else if (controller.image.isEmpty) {
                        Get.snackbar(
                          'Error',
                          "Please Add Image",
                          colorText: Colors.white,
                          backgroundColor: const Color.fromARGB(255, 178, 4, 4),
                          icon: const Icon(Icons.error),
                        );
                      }
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Update Student'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAdd() async {
    final data = StudentModel(
      name: nameCont.text,
      std: stdCont.text,
      place: placeCont.text,
      image: controller.image,
      age: ageCont.text,
      id: id,
    );
    await controller.editStudent(data);
  }
}