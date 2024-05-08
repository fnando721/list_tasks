import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../pages/tasks_page.dart';
import '../services/auth_service.dart';

class CheckAuth extends StatelessWidget{

  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context){
    return auth.user != null ? const TaskListPage(): const  LoginPage() ;
  }
}