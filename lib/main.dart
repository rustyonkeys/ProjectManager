import 'package:flutter/material.dart';
import 'package:taskmanager/pages/drawer.dart';
import 'package:taskmanager/pages/homepage.dart';
import 'package:taskmanager/pages/todolist.dart';
// import 'package:taskmanager/pages/todolist.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(primarySwatch: Colors.amber),
      home: FrontPage(),
    );
  }
}
