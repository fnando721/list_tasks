import 'dart:convert';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarefas/dao/firestore.dart';
import 'package:tarefas/models/tasks.dart';

void addTask(Task task) async {
  FirebaseFirestore db = DBFirestore.get();

  var docRef = await db.collection('tarefa').add({
    'nome': task.nome,
    'descricao': task.descricao,
    'dtconclusao': task.dtConclusao,
    'estaFeito': task.estaFeito
  });

  var tarefa = await db.collection('tarefa').get();
  print(tarefa.toString());
}

void editTask(Task task) async {
  FirebaseFirestore db = DBFirestore.get();
  await db.collection('tarefa').doc('tarefa').update({
    'nome': task.nome,
    'descricao': task.descricao,
    'dtconclusao': task.dtConclusao,
  });
}

 getTask() async {
   var db = await FirebaseFirestore.instance.collection('tarefa').snapshots();
   //var docRef = await  db.get();
   return db;


}
