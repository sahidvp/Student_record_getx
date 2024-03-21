import 'dart:io';
import 'package:flutter/material.dart';

class StudentProfile extends StatelessWidget {
  final String name;
  final String age;
  final String std;
  final String place;
  final String image;

  const StudentProfile({
    Key? key,
    required this.name,
    required this.age,
    required this.std,
    required this.place,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    Widget imageWidget = image != null
        ? ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.file(
                File(image),
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
          )
        : Container();

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            imageWidget,
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: 4,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return ListTile(
                        title: Text(
                          'Name : $name',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    case 1:
                      return ListTile(
                        title: Text(
                          'Age : $age',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    case 2:
                      return ListTile(
                        title: Text(
                          'Grade : $std',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    case 3:
                      return ListTile(
                        title: Text(
                          'Place : $place',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    default:
                      return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}