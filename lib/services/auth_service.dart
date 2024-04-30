import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tarefas/database/db_firestore.dart';
import 'package:tarefas/models/task.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _firebaseUser;
  var userIsAuthenticated = false;
  UserCredential? user;

  @override
  auth(){
   _auth
       .authStateChanges()
       .listen((User? user) {

     if (user != null) {
       userIsAuthenticated = true;
     } else {
       userIsAuthenticated = false ;
     }
   });
 }

  static AuthService get to => AuthService();



 definirTask(Task task){
 final userId = _firebaseUser!.uid;
  try{

  } catch (e){
    FirebaseFirestore db = DBFirestore.get();
    //await db.collection('usuarios').doc(userId).set({})

  }
 }

 createdUser(String email, String password) async{
   try{
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
   } catch (e){
    e.toString();
   }
 }


login(String email , String password) async{
   try {
     user = await _auth.signInWithEmailAndPassword(email: email, password: password);
   }catch (e) {
     e.toString();
   }
 }

  logout () async{
    try {
      await _auth.signOut();
    }catch (e) {
      e.toString();
    }
  }

}