import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager/util/logicheatmap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.chevron_left_outlined, size: 40),
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Completion Heatmap",
            style: GoogleFonts.bebasNeue(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // 🔥 Live updates from Firestore
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('tasks')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return const Center(child: Text("No data available"));
                }

                // Collect all completed subtasks
                List<Map<String, dynamic>> allCompletedSubtasks = [];

                for (var doc in snapshot.data!.docs) {
                  final taskData = doc.data() as Map<String, dynamic>;
                  final subtasks = List<Map<String, dynamic>>.from(
                    taskData['subtasks'] ?? [],
                  );

                  for (var subtask in subtasks) {
                    if (subtask['isCompleted'] == true &&
                        subtask['completedAt'] != null) {
                      allCompletedSubtasks.add(subtask);
                    }
                  }
                }

                return buildHeatmap();
              },
            ),
          ),
        ],
      ),
    );
  }
}
