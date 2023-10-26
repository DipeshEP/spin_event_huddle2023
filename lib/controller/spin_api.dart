

import 'package:cloud_firestore/cloud_firestore.dart';

import '../const/firebase_const.dart';

class SpinApi {

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchUser() {
    return firestore
        .collection("spinEvent")
        .doc("EventUser")
        .collection("users")
        .snapshots();
  }

}