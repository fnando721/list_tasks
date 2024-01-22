import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tarefas/screen/login.dart';
import 'package:tarefas/screen/task_list.dart';
import 'firebase_options.dart';

void main() async {
  runApp(const Waiting());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home:  Login()
        );
  }
}



class Waiting extends StatelessWidget {
  const Waiting({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.blueGrey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: size.height * 0.5,
                    width: size.width * 0.7,
                    child: Image.network(
                        'https://uxwing.com/wp-content/themes/uxwing/download/banking-finance/cash-icon.png')),
                SizedBox(
                  height: 5,
                ),
                CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
