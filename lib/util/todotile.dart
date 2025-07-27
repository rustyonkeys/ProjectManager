import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;


  TodoTile({super.key,
    required this.taskName,
    required this.taskCompleted,

    required this.onChanged,
    required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20,right: 20),
      //Slidable option
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(),
            children: [
              SlidableAction(onPressed: deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(10),)
            ]),
        //TextField of user input
        child: Container(
          decoration: BoxDecoration(color: Colors.purple[300],
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                //checkbox
                Checkbox(value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.black,),
                Text(taskName,
                  style: TextStyle(color: Colors.black,
                      decoration: taskCompleted? TextDecoration.lineThrough: TextDecoration.none),),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
