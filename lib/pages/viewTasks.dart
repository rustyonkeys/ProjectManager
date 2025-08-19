import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager/util/circular_linear_graph.dart';

class ViewTasks extends StatelessWidget {
  final String taskID;
  const ViewTasks({super.key, required this.taskID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Details", style: GoogleFonts.bebasNeue(fontSize: 24)),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('tasks').doc(taskID).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text("Error loading task"));
          if (!snapshot.hasData || !snapshot.data!.exists) return const Center(child: CircularProgressIndicator());

          final taskData = snapshot.data!.data() as Map<String, dynamic>;
          final title = taskData['title'] ?? 'No Title';
          final description = taskData['description'] ?? 'No Description';
          final subtasks = List<Map<String, dynamic>>.from(taskData['subtasks'] ?? []);

          // Calculate completion percentage
          final int total = subtasks.length;
          final int done = subtasks.where((task) => task['isDone'] == true).length;
          final double progress = total > 0 ? done / total : 0.0;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    height: 230,
                    width: double.infinity,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularGraph(percent: progress),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              title,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.bebasNeue(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  description,
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
                const SizedBox(height: 20),
                Text(
                  "Subtasks",
                  style: GoogleFonts.bebasNeue(color: Colors.black, fontSize: 24),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: subtasks.length,
                    itemBuilder: (context, index) {
                      final subtask = subtasks[index];
                      final isDone = subtask['isDone'] ?? false;
                      final subtaskTitle = subtask['title'] ?? '';
                      final isLast = index == subtasks.length - 1;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                Container(width: 2, height: 50, color: Colors.grey),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isDone,
                                    activeColor: Colors.green,
                                    onChanged: (newValue) async {
                                      final updatedSubtasks = List<Map<String, dynamic>>.from(subtasks);
                                      updatedSubtasks[index]['isDone'] = newValue;

                                      await FirebaseFirestore.instance
                                          .collection('tasks')
                                          .doc(taskID)
                                          .update({'subtasks': updatedSubtasks});
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      subtaskTitle,
                                      style: TextStyle(
                                        color: isDone ? Colors.greenAccent : Colors.white70,
                                        fontSize: 16,
                                        decoration: isDone ? TextDecoration.lineThrough : null,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Add another subtask"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final shouldDelete = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.black,
                            title: const Text("Project Deleted", style: TextStyle(color: Colors.grey)),
                            content: const Text("Are you sure you want to delete this project?", style: TextStyle(color: Colors.grey)),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: const Text("Delete", style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                        if (shouldDelete == true) {
                          await FirebaseFirestore.instance.collection('tasks').doc(taskID).delete();
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Delete task"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
