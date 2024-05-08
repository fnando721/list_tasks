import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarefas/models/task.dart';
import 'package:tarefas/database/db_firestore.dart';

import '../../services/auth_service.dart';

class TasksRepository {
  AuthService authService = AuthService();
  FirebaseFirestore db = DBFirestore.get();

@override
Future<void> addTask(Task task) async {


  // var docRef = await db.collection('Tarefa').doc(authService.user!.uid)
  // .set({
  //   'nome': task.nome,
  //   'descricao': task.descricao,
  //   'dtconclusao': task.dtConclusao,
  //   'estaFeito': task.estaFeito
  // })

  await db.collection('Tarefa').add({
    'name': task.name,
    'priority': task.priorityToString(),
    'description': task.description,
    'date': task.date,
    'isDone': task.isDone
  })
  ;

  var tarefa = await db.collection('tarefa').get();
  print(tarefa.toString());
}

void editTask(Task task) async {

  await db.collection('tarefa').doc('tarefa').update({
    'nome': task.name,
    'descricao': task.description,
    'dtconclusao': task.date,
  });
}

getTask() async {

  var db = await FirebaseFirestore.instance.collection('tarefa').snapshots();
  //var docRef = await  db.get();
  return db;
}}
