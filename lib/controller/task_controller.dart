import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tarefas/models/priority.dart';
import 'package:tarefas/services/auth_service.dart';

class TaskController {
  AuthService auth = AuthService();

  logout(){
    auth.logout();
  }


  Color colorPriority (Priority priority){
    if (priority == Priority.high){
      return Colors.red;
    } else if (priority == Priority.medium){
      return Colors.amber;
    }
    return Colors.green;
  }
}