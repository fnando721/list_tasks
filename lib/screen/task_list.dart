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
  final Stream<QuerySnapshot> _tarefaStream =
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
      endDrawer: Container(),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: StreamBuilder<QuerySnapshot>(
          stream: _tarefaStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: SizedBox(
                      child: Text(
                'Erro ao buscar usuário!',
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
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                Timestamp t = data['dtconclusao'];
                Task task = Task(data['nome'], 'categoria', data['descricao'],
                    t.toDate(), data['estaFeito']);
                print(task.nome);
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailTask(task: task)));
                    },
                    child: Container(
                      width: size.width * 0.8,
                      height: size.height * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 10.0,
                              offset: Offset(0.0, 0.75))
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: size.width * 0.8,
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.label_important,
                                            color: Colors.amber,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all( 8),
                                            child: Text(
                                              task.nome,
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      task.descricao,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width * 0.03,
                            height: size.height * 0.03,
                            child: CircleAvatar(
                              backgroundColor:  task.estaFeito? Colors.green: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
