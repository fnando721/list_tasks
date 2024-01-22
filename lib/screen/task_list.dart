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
      FirebaseFirestore.instance.collection('tarefa').snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(child: Text('F'),),
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
                color: Colors.cyan,
              )),
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.blueGrey,
        child: SafeArea(
          bottom: true,
          child: Column(children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.05,
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.all(14),
                    //   child: SizedBox(
                    //     width: size.width * 0.7,
                    //     height: size.height * 0.07,
                    //     child: const TextField(
                    //       decoration: InputDecoration(
                    //           suffixIcon: Icon(Icons.search),
                    //           hintText: 'Pesquisar'),
                    //     ),
                    //   ),
                    // ),

                    const Row(
                      children: <Widget>[
                        Icon(
                          Icons.task,
                          size: 26,
                        ),
                        Text(
                          '  Minhas Atividades',
                          style: TextStyle(
                            fontSize: 26,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),


                    StreamBuilder<QuerySnapshot>(
                      stream: _tarefaStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(child: SizedBox(child: Text('Erro ao buscar usuário!', style: TextStyle(color: Colors.red, fontSize: 16),)));
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            Timestamp t = data['dtconclusao'];
                            Task task = Task(
                                data['nome'],
                                'categoria',
                                data['descricao'],
                                t.toDate(),
                                data['estaFeito']);

                            return Padding(
                              padding: const EdgeInsets.all(6),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Icon(Icons.circle,
                                            size: 12,
                                            color: data['estaFeito']
                                                ? Colors.green
                                                : DateTime.now() ==
                                                        task.dtConclusao
                                                    ? Colors.amber
                                                    : Colors.red),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: size.width * 0.8,
                                              child: Text(
                                                task.nome,
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                  'Data Conclusão: ${task.dtConclusao.day}/${task.dtConclusao.month}/${task.dtConclusao.year}',
                                                  style: const TextStyle(
                                                      fontSize: 12)),
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
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
