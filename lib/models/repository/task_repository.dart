import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarefas/dao/firestore.dart';
import 'package:tarefas/models/tasks.dart';

void addTask(Task task) {
  CollectionReference db = FirebaseFirestore.instance.collection('Tarefa');
  String id;

  db.add({
    'nome': task.nome,
    'descricao': task.descricao,
    'dtconclusao': task.dtConclusao,
    'estaFeito': task.estaFeito
  }).then((DocumentReference doc){
    id  = doc.id;
    print(id);
  });

}

void editTask(Task task) async {
  FirebaseFirestore db = DBFirestore.get();
  await db.collection('Tarefa').doc('Tarefa').update({
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
