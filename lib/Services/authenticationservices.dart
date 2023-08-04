import 'package:firebase_atuhenter/databaseManager/databasemanager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //registration with email and password
  Future createNewUser(String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? profile = result.user;
      await DatabaseManager()
          .createUserData(name, "male", "01610006484", 99, profile!.uid);
      return profile;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
  //sign in with email and password

  Future loginUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  //signout
  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
