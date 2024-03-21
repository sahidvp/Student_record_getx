import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:student_m_getx/controller/controller.dart';

// ignore: must_be_immutable
class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});

  TextEditingController searchCont = TextEditingController();
  final controller = Get.find<ScreenController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: searchCont,
        onChanged: (value) async {
          await controller.searchStudent(value);
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          label: Text('Search...'),
        ),
      ),
    );
  }
}