import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tarefas/models/tasks.dart';
import 'package:tarefas/screen/add_task.dart';
import 'package:tarefas/screen/detail_task.dart';


class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final Stream<QuerySnapshot> _streamTask =
      FirebaseFirestore.instance.collection('Tarefa').snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: Text('F'),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTask(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              )),
        ],
      ),
      body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: StreamBuilder<QuerySnapshot>(
              stream: _streamTask,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                      child: SizedBox(
                          child: Text(
                    'Erro ao buscar Atividades!',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  )));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("Carregando tarefas"),
                    ],
                  ));
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    Timestamp t = data['dtconclusao'];
                    Task task = Task(data['nome'], 'categoria',
                        data['descricao'], t.toDate(), data['estaFeito']);

                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailTask(task: task,)));
                          },
                        child: Container(
                          width: size.width * 0.9,
                          height: size.height * 0.1,
                          decoration: BoxDecoration(
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 5,
                                    offset: Offset(0.0, 0.75)
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.only(top: 16, left: 8),
                                  child: SizedBox(
                                    width: size.width * 0.87,
                                    height: size.height * 0.1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children:<Widget> [
                                            const Icon(Icons.label_important, color: Colors.amber,),
                                            const SizedBox(width: 5,),
                                            Text(task.nome, style: const TextStyle(fontSize: 18, fontWeight:FontWeight.bold ),),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8),
                                          child: Row(
                                            children:<Widget> [

                                              Text(task.nome, style: const TextStyle(fontSize: 15),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8, right: 12),
                                  child: SizedBox(
                                    width: size.width * 0.03,
                                    height: size.height * 0.03,
                                    child: CircleAvatar(
                                      backgroundColor: task.estaFeito
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    );
                  }).toList(),
                );
              })),
    );
  }
}
