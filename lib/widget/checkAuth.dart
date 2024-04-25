import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../pages/login_page.dart';
import '../pages/task_list.dart';
import '../services/auth_service.dart';

class CheckAuth extends StatelessWidget{


  AuthService auth = AuthService();

  Auth() async {
    UserCredential? userCredential = await auth.user;
    return userCredential;
  }

  @override
  Widget build(BuildContext context){

    return Auth() == null? Login() : TaskList();
  }
}