import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tarefas/pages/waiting_page.dart';
import 'app_widget.dart';
import 'firebase_options.dart';




void main() async {
 runApp(const WaitingPage());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppWidget());
}










