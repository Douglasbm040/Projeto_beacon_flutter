import 'package:flutter/cupertino.dart';
import 'package:interface_beacon/src/modules/auth/authentication/interface/authentification_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthentificationRepository extends ChangeNotifier
    implements AuthentificationInterface {
  String emailAddress = "douglasbm040@gmail.com";
  String password = "12345";

  Future<void>createUser(String emailAddress, String  password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void>signAccount(String emailAddress, String  password)async{
    try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailAddress,
    password: password
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
  }









}
