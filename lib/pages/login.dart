import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarefas/components/textFormsFieldsLogin.dart';
import 'package:tarefas/pages/tasks.dart';
import '../controller/login_controller.dart';
import '../services/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return !loginController.isWaiting? Form(
      key: loginController.formKey,
      child: Scaffold(
        body: GestureDetector(
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
                      child: SvgPicture.network(
                          'https://www.svgrepo.com/show/438998/task-runners.svg')),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: TextFormField(
                            controller: loginController.emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Digite seu E-mail';
                              } else if (!value.contains('@')) {
                                return 'O email está incorreto';
                              }
                              return null;
                            },
                            decoration: textFormsFieldsLogin(
                                'Login',
                                const Icon(
                                    Icons.supervised_user_circle_outlined)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: TextFormField(
                            controller: loginController.passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Digite sua senha!';
                              } else if (value.length < 5) {
                                return 'Deve possui no mínimo 5 caracteres';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: textFormsFieldsLogin(
                                'Senha', const Icon(Icons.password_outlined)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (loginController.formKey.currentState!
                                    .validate()) {
                                  try {
                                    print("Validação");
                                    loginController.login();
                                    print("teste"+ loginController.auth.user!.user!.email.toString());
                                    if (loginController.auth.user != null) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const TaskList(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            'Seu email ou senha está incorreto!'),
                                      ));
                                      loginController.isWaiting = false;
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Tente novamente!'),

                                    ));
                                  }
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
                              child: const Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ) : Container(
      height: size.height,
      width: size.width,
      color: Colors.blueGrey,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    )
     ;

  }
}