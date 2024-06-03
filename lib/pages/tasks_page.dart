import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tarefas/models/task.dart';
import '../controller/task_controller.dart';
import 'add_task_page.dart';
import 'detail_task_page.dart';
import 'login_page.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  TaskController taskController = TaskController();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final Stream<QuerySnapshot> tarefaStream = FirebaseFirestore.instance
        .collection('Tarefa')
        .where('isDone', isEqualTo: false)
        .orderBy('date')
        .snapshots();

    bool dataDiferente = true;
    DateTime destaque = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: Text('A'),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTaskPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              )),
          IconButton(
            onPressed: () {
              taskController.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            icon: const Icon(
              Icons.exit_to_app_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: Drawer(),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: StreamBuilder<QuerySnapshot>(
          stream: tarefaStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text(
                    'Tente Novamente!',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("Carregando tarefas"),
                    ],
                  ));
            }

            if (snapshot.data!.docs.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: SvgPicture.network(
                        'https://www.svgrepo.com/show/310081/task-list-add.svg'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Adicione uma Atividade!",
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                ],
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                String id = document.id;
                Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;


                Timestamp t = data['date'];
                Task task = Task(
                  name: data['name'],
                  priority: Task.stringToPriority(data['priority']),
                  description: data['description'],
                  date: t.toDate(),
                  isDone: data['isDone'],
                );

                dataDiferente = destaque != task.date ? true : false;
                destaque = task.date;

                return Expanded(
                  child: Column(
                    children: [
                      dataDiferente
                          ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Center(
                                child: Text(DateFormat('dd/MM/yyyy')
                                    .format(task.date)
                                    .toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),),
                              ),
                            ),
                          ))
                          : SizedBox(),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailTaskPage(id: id, task: task)));
                          },
                          child: Container(
                            width: size.width,
                            height: size.height / 7,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 0.75))
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        width: size.width * 0.8,
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.label_important,
                                              color: taskController
                                                  .colorPriority(task.priority),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: size.width * 0.6,
                                                    child: Text(
                                                      task.name,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.74,
                                        height: size.height * 0.075,
                                        child: Text(
                                          task.description,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                  height: size.height * 0.03,
                                  child: CircleAvatar(
                                    backgroundColor: task.isDone
                                        ? Colors.green
                                        : task.date == DateTime.now()
                                        ? Colors.amber
                                        : Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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