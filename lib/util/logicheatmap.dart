import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:taskmanager/services/Firebase.dart';

class HeatmapWidget extends StatelessWidget {
  final FirestoneServices _firebaseService = FirestoneServices();

  HeatmapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _firebaseService.getAllSubtasks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final subtasks = snapshot.data!;
        Map<DateTime, int> completionData = {};

        for (var subtask in subtasks) {
          if (subtask['completedAt'] != null) {
            DateTime date = DateTime.parse(subtask['completedAt']);
            DateTime day = DateTime(date.year, date.month, date.day);

            completionData[day] = (completionData[day] ?? 0) + 1;
          }
        }

        return Padding(
          padding: const EdgeInsets.all(12),
          child: HeatMap(
            datasets: completionData,
            colorMode: ColorMode.opacity,
            defaultColor: Colors.grey[300]!,
            textColor: Colors.black,
            showColorTip: true,
            scrollable: true,
            startDate: DateTime(DateTime.now().year, 1, 1),
            endDate: DateTime(DateTime.now().year, 12, 31),
            colorsets: const {
              1: Colors.lightGreen,
              2: Colors.green,
              3: Colors.greenAccent,
              4: Colors.teal,
            },
            onClick: (date) {
              debugPrint("Clicked on $date with ${completionData[date] ?? 0} completions");
            },
          ),
        );
      },
    );
  }
}
