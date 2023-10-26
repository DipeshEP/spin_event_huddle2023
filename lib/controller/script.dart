
import 'package:cloud_firestore/cloud_firestore.dart';

class SpinApi {
   

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchUser() {
       final firestore = FirebaseFirestore.instance;
    return firestore
        .collection("spinEvent")
        .doc("EventUser")
        .collection("users")
        .snapshots();
  }
}
