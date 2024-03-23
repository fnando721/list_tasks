import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService extends ChangeNotifier {
  FirebaseAuth _firebaseUser = FirebaseAuth.instance;
  var userIsAuthenticated = false;

 @override
  authService(String email){
   _firebaseUser
       .authStateChanges()
       .listen((User? user) {

     if (user == null) {
       userIsAuthenticated = true;
     } else {
       userIsAuthenticated = false ;
     }
   });
  notifyListeners();
 }


 createdUser(String email, String password) async{
   try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
   } catch (e){
    e.toString();
   }
 }

  login(String email, String password) async{
    try{
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } catch (e){
      e.toString();
    }
  }

}