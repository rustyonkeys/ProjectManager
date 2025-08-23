import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager/services/Firebase.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final FirestoneServices firestoneServices = FirestoneServices();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<TextEditingController> subControllers = [];

  void addSubtask() {
    setState(() {
      subControllers.add(TextEditingController());
    });
  }

  void saveTask() async {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();
    List<Map<String,dynamic>> subtasks = subControllers
        .map((controller) => {
      'title': controller.text.trim(),
      'isDone': false,
    })
        .where((subtask) => (subtask['title'] as String).isNotEmpty)
        .toList();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Task title cannot be empty!")),
      );
      return;
    }

    await firestoneServices.addTask(title, description, subtasks);

    // Clear all fields after saving
    titleController.clear();
    descriptionController.clear();
    setState(() {
      subControllers.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Task Added Successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.chevron_left_outlined, size: 40),
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Add your Tasks",
                style: GoogleFonts.bebasNeue(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    hintText: "Title in not more than 3 words",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: TextField(
                  controller: descriptionController,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    hintText: "Description....",
                  ),
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    "Add subtasks:",
                    style: GoogleFonts.bebasNeue(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
              Container(
                height: 225,
                child: ListView.builder(
                  itemCount: subControllers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                      const EdgeInsets.only(top: 9, left: 15, right: 15),
                      child: TextField(
                        controller: subControllers[index],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: "Add a subtask ${index + 1}",
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: addSubtask,
                child: Text(
                  "Add a new subtask",
                  style: GoogleFonts.bebasNeue(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveTask,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding:
                    EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                child: Text(
                  "Save Task",
                  style: GoogleFonts.bebasNeue(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
