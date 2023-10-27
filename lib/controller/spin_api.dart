

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

import '../const/firebase_const.dart';

class SpinApi {
 
    static late int random;

 static spinButtonClik(){
    random = Fortune.randomInt(0, 11);
    decrementCount();
    
    return random;
    
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchUser() {
    return firestore
        .collection("spinEvent")
        .doc("EventUser")
        .collection("users")
        .snapshots();
  }
 static Future<void>decrementCount()async{
    final docRef=firestore.collection(spinEventCollection).doc(logic);
    try {
      DocumentSnapshot documentSnapshot=await docRef.get();
      if(documentSnapshot.exists){
       int  currentCount=documentSnapshot.get('count2');
       print(currentCount);
       int newcount=currentCount-1;
       
    if (newcount >= 0) {
        await docRef.update({'count2': newcount});
        print('Count decremented successfully.');
      } else {
        // Reset the count to random
        int resetCount=Random().nextInt(5)+4;
        await docRef.update({'count2': resetCount});
        print('Count reset to $resetCount.');
      }
      }else{
        print("document does not exist");
      }
    } catch (e) {
      print("error decrementing $e");
    }
  }

}