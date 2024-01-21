import 'package:flutter/material.dart';
import 'package:tarefas/models/tasks.dart';

class DetailTask extends StatefulWidget {
  DetailTask({required this.task});

  Task task;

  @override
  State<DetailTask> createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes da Tarefa',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.blueGrey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Nome: ',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    widget.task.nome,
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blueGrey,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
