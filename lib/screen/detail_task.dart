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
        title: Text(
          'Detalhes da Tarefa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Container(
          width: size.width,
          height: size.height ,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.03,
              ),
              Text('Titulo', style: TextStyle(fontSize: 16),),
              TextFormField(
                //controller: ,
                decoration: textFieldsDetailsDecoration('Nome do Titulo'),
              ),

              Container(
                height: 100,
                child: TextFormField(
                  //controller: ,
                  decoration: textFieldsDetailsDecoration('Descrição'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
