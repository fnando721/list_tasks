import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarefas/controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = HomeController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    homeController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeController.page[homeController.index],
      bottomNavigationBar: BottomNavigationBar(
        mouseCursor: MaterialStateMouseCursor.textable,
        elevation: 12,
        onTap: onTapBotton,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black26,), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.task, color: Colors.black26,), label: 'Atividades'),
        ],
      ),

    );
  }

  void onTapBotton(value) {
    setState(() {
      homeController.index = value;
    });
  }
}
