import 'package:flutter/material.dart';
import 'package:tarefas/pages/dashboard_page.dart';
import 'package:tarefas/pages/tasks_page.dart';

class HomeController extends ChangeNotifier {
  int index = 0;

  final List<Widget> page = <Widget>[
    DashboardPage(),
    TaskListPage()
  ];


}