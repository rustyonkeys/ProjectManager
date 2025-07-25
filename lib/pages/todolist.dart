import 'package:flutter/material.dart';
import 'package:taskmanager/util/TaskProgressBar.dart';
import 'package:taskmanager/util/dialog_alertbox.dart';
import 'package:taskmanager/util/todotile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //text controller
  final econtroller = TextEditingController();
  String? _selectedPriority;


  //List of tasks
  //[TaskName,IsCompleted,Priority]
  List toDoList =[
    ["Make an app",true,"High"],
    ["Deploy website", false,"Low"],
    ["Bring vegetables", false,"Medium"],
  ];

  //checked was tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  //save new task
  void saveNewTask(){
    setState(() {
      toDoList.add([econtroller.text,false, _selectedPriority ?? "Medium"]);//If no option is selected then it will be automatically medium
      econtroller.clear();   // everytime new task is created old task name lies there on alert dialog box
      _selectedPriority = 'Medium'; //
    });
    Navigator.of(context).pop();
  }

  //delete tasks
  void deleteTask(int index){
    setState(() {
      String task = toDoList[index][0];
      toDoList.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You have completed $task"),
        backgroundColor: Colors.red,));
    });
  }


  // creating new task
  void createNewTask(){
    showDialog(context: context, builder: (context) {
      return DialogBox(
        controller: econtroller,
        onSave: saveNewTask,
        onCancel:() => Navigator.of(context).pop(),//to remove go back to home page
        selectedPriority: _selectedPriority,
        onPriorityChanged: (String? newPriority){
          setState(() {
            _selectedPriority = newPriority;
          });
        }
      );
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        floatingActionButton: FloatingActionButton(child:Icon(Icons.add,color: Colors.black,),onPressed: createNewTask,
          shape: CircleBorder(),
          elevation: 10,
        ),
        body:
        Column(
          children: [
            TaskProgressBar(
              totalTask: toDoList.length,
              totalCompletedTask: toDoList.where((task) => task[1] == true).length,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: toDoList.length,
                itemBuilder: (context, index) {
                  return TodoTile(
                    taskName: toDoList[index][0], //Name of the task
                    taskCompleted: toDoList[index][1], //task completed
                    taskpriority: toDoList[index][2], // priority
                    onChanged: (value) => checkBoxChanged(value,index),
                    deleteFunction: (context) => deleteTask(index),);
                },),
            ),
          ],
        )

    );
  }
}
