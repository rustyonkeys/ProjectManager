import "package:flutter/material.dart";
import "package:taskmanager/pages/drawer.dart";
import 'package:taskmanager/pages/viewTasks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FrontPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: DrawerWidget(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                _scaffoldkey.currentState?.openDrawer();
              },
            ),
            title: Text(
              "Welcome to TaskManager",
              style: GoogleFonts.bebasNeue(color: Colors.white),
            ),
            expandedHeight: 250,
            backgroundColor: Colors.black54,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.black87,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Text(
                  "Manage Your Tasks!!",
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                child: Container(
                  child: Text(
                    "To Do Tasks",
                    style: GoogleFonts.bebasNeue(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('tasks')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text('Error loading tasks')),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final tasks = snapshot.data!.docs;

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final data = tasks[index].data() as Map<String, dynamic>;
                    final title = data['title'] ?? 'No Title';
                    final description = data['description'] ?? '';

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.black,
                          height: 150,
                          child: Row(
                            children: [
                              SizedBox(width: 50),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      title,
                                      style: GoogleFonts.bebasNeue(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      description,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed:() {Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewTasks(taskID: tasks[index].id)),
                                );
                                  },
                                icon: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: tasks.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
