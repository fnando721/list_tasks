import 'package:flutter/material.dart';
import 'package:tarefas/components/textFieldsAddTaskDecoration.dart';
import 'package:tarefas/models/repository/task_repository.dart';
import 'package:tarefas/models/tasks.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  bool estaFeito = false;

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final firstDate = DateTime(DateTime.now().year - 120);
    final lastDate = DateTime.now();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'Adicionar Tarefa',
            style: TextStyle(fontSize: 26, color: Colors.white),
          )),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )),
          backgroundColor: Colors.blueGrey,
        ),

        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: TextFormField(
                              controller: nomeController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Digite o nome da tarefa';
                                }
                                return null;
                              },
                              decoration: textFieldsAddTaskDecoration('Nome Titulo'),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: TextFormField(
                              controller: descricaoController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Digite a descrição da tarefa';
                                }
                                return null;
                              },
                              decoration: textFieldsAddTaskDecoration('Descrição'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: TextFormField(
                              controller: dataController,
                              decoration: textFieldsAddTaskDecoration('Data Conclusão')
                            ),
                          ),



                          //  InputDatePickerFormField(
                          //    fieldHintText: 'Data Conclusão',
                          //   firstDate: firstDate,
                          //   lastDate: lastDate,
                          //   errorFormatText: 'Erro no formato do texto',
                          //   errorInvalidText: 'Erro texto invalido',
                          //   onDateSubmitted: (date) {
                          //     print(date);
                          //     setState(() {
                          //       selectedDate = date;
                          //     });
                          //   },
                          //   onDateSaved: (date) {
                          //     print(date);
                          //     setState(() {
                          //       selectedDate = date;
                          //     });
                          //   },
                          // ),



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
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  addTask(Task(
                                      nomeController.text,
                                      null,
                                      descricaoController.text,
                                      DateTime.now(),
                                      estaFeito));
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                width: size.width * 0.5,
                                height: size.height * 0.07,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                    child: Text(
                                  'Adicionar',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
                              ),
                            ),
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
    );
  }
}
