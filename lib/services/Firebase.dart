import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoneServices{

  // get collection of notes
  final CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  //Create: add a new note
  Future<void> addTask(String title, String description, List<Map<String, dynamic>> subtasks) async{
    await tasks.add({
      'title': title,
      'description': description,
      'subtasks': subtasks,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  //Read: get notes from database
  Stream<QuerySnapshot> getTasks() {
    return tasks.orderBy('timestamp', descending: true).snapshots();
  }

  //Update: update the notes given a doc id
  Future<void> updateTask(String docId, String title, String description, List<Map<String,dynamic>> subtasks) async{
    await tasks.doc(docId).update({
      'title': title,
      'description': description,
      'subtasks': subtasks,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  //Delete:delete notes given a doc id(if docID is deleted then the entire doc which has all the tasks will be deleted)
  Future<void> deleteTask(String docID) async{
    await tasks.doc(docID).delete();
  }

}