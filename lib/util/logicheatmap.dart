import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

Widget buildHeatmap(List<Map<String, dynamic>> subtasks) {
  Map<DateTime, int> completionData = {};

  for (var subtask in subtasks) {
    if (subtask['completedAt'] != null) {
      DateTime date = DateTime.parse(subtask['completedAt']);
      DateTime day = DateTime(date.year, date.month, date.day);

      completionData[day] = (completionData[day] ?? 0) + 1;
    }
  }

  return HeatMap(
    datasets: completionData,
    colorMode: ColorMode.opacity,
    defaultColor: Colors.grey[300]!,
    textColor: Colors.black,
    showColorTip: true,
    scrollable: true,
    colorsets: const {
      1: Colors.lightGreen,
      2: Colors.green,
      3: Colors.greenAccent,
      4: Colors.teal,
    },
    onClick: (date) {
      print("Clicked on $date with ${completionData[date] ?? 0} completions");
    },
  );
}
