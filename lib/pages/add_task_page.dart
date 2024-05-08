import 'package:flutter/material.dart';
import 'package:tarefas/controller/add_task_controller.dart';
import 'package:tarefas/models/repository/task_repository.dart';
import '../components/DateTimePickerCustom.dart';
import '../components/TextFormFieldCustom.dart';
import '../models/priority.dart';

class AddTaskPage extends StatefulWidget {
   const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TasksRepository tasksRepository = TasksRepository();
  AddTaskController addTaskController = AddTaskController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    addTaskController.addListener(() {
      setState(() {
      });
    });
  }

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
                    Center(
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Prioridade'),
                          SegmentedButton<Priority>(
                              segments: addTaskController.prioritySegments,
                              selected: addTaskController.prioritySelection,
                              onSelectionChanged: (value) {

                                  addTaskController.changePriority(value);

                              },
                              style: ButtonStyle(
                                  enableFeedback: false,
                                  foregroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => Colors.blueGrey))),
                        ],
                      ),
                    ),
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
                        controller: addTaskController.nameController,
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
                        controller: addTaskController.descriptionController,
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
                        title: 'Data de Entrega',
                        controller: addTaskController.dateController),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Center(
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Switch(
                              value: addTaskController.isDone,
                              onChanged: (bool newValue) {
                                setState(() {
                                  addTaskController.isDone = newValue;
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
                          onTap: addTaskController.validate(context, _formKey),
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
                    SizedBox(
                      height: size.height * 0.1,
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
}
