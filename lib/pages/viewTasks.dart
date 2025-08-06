import 'package:flutter/material.dart';
class ViewTasks extends StatelessWidget {
  const ViewTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View your Tasks",
      style: TextStyle(fontWeight: FontWeight.bold),),),
    );
  }
}
