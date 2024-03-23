import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tarefas/screen/login.dart';
import 'package:tarefas/screen/task_list.dart';

class CheckAuth extends StatelessWidget{
  final bool userIsAuthenticated = false;

  @override
  Widget build(BuildContext context){
    return userIsAuthenticated? TaskList(): Login();
  }
}