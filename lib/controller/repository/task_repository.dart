import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarefas/models/task.dart';
import 'package:tarefas/database/db_firestore.dart';

class TasksRepository {
  FirebaseFirestore db = DBFirestore.get();



void addTask(Task task) async {


  await db.collection('Tarefa').add({
    'name': task.name,
    'priority': task.priorityToString(),
    'description': task.description,
    'date': task.date,
    'isDone': task.isDone
  })
  ;
}

void editTask(Task task, String id) async {
  await db.collection('Tarefa').doc(id).update({
    'name': task.name,
    'priority': task.priorityToString(),
    'description': task.description,
    'date': task.date,
    'isDone': task.isDone
  });
}

void deleteTask(String id) async {
  await db.collection('Tarefa').doc(id).delete();
}


getTask() async {

  var db = await FirebaseFirestore.instance.collection('tarefa').snapshots();
  //var docRef = await  db.get();
  return db;
}}
