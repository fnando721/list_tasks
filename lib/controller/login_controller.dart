import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tarefas/services/auth_service.dart';

class LoginController extends ChangeNotifier {
  AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  get formKey => _formKey;
  UserCredential? userCredential;
  bool isLogin = false;
  bool isWaiting = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<UserCredential?> login() async {
    try {
      return await auth.login(emailController.text, passwordController.text);
    } catch (e) {
      return null;
    }
  }

  validate() async {

      try {
        await auth.login(emailController.text, passwordController.text);
        notifyListeners();
      } catch (e) {
        throw e.toString();
      }
  }
}
