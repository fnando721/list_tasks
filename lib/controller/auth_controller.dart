import 'package:firebase_auth/firebase_auth.dart';
import 'package:tarefas/services/auth_service.dart';

class AuthController {
  AuthService auth = AuthService();
  User? userCredential;

  Future<UserCredential?> validate(String email, String password) async{


    return auth.login(
        email, password);

  }

}