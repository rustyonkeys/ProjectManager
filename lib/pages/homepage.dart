import "package:flutter/material.dart";
import "package:taskmanager/pages/drawer.dart";

class FrontPage extends StatelessWidget {
   FrontPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: DrawerWidget(),
      body: CustomScrollView(     // // ✅ Always wrap body in SafeArea to avoid notch overlaps
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.menu,
            color: Colors.black),
            onPressed: () {
              _scaffoldkey.currentState?.openDrawer();
            },),
            title: Text("Welcome to TaskManager",
            style: TextStyle(color: Colors.black),),
            expandedHeight: 300,
            backgroundColor: Color(0xFFF1F1EF),
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 80, left:20),
                child: Text("Manage Your Tasks!!",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
              ),
            ),
          ),
          //sliver items
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                child: Container(
                  child: Text("To Do Tasks",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20, left: 25, right: 25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Color(0xffF1F1EF),
                  height: 200,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.deepPurple[300],
                  height: 200,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.deepPurple[300],
                  height: 400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
