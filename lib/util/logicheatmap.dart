import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget buildHeatmap() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('completions').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return CircularProgressIndicator();

      Map<DateTime, int> completionData = {};

      for (var doc in snapshot.data!.docs) {
        DateTime date = (doc['date'] as Timestamp).toDate();
        DateTime day = DateTime(date.year, date.month, date.day);

        completionData[day] = (completionData[day] ?? 0) + 1;
      }

      return HeatMap(
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
      );
    },
  );
}

