import 'package:flutter/material.dart';
import 'package:tarefas/models/task.dart';
import '../components/DateTimePickerCustom.dart';
import '../components/TextFormFieldCustom.dart';

class DetailTask extends StatefulWidget {
  DetailTask({super.key, required this.task});

  Task task;

  @override
  State<DetailTask> createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  bool estaFeito = false;

  @override
  Widget build(BuildContext context) {
    final _nameController =
        TextEditingController(text: widget.task.name.toString());
    final _descriptionController =
        TextEditingController(text: widget.task.description.toString());
    final _dateController =
        TextEditingController(text: widget.task.date.toString());
    final _formKey = GlobalKey<FormState>();

    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(() {
          FocusScope.of(context).requestFocus(FocusNode());
        });
      },
      child: Scaffold(
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
        body: Form(
          key: _formKey,
          child: Center(
            child: Container(
              width: size.width * 0.9,
              height: size.height,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Titulo',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: size.width,
                        child: TextFormFieldCustom(
                            title: 'Titulo',
                            controller: _nameController,
                            msgError: 'Digite o nome da tarefa',
                            maxLines: null),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Descrição',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.2,
                        child: TextFormFieldCustom(
                            title: 'Descrição',
                            controller: _descriptionController,
                            msgError: null,
                            maxLines: 10),
                      ),

                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Data',
                        style: TextStyle(fontSize: 16),
                      ),
                      DateTimePickerCustom(title: 'Data de Entrega',controller: _dateController),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Center(
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Switch(
                                value: estaFeito,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    estaFeito = newValue;
                                  });
                                },
                              ),
                              const Text(
                                'Atividade concluida?',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
