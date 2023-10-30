import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import '../const/firebase_const.dart';

class SpinApi {
 
    static late int random;
    List<DocumentSnapshot> products = [];

 static spinButtonClik(){
      
    

     random = Fortune.randomInt(0, 11);
     
    // random=1;
    if(random==1){
         decrementProductCount('cap');
    }
    decrementCount();
    
    return random;
    
  }
  static Future<void>decrementProductCount(product)async{
    final docRef=firestore.collection(spinEventCollection).doc(productDoc).collection('day').doc(product);
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot=await docRef.get();
      if(documentSnapshot.exists){
       int  currentCount=documentSnapshot.get('count');
       print("current cap count..................$currentCount");
       int newcount=currentCount-1;
       
    if (newcount > 0) {
         await docRef.update({'count': newcount});
        print('Count decremented successfully.');
       }else if(newcount==0){
            await docRef.update({
              'isClaim': true,
              'count':0
              });
           
             print('isClaimed successfully.');
       } 
     
      }else{
        print("document does not exist");
      }
    } catch (e) {
      print("error decrementing $e");
 }
 }
 static Future<QuerySnapshot<Map<String, dynamic>>> fetchProducts() {
    return firestore
        .collection("spinEvent")
        .doc("product")
        .collection("day").where('isClaim',isEqualTo: false)
        .get();
        
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
      print("error decrementing $e");
 }
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