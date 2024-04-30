import 'package:flutter/material.dart';
import '../pages/login.dart';
import '../pages/tasks.dart';
import '../services/auth_service.dart';

class CheckAuth extends StatelessWidget{

  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context){
    return auth.user != null ? const TaskList(): const  Login() ;
  }
}