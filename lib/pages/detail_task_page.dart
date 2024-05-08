import 'package:flutter/material.dart';
import 'package:tarefas/models/task.dart';
import '../components/DateTimePickerCustom.dart';
import '../components/TextFormFieldCustom.dart';
import '../controller/detail_controller.dart';

class DetailTaskPage extends StatefulWidget {
  DetailTaskPage({super.key, required this.id, required this.task});

  String id;
  Task task;

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  bool isTaskDone = false;
  DetailController? detailController;

  @override
  void initState() {
    super.initState();
    detailController = DetailController(
        task: widget.task,
        nameController:
        TextEditingController(text: widget.task.name.toString()),
        descriptionController:
        TextEditingController(text: widget.task.description.toString()),
        dateController:
        TextEditingController(text: widget.task.date.toString()),
        isDone: widget.task.isDone);

    detailController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Detalhes da Tarefa',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )),
          actions: [
            detailController!.isButton
                ? IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                ))
                : const SizedBox()
          ],
        ),
        body: Form(
          key: detailController!.formKey,
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
                  const Text(
                    'Titulo',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: size.width,
                    child: TextFormFieldCustom(
                        title: 'Titulo',
                        controller: detailController!.nameController,
                        msgError: 'Digite o nome da tarefa',
                        maxLines: null,
                        onChangedFunction: (_) {
                          detailController!.change();
                        }),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  const Text(
                    'Descrição',
                    style: TextStyle(fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                      detailController!.change();
                    },
                    child: SizedBox(
                      width: size.width,
                      height: size.height * 0.2,
                      child: TextFormFieldCustom(
                          title: 'Descrição',
                          controller:
                          detailController!.descriptionController,
                          msgError: null,
                          maxLines: 10,
                          onChangedFunction: (_) {
                            detailController!.change();
                          }),
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
                      controller: detailController!.dateController,
                      onChangedFunction: (_) {
                        detailController!.change();
                      }),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Center(
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Switch(
                            value: detailController!.isDone,
                            onChanged: (bool newValue) {
                              setState(() {
                                detailController!.isDone = newValue;
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
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: GestureDetector(
                        onTap: detailController!.deleteFunc(context),
                        child: Container(
                          width: size.width * 0.5,
                          height: size.height * 0.07,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                              child: Text(
                                'Deletar Tarefa',
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
    ),);
  }
}
