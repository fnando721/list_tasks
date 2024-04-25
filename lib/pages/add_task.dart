import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tarefas/models/repository/task_repository.dart';
import 'package:tarefas/models/task.dart';
import '../components/DateTimePickerCustom.dart';
import '../components/TextFormFieldCustom.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  bool isDone = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _date;

  TasksRepository tasksRepository = TasksRepository();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )),
          backgroundColor: Colors.blueGrey,
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Container(
              width: size.width * 0.8,
              height: size.height,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    const Text(
                      'Titulo',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: size.width,
                      child: TextFormFieldCustom(
                        title: 'Titulo',
                        controller: _nameController,
                        msgError: 'Digite o nome da tarefa',
                        maxLines: null,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    const Text(
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
                        maxLines: 10,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    const Text(
                      'Data',
                      style: TextStyle(fontSize: 16),
                    ),
                    DateTimePickerCustom(
                        title: 'Data de Entrega', controller: _dateController),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Center(
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Switch(
                              value: isDone,
                              onChanged: (bool newValue) {
                                setState(() {
                                  isDone = newValue;
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _date = _parseDate(_dateController.text);

                              if (_date != null) {
                                tasksRepository.addTask(Task(
                                    _nameController.text,
                                    null,
                                    _descriptionController.text,
                                    _date!,
                                    isDone));
                                Navigator.pop(context);
                              }
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )),
                          ),
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
    );
  }

  DateTime? _parseDate(String input) {
    // Utilize o DateFormat para analisar a string de data
    try {
      return DateFormat('yyyy-MM-dd').parseStrict(input);
    } catch (e) {
      return null;
    }
  }
}
