

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tarefas/controller/repository/task_repository.dart';
import 'package:tarefas/models/task.dart';

import '../models/priority.dart';

class DetailController extends ChangeNotifier {
  String id;
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
      required this.isDone,
      required this.id});

  change() {
    String formattedDate = DateFormat('yyyy-MM-dd 00:00:00.000').format(task.date);

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

  save() {
    try {
      DateTime date = dateController.text != task.date.toString()
          ? _parseDate(dateController.text)
          : task.date;

      Task newTask = Task(
          name: nameController.text,
          priority: Priority.low,
          description: descriptionController.text,
          date: date,
          isDone: isDone);

      TasksRepository().editTask(newTask, id);
      task = newTask;
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  void delete (String id){
    try {
      TasksRepository().deleteTask(id);
  } catch (e){
      throw e.toString();
  }
}

  DateTime _parseDate(String input) {
    return DateFormat('yyyy-MM-dd').parseStrict(input);
  }
}
