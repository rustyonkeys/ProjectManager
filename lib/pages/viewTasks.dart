import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:taskmanager/util/circular_linear_graph.dart';

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
                SizedBox(height: 30,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    height: 230,
                    width: double.infinity,
                    color: Colors.black,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularGraph(percent: 0.2),
                                  // CircularPercentIndicator(
                                  //     radius: 60,
                                  //   progressColor: Colors.blueGrey,
                                  //   backgroundColor: Colors.white,
                                  //   percent: 0.4  ,
                                  //   lineWidth: 6,
                                  //   animation: true,
                                  //   animateFromLastPercent: true,
                                  //   center: Text('40%',
                                  //     style: TextStyle(color: Colors.white,
                                  //         fontWeight: FontWeight.bold),),
                                  // ),
                                  SizedBox(width: 10),
                              //TITLE
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
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
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


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       ElevatedButton(onPressed: () {},
                           style: ElevatedButton.styleFrom(
                               backgroundColor: Colors.black,
                               foregroundColor: Colors.white
                           ),
                            child: Text("Add another subtask")),
                      ElevatedButton(onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white
                          ),
                          child: Text("Delete task")),
                    ],
                  ),
                SizedBox(height: 20,)
              ],
            ),
          );
        },
      ),
    );
  }
}
