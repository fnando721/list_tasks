import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tarefas/models/repository/task_repository.dart';
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
      FirebaseFirestore.instance.collection('tarefa').snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Minhas Tarefas',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  getTask();
                });
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.blueGrey,
        child: SafeArea(
          bottom: true,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: SizedBox(
                    width: size.width * 0.7,
                    height: size.height * 0.07,

                    child: const TextField(
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search), hintText: 'Pesquisar'),
                    ),
                  ),
                ),



                SizedBox(
                  width: size.width,
                  height: size.height * 0.8,

                  child: StreamBuilder<QuerySnapshot>(
                    stream: _tarefaStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {


                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: Column(
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
                          Task task = Task(data['nome'], 'categoria', data['descricao'], t.toDate(), data['estaFeito']);

                          return Padding(
                            padding: const EdgeInsets.all(6),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)
                              ),

                              child: GestureDetector(
                                onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailTask(task: task),
                                      ),
                                    );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Icon(Icons.circle,
                                          size: 12,
                                          color: data['estaFeito']
                                              ? Colors.green
                                              : DateTime.now() == task.dtConclusao
                                                  ? Colors.amber
                                                  : Colors.red),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.8,
                                            child: Text(
                                              task.nome,
                                              style: const TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          SizedBox(
                                            child: Text(
                                                'Data Conclusão: ${task.dtConclusao.day}/${task.dtConclusao.month}/${task.dtConclusao.year}',
                                                style: const TextStyle(fontSize: 12)),
                                          )
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.delete),
                                    ),
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
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTask(),
            ),
          );
        },
        child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
      ),
    );
  }
}
