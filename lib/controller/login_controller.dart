import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tarefas/services/auth_service.dart';

class LoginController {
  AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  get formKey => _formKey;
  UserCredential? userCredential;
  bool isWaiting = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<UserCredential?>login()  async{
    try {
      return  await auth.login(emailController.text, passwordController.text);
    } catch (e) {
      return null;
    }
  }
}
