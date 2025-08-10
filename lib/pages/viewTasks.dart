import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewTasks extends StatelessWidget {
  final String taskID;
  const ViewTasks({
    super.key,
    required this.taskID,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Details", style: GoogleFonts.bebasNeue(fontSize: 24)),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .doc(taskID)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading task"));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final taskData = snapshot.data!.data() as Map<String, dynamic>;
          final title = taskData['title'] ?? 'No Title';
          final description = taskData['description'] ?? 'No Description';
          final subtasks = List<String>.from(taskData['subtasks'] ?? []);

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.bebasNeue(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Subtasks",
                  style: GoogleFonts.bebasNeue(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: subtasks.length,
                    itemBuilder: (context, index) {
                      final subtask = subtasks[index];
                      final isLast = index == subtasks.length - 1;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Timeline column (bullet + line)
                          Column(
                            children: [
                              Container(
                                width: 12,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              if (!isLast)
                                Container(
                                  width: 2,
                                  height: 50,
                                  color: Colors.grey,
                                ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          // Subtask card
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                subtask,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                Center(
                  child: ElevatedButton(onPressed: () {},
                      child: Text("Add another subtask",
                      style: TextStyle(
                        color: Colors.grey[900]
                      ),)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
