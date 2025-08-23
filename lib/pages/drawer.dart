// you don’t have an AppBar, so you need to manually control the Scaffold to open the drawer. To do this:
// You assign a GlobalKey<ScaffoldState> to the Scaffold.
// You can then call openDrawer() on that key from anywhere in the widget tree.

import "package:flutter/material.dart";
import "package:taskmanager/pages/addtask.dart";
import "package:taskmanager/pages/graph.dart";


class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  //This creates a unique key that gives access to the ScaffoldState.
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //This attaches the key to your Scaffold.
      // key: _scaffoldkey,  //Identifies widgets; useful for tracking and accessing state.

        backgroundColor: Colors.black54,
        child: ListView(
          children: [
            DrawerHeader(
                child: Container(
                  child: Text("DrawerHeader"),
                )),
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.add,
                  color: Colors.white,),
                onPressed: () {
                  Navigator.push(
                    context,
                      MaterialPageRoute(builder: (context) => AddTask()));
                },
              ),
              title: Text("Add a task",
                style: TextStyle(color: Colors.white),),
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.auto_graph_sharp,
                  color: Colors.white,),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GraphPage(),));
                },
              ),
              title: Text("Your Progress",
                style: TextStyle(color: Colors.white),),
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.settings,
                  color: Colors.white,),
                onPressed: () {  },
              ),
              title: Text("settings",
                style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
    );
  }
}






















// import 'package:flutter/material.dart';
//
// class DrawerWidget extends StatefulWidget {
//   const DrawerWidget({super.key});
//
//   @override
//   State<DrawerWidget> createState() => _DrawerWidgetState();
// }
//
// class _DrawerWidgetState extends State<DrawerWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Drawer"),),
//       drawer: Drawer(
//         child: Container(
//           color: Colors.deepOrange,
//           child: ListView(
//             children: [
//               DrawerHeader(
//                   child: Container(
//                     child: Text("HI!!",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                     color: Colors.black),),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

