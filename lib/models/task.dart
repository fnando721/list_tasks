

import 'package:tarefas/models/priority.dart';

class Task {
  String name;
  Priority priority;
  String description;
  DateTime date;
  bool isDone;

  Task({
    required this.name,
    required this.priority,
    required this.description,
    required this.date,
    required this.isDone,
  });

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      name: map['name'],
      priority:map['priority'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      isDone: map['isDone'],
    );
  }


   String priorityToString() {
    switch (priority) {
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


  static Priority stringToPriority(String priorityString) {
    switch (priorityString) {
      case 'baixa':
        return Priority.low;
      case 'média':
        return Priority.medium;
      case 'alta':
        return Priority.high;
      default:
        return Priority.high;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'priority': priorityToString(),
      'description': description,
      'date': date.toIso8601String(),
      'isDone': isDone,
    };
  }
}
