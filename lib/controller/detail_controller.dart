import 'package:flutter/cupertino.dart';
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
}
