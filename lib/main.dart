import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tarefas/pages/waiting_page.dart';
import 'package:tarefas/widget/checkAuth.dart';
import 'firebase_options.dart';




void main() async {
 runApp(const WaitingPage());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home:  CheckAuth(),


      // localizationsDelegates: [
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: [Locale('en', 'US')],


        );
  }
}




