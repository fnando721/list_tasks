import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tarefas/controller/repository/task_repository.dart';
import 'package:tarefas/models/task.dart';
import '../models/priority.dart';

class AddTaskController extends ChangeNotifier{


  bool isDone = false;

  TasksRepository tasksRepository = TasksRepository();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  Priority priority = Priority.high;

  DateTime? date;

  List<ButtonSegment<Priority>> prioritySegments = [
    const ButtonSegment(value: Priority.low, label: Text('Baixa')),
    const ButtonSegment(value: Priority.medium, label: Text('Media')),
    const ButtonSegment(value: Priority.high, label: Text('Alta')),
  ];


  Set<Priority> prioritySelection = <Priority>{
    Priority.high
  };




  void Function()? validate (BuildContext context,var formKey) {
    return () {
      if (formKey.currentState!.validate()) {
        date = _parseDate(dateController.text);
        if (date != null) {
          tasksRepository.addTask(Task(
              name: nameController.text,
              priority: prioritySelection.single ,
              description :descriptionController.text,
              date: date!,
              isDone: isDone));
          Navigator.pop(context);
        }
      }
    };
  }

  DateTime? _parseDate(String input) {
    try {
      return DateFormat('yyyy-MM-dd').parseStrict(input);
    } catch (e) {
      return null;
    }
  }

  changePriority(Set<Priority> newpPriority){
    prioritySelection  = newpPriority;
    notifyListeners();
  }

}