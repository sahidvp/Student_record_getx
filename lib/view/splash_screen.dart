import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_m_getx/controller/controller.dart';
import 'home.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final controller = Get.put(ScreenController());

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () async {
      await controller.getStudents();
      Get.offAll(const HomeScreen());
    });
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/sms.png'),
      ),
    );
  }
}