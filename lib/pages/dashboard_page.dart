import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarefas/pages/add_task_page.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});



  final Stream<QuerySnapshot> _countTask = FirebaseFirestore.instance
      .collection('Tarefa')
      .orderBy('date')
      .snapshots();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: Text('A'),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTaskPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Expanded(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: <BoxShadow>[
                      const BoxShadow(
                          color: Colors.black54,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 0.75))
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 150,
                        height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            StreamBuilder<QuerySnapshot>(
                              stream: _countTask,
                              builder: (_, snapshot) {
                                if (snapshot.error != null){
                                  return Text("0", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),);
                                }
                                if( snapshot.connectionState == ConnectionState.waiting){
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(width: 25,height: 25, child: CircularProgressIndicator()),
                                  );
                                }
                                return Text(
                                  snapshot.data!.size.toString(),
                                  style: TextStyle(
                                      fontSize: 28, fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                            Center(
                              child: SizedBox(
                                width: 120,
                                  height: 20,
                                  child: Text(
                                'Total Atividades',
                                style: TextStyle(fontSize: 16),
                              )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: 100,
                          height: 75,
                          child: SvgPicture.network(
                              'https://www.svgrepo.com/show/219397/analysis.svg')),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
