import 'package:flutter/material.dart';
import 'package:tarefas/components/textFieldsDetailsDecoration.dart';
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
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Detalhes da Tarefa',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white
            )),

      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Column(
          children: [
            Text(
              'Titulo: ',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                child: TextFormField(
                 // controller: ,//nomeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite o nome da tarefa';
                    }
                    return null;
                  },

                  decoration: textFieldsDetailsDecoration(),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
