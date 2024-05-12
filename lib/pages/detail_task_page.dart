import 'package:flutter/material.dart';
import 'package:tarefas/models/task.dart';
import '../components/DateTimePickerCustom.dart';
import '../components/TextFormFieldCustom.dart';
import '../controller/detail_controller.dart';

class DetailTaskPage extends StatefulWidget {
  DetailTaskPage({super.key, required this.id, required this.task});

  final String id;
  final Task task;

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
        isDone: widget.task.isDone,
        id: widget.id);

    detailController!.addListener(() {
      setState(() {});
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
                    onPressed: () {
                      try {
                        detailController!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Tarefa foi salva com sucesso!')),
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Erro: ' + e.toString()),
                          ),
                        );
                      }
                    },
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
                                    detailController!.isDone = newValue;
                                    detailController!.change();
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
                            onTap: () {
                              this.deleteFunc();
                            },
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
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
      ),
    );
  }


  void deleteFunc() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Atenção'),
        content: Text(
          'Deseja realmente apagar essa tarefa?',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Não'),
            style: ButtonStyle(
                foregroundColor:
                MaterialStateProperty.resolveWith((states) => Colors.white)),
          ),
          TextButton(
            onPressed: () {
              try {
                detailController!.delete(widget.id);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tarefa deletado com sucesso!')));
                Navigator.pop(context);
                Navigator.pop(context);
              }catch (e){

              }

            },
            child: Text('Sim'),
            style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.resolveWith((states) => Colors.white),
              textStyle: MaterialStateProperty.resolveWith(
                      (states) => TextStyle(fontSize: 18)),
            ),
          ),
        ],
        elevation: 24.0,
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}


