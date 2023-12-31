import 'dart:core';

import 'package:flutter/foundation.dart';

import 'Course.dart';
import 'User.dart';

class Student extends User {
  // Private attributes
  late String _year;
  late String _college;
  late String _major;
  late String _university;
  late List<Course> _registeredCourses;

  // Constructor with named parameters
  Student({
    required super.name,
    required super.ID,
    required super.age,
    required super.phonenum,
    required super.email,
    required super.password,
    required String year, // Change from String to int
    required String college,
    required String major,
    required String university,
  }) {
    _year = year;
    _college = college;
    _major = major;
    _university = university;
    _registeredCourses = []; // Initialize the list
  }


  // Getters and setters for private attributes
  // Getters and setters for private attributes
  String get year => _year;
  set year(String value) => _year = value;

  String get college => _college;
  set college(String value) => _college = value;

  String get major => _major;
  set major(String value) => _major = value;

  // Date get bdate => _bdate;
  // set bdate(Date value) => _bdate = value;

  String get university => _university;
  set university(String value) => _university = value;

  List<Course> get registeredCourses => _registeredCourses;
  set registeredCourses(List<Course> value) => _registeredCourses = value;

  // Function to register a course
  void registerCourse(Course course) {
    if (!_registeredCourses.contains(course)) {
      _registeredCourses.add(course);
      if (kDebugMode) {
        print("Course registered successfully");
      }
    } else {
      if (kDebugMode) {
        print("You are already registered for this course");
      }
    }
  }

  // Function to unregister a course
  void unregisterCourse(Course course) {
    if (_registeredCourses.contains(course)) {
      _registeredCourses.remove(course);
      print("Course unregistered successfully");
    } else {
      print("Course not found in your registered courses");
    }
  }

  // Function to check if a course is already registered
  bool isCourseRegistered(Course course) {
    return _registeredCourses.contains(course);
  }

  // Function to view grades
  // void viewGrades() {
  //   print("Your Grades:");
  //   for (var course in _registeredCourses) {
  //     // Logic to retrieve and display grades, e.g., fetch from database
  //     print("${course.courseName} - Grade: A");
  //   }
  // }

  // Function to view registered courses
  void viewRegisteredCourses() {
    if (kDebugMode) {
      print("Registered Courses:");
    }
    for (var course in _registeredCourses) {
      if (kDebugMode) {
        print(course.courseName);
      }
    }
  }

  // Function to check if a course is registered
  bool isCourseFollowed(String courseId) {
    return registeredCourses.any((course) => course.courseID == courseId);
  }

  // function to remove a course from the registered courses
  void removeCourse(String courseId) {

    if(isCourseFollowed(courseId)){
    registeredCourses.removeWhere((course) => course.courseID == courseId);
    }
    else{
      if (kDebugMode) {
        print("Course not found in your registered courses");
      }
    }
  }

  String generateNextID() {
    int nextID = int.parse(students.last.ID.substring(1)) + 1; // substring(1): This removes the first character of the student's ID. For example, "S001" becomes "001"
    return "S${nextID.toString().padLeft(3, '0')}";
  }
}

// Student 1
Student studentJohn = Student(
  name: "John Doe",
  ID: "S001",
  age: 20,
  phonenum: "123-456-7890",
  email: "john.doe@example.com",
  password: "john123",
  year: "Sophomore",
  college: "Engineering",
  major: "Mechatronics",
  university: "XYZ University",
);

// Student 2
Student studentJane = Student(
  name: "Jane Doe",
  ID: "S002",
  age: 20,
  phonenum: "123-456-7890",
  email: "jane.doe@example.com",
  password: "jane123",
  year: "Sophomore",
  college: "Engineering",
  major: "Medicine",
  university: "XYZ University",
);

// Student 3
Student studentJack = Student(
  name: "Jack Doe",
  ID: "S003",
  age: 20,
  phonenum: "123-456-7890",
  email: "jack.doe@example.com",
  password: "jack123",
  year: "Sophomore",
  college: "Engineering",
  major: "Business",
  university: "XYZ University",
);

// Student 4
Student studentOmar = Student(
  name: "Omar Doe",
  ID: "S004",
  age: 20,
  phonenum: "123-456-7890",
  email: "omar.doe@example.com",
  password: "omar123",
  year: "Junior",
  college: "Engineering",
  major: "Computer Science",
  university: "XYZ University",
);

// Student 5
Student studentFadel = Student(
  name: "Fadel Doe",
  ID: "S005",
  age: 20,
  phonenum: "123-456-7890",
  email: "fadel.doe@example.com",
  password: "fadel123",
  year: "Freshman",
  college: "Engineering",
  major: "Computer Science",
  university: "XYZ University",
);

// Student 6
Student studentKarim = Student(
  name: "Karim Doe",
  ID: "S006",
  age: 20,
  phonenum: "123-456-7890",
  email: "Karim.doe@example.com",
  password: "Karim123",
  year: "Senior 1",
  college: "Engineering",
  major: "Computer Science",
  university: "XYZ University",
);

// Student 7
Student studentEsmat = Student(
  name: "Esmat Doe",
  ID: "S007",
  age: 20,
  phonenum: "123-456-7890",
  email: "esmat.doe@example.com",
  password: "esmat123",
  year: "Senior 2",
  college: "Engineering",
  major: "Computer Science",
  university: "XYZ University",
);

// Student 8
Student studentYoussef = Student(
  name: "Youssef Doe",
  ID: "S008",
  age: 20,
  phonenum: "123-456-7890",
  email: "youssef.doe@example.com",
  password: "youssef123",
  year: "Senior 2",
  college: "Engineering",
  major: "Computer Science",
  university: "XYZ University",
);

List<Student> students = [
  studentJohn,
  studentJane,
  studentJack,
  studentOmar,
  studentFadel,
  studentKarim,
  studentEsmat,
  studentYoussef,
];
