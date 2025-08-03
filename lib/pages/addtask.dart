import "package:flutter/material.dart";

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController titleController = TextEditingController();  //creating a controller for title
  final TextEditingController descriptionController = TextEditingController(); //creating a controller for description

  List<TextEditingController> subControllers = [];  //subtaskcontrolers is the name of the list where subtasks are added
  void addtask(){
    setState(() {
      subControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
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
              Text("Add your Tasks",
                style: TextStyle(color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(top:15, left: 15,right: 15),
                child: TextField(
                  controller: titleController,
                  // textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    hintText: "Add the title of your task",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10,left: 15, right: 15),
                  child: TextField(
                    controller: descriptionController,
                    maxLines: null,
                    maxLength: null,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 45),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      hintText: "Description....",
                    ),
                  ),
                ),
              SizedBox(height: 30,),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text("Add subtasks:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 23),),
                ),
              ),
              //Subtasks list
              Container(
                height: 225,
                child: ListView.builder(
                    itemCount: subControllers.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(top:9 ,left: 15 ,right: 15),
                        child: TextField(
                          controller: subControllers[index],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                            hintText: "Add a subtask ${index+1}"
                          ),
                        ),
                      );
                    }),
              ),

              SizedBox(height: 100,),
              ElevatedButton(onPressed: addtask,
                  child:Text("Add a new subtask",
                  style: TextStyle(
                    color: Colors.black
                  ),))

            ],
          ),
        ),
      ),
    );
  }
}
