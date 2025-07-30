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




  //List of tasks
  //[TaskName,IsCompleted,Priority]
  List toDoList =[
    ["Make an app",true],
    ["Deploy website", false],
    ["Bring vegetables", false],
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
      toDoList.add([econtroller.text,false]);//If no option is selected then it will be automatically medium
      econtroller.clear();   // everytime new task is created old task name lies there on alert dialog box
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
        onCancel:() => Navigator.of(context).pop(),);//to remove go back to home page
        }
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple[200],
        floatingActionButton: FloatingActionButton(child:Icon(Icons.add,color: Colors.black,),onPressed: createNewTask,
          shape: CircleBorder(),
          elevation: 10,
        ),
        body:Column(
          children: [
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(onPressed: () {
                Navigator.pop(context);},
                icon: Icon(Icons.chevron_left_outlined,
                size: 40,),
              color: Colors.black,)
            ),
            SizedBox(height: 40,),
            Text("My Tasks",
            style: TextStyle(color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.bold,),),
            SizedBox(height: 10),
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

                    onChanged: (value) => checkBoxChanged(value,index),
                    deleteFunction: (context) => deleteTask(index),);
                },),
            ),
          ],
        )

    );
  }
}
