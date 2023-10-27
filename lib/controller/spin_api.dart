import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import '../const/firebase_const.dart';

class SpinApi {
 
    static late int random;

 static spinButtonClik(){

    random = Fortune.randomInt(0, 11);
    return random;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchUser() {
    return firestore
        .collection("spinEvent")
        .doc("EventUser")
        .collection("users")
        .snapshots();
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchOneUser(uid) {
    return firestore
        .collection("spinEvent")
        .doc("EventUser")
        .collection("users").where('id',isEqualTo: uid)
        .snapshots();
  }
  
  static updateCount()async{
    await firestore.collection("spinEvent").doc('logic').update({
      "count": FieldValue.increment(-1)
    });
  }
  static updateUserStatus(uid)async{
    await firestore.collection("spinEvent").doc('EventUser').collection("users").doc(uid).update({
      "is_spin": true,
    });
  }

}