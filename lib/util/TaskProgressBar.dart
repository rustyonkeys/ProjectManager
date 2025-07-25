import 'package:flutter/material.dart';


class TaskProgressBar extends StatelessWidget {
  final int totalTask;
  final int totalCompletedTask;


  TaskProgressBar({
    super.key,
    required this.totalTask,
    required this.totalCompletedTask});

  @override
  Widget build(BuildContext context) {
    double progress = totalTask == 0 ? 0 : totalCompletedTask/totalTask;
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Container(
        child: Row(
          children: [
            Expanded(
              child:LinearProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation(Colors.black),
                value: progress,
                minHeight: 10,
              ),),
            SizedBox(width: 10,),
            Text(
              "$totalCompletedTask/$totalTask",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
