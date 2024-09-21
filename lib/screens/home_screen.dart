// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_details_getx/db/student_db.dart';
import 'package:student_details_getx/screens/add_student.dart';
import 'package:student_details_getx/screens/search_screen.dart';
import 'package:student_details_getx/screens/view_student.dart';
import 'package:student_details_getx/widgets/student_list_widget.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {

  @override
  void initState() {
    super.initState();
    StudentDbFunctions.getStudentDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.yellow,
            child: Icon(Icons.add),
            onPressed: () {
              Get.to(ScreenAddStudent(
                addOrUpdate: 'Add Student',
                heading: 'Add Student Details',
              ));
            }),
        appBar: AppBar(
          backgroundColor: Colors.yellow[300],
          title: Text(
            'Student Details',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () => Get.to(ScreenSearch()),
                child: Icon(Icons.search)),
            )
          ],
        ),
        //! body
        body: studentListNotifier.value.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ValueListenableBuilder(
                  valueListenable: studentListNotifier,
                  builder: (context, studentList, child) {
                    return ListView.builder(
                        itemCount: studentList.length,
                        itemBuilder: (context, index) {
                          //data
                          final data = studentList[index];
                          return InkWell(
                              onTap: () => Get.to(ScreenViewStudent(
                                imagePath: data.image,
                                  name: data.name,
                                  age: data.age,
                                  classs: data.classs,
                                  gender: data.gender)),
                              child: StudentListWidget(
                                name: data.name,
                                gender: data.gender,
                                id: data.key,
                                imagePath: data.image,
                                age: data.age,
                                classs: data.classs,
                              ));
                        });
                  },
                ))
            : Center(
                child: Text("NO STUDENT DATA"),
              ));
  }
}
