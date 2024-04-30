import 'package:tarefas/services/auth_service.dart';

class TaskController {
  AuthService auth = AuthService();

  logout(){
    auth.logout();
  }
}