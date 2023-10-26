

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

}