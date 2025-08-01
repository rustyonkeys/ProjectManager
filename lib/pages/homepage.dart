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
            color: Colors.white),
            onPressed: () {
              _scaffoldkey.currentState?.openDrawer();
            },),
            title: Text("Welcome to TaskManager",
            style: TextStyle(color: Colors.white),),
            expandedHeight: 300,
            backgroundColor: Colors.black54,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.black87,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 80, left:20),
                child: Text("Manage Your Tasks!!",
                style: TextStyle(
                  color: Colors.white,
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
                  color: Colors.black,
                  height: 150,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 70,),
                        Column(
                          children: [
                            SizedBox(height: 40,),
                          Container(
                            child: Center(
                              child: Text("Make an app",
                              style: TextStyle(color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,),),
                            ),
                          ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                            child: Text("Priority:high",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),),
                          ),
                            SizedBox(width: 36,),
                            Container(
                              child: Text("Priority:high",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                ),),
                            ),

                        ])
                          ],),
                          SizedBox(width: 20,),
                          IconButton(onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: Colors.grey,
                              ))
                      ]),],
                  ),
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
                  color: Colors.black,
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
                  height: 200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
