import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tarefas/models/task.dart';

import '../models/priority.dart';
import '../models/repository/task_repository.dart';

class AddTaskController extends ChangeNotifier{


  bool isDone = false;

  TasksRepository tasksRepository = TasksRepository();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  DateTime? date;

  List<ButtonSegment<Priority>> prioritySegments = [
    const ButtonSegment(value: Priority.low, label: Text('Baixa')),
    const ButtonSegment(value: Priority.medium, label: Text('Media')),
    const ButtonSegment(value: Priority.high, label: Text('Alta')),
  ];


  Set<Priority> prioritySelection = <Priority>{
    Priority.high
  };

  String priority = 'forte';


  void Function()? validate (BuildContext context,var formKey) {
    return () {
      if (formKey.currentState!.validate()) {
        date = _parseDate(dateController.text);

        if (date != null) {
          tasksRepository.addTask(Task(
              name: nameController.text,
              priority: Task.stringToPriority(priority),
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
    prioritySelection = newpPriority;
    notifyListeners();
  }

  String priorityToStringAddTask( Priority newPriority) {
    switch (newPriority) {
      case Priority.low:
        return 'baixa';
      case Priority.medium:
        return 'média';
      case Priority.high:
        return 'alta';
      default:
        throw Exception('Prioridade desconhecida');
    }
  }

}