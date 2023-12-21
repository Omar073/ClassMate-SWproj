import 'package:ClassMate/Classes/Course.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Classes/Instructor.dart';
import '../Classes/Student.dart';
import '../Classes/User.dart';
import '../Providers/UserProvider.dart';

class CourseInfo extends StatefulWidget {
  final String courseID;
  final String courseName;
  final String courseCode;
  bool isCourseFollowed;

  CourseInfo({
    required this.courseID,
    required this.courseName,
    required this.courseCode,
    required this.isCourseFollowed,
    super.key,
  });

  @override
  State<CourseInfo> createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {
  late User user;
  @override
  Widget build(BuildContext context) {
    user = context.watch<UserProvider>().user!;
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[100],
        appBar: AppBar(
          title: Text(
            widget.courseName,
            style: const TextStyle(color: Colors.black, fontFamily: 'Poppins'),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.menu_book_outlined,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  width: width - 50,
                  height: 250,
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Center(
                            child: Text(
                              widget.courseName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                        ),
                        Text(
                          widget.courseCode,
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        if (user is! Instructor)
                          Container(
                            height: 40,
                            width: 180,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 211, 220, 230),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor:
                                    const Color.fromARGB(255, 233, 240, 255),
                                foregroundColor: Colors.black,
                              ),
                              onPressed: () async {
                                widget.isCourseFollowed = !widget.isCourseFollowed;
                                setState(() {});

                                print('Follow button pressed!');

                                print(widget.courseID);

                                if (widget.isCourseFollowed && user is Student) {
                                  try {
                                    // Find the corresponding Course object
                                    Course selectedCourse = courses.firstWhere(
                                          (course) => course.courseID == widget.courseID,
                                    );

                                    // Add the course to the student's registered course list
                                    (user as Student).registerCourse(selectedCourse);
                                  } catch (e) {

                                    print(e);
                                    // Handle the case when the course is not found
                                    print('Course not found!');
                                  }
                                }
                              },
                              child: Text(
                                widget.isCourseFollowed ? 'Unfollow' : 'Follow',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Study Material Option
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            width: 118.50713348388672,
                            height: 120.6663818359375,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xff316d86),
                            ),
                            child: const Icon(
                              Icons.book,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Study Material"),
                      ],
                    ),
                    // Instructors
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Handle the click on the Instructors option
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            width: 118.50713348388672,
                            height: 120.6663818359375,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xff79bca4),
                            ),
                            child: const Icon(
                              Icons.apartment,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Available Centers"),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
