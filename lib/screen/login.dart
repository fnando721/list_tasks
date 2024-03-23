import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarefas/components/textFormsFieldsLogin.dart';
import 'package:tarefas/screen/task_list.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Scaffold(
        body: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              color: Colors.blueGrey,

              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  SizedBox(
                    width: size.width * 0.6,
                    height: size.height * 0.3,
                    child: SvgPicture.network('https://www.svgrepo.com/show/11307/task-list.svg')
                  ),
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          decoration:  textFormsFieldsLogin('Login', Icon(Icons.supervised_user_circle_outlined)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          obscureText: true,
                          decoration: textFormsFieldsLogin('Senha', Icon(Icons.password_outlined)),

                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              if(_formKey.currentState!.validate()){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> TaskList()));
                              }
                            });
                          },
                          child: Container(
                            width: size.width * 0.8,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.green,
                            ),
                            child: Center(child: Text('Login', style: TextStyle(fontSize: 22),),),
                          ),
                        ),
                      )

                    ],),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
