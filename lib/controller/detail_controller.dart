import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tarefas/models/task.dart';

class DetailController extends ChangeNotifier {
  Task task;
  TextEditingController nameController;
  TextEditingController descriptionController;
  TextEditingController dateController;
  bool isDone;
  bool isButton = false;

  final formKey = GlobalKey<FormState>();

  DetailController(
      {required this.task,
      required this.nameController,
      required this.descriptionController,
      required this.dateController,
      required this.isDone});

  change() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(task.date);

    if (nameController.text != task.name ||
        descriptionController.text != task.description ||
        dateController.text != formattedDate ||
        isDone != task.isDone) {
      isButton = true;
      notifyListeners();
    } else {
      isButton = false;
      notifyListeners();
    }
  }

  void Function()? deleteFunc(BuildContext context) {
    return () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Atenção'),
          content: Text('Deseja realmente apagar essa tarefa?',style: TextStyle(color: Colors.white),),
          actions: <Widget>[

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Não'),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Sim'),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(fontSize: 18)),

              ),

            ),
          ],
          elevation: 24.0,
          backgroundColor: Colors.blueGrey,
        ),
      );
    };
  }
}
