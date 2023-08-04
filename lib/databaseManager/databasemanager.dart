import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseManager {
  final CollectionReference<Map<String, dynamic>> profileList =
      FirebaseFirestore.instance.collection('profileInfo');

  Future<void> createUserData(
      String name, String gender, String cell, int score, String uid) async {
    return await profileList.doc(uid).set({
      'name': name,
      'gender': gender,
      'score': score,
      'cell': cell,
      'uid': uid,
    });
  }

  Future updateData(
      String name, String gender, String cell, int score, String uid) async {
    return await profileList.doc(uid).update({
      'name': name,
      'gender': gender,
      'score': score,
      'cell': cell,
    });
  }

  Future getUserList(String uid) async {
    List itemsList = [];

    try {
      await profileList.doc(uid).get().then((querySnapshot) {
        if (querySnapshot.exists) {
          itemsList.add(querySnapshot);
        }
      });
      return itemsList;
      
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
        return null;
      }
    }
  }
}
