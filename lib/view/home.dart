// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_student.dart';
import 'grid_view.dart';
import 'search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Management',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 12),
          SearchWidget(),
          const SizedBox(height: 10),
          const Expanded(child: StudentList()),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddStudent());
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}