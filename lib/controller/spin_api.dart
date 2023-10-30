
import 'dart:math';
import 'dart:developer' as d;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:spin_event_2023/model/DB_product_model.dart';
import '../const/firebase_const.dart';

class SpinApi {
  List dbProducts;
  SpinApi({
    required this.dbProducts
  });
 
    static late int random;
    List<DocumentSnapshot> products = [];


 static spinButtonClik(){
      
    

     random = 0;
     //Fortune.randomInt(0, 11);

  spinButtonClik(){
    print( "api page list count==========${dbProducts.length}");
int produtindex = Fortune.randomInt(0, dbProducts.length);
print(dbProducts[produtindex].productname);
if( dbProducts[produtindex].productname=='bluetoothSpeaker'){
 d. log('bluetoothSpeaker');
  
  random=8;
}else if(dbProducts[produtindex].productname=='EarBud'){
   d. log('EarBud');
  
     random=5;
}else if(dbProducts[produtindex].productname=='preVoucher'){
   d. log('prevoucher');
          random=4;
}else if(dbProducts[produtindex].productname=='voucher'){
   d. log('voucher');
          random=1;
}else if(dbProducts[produtindex].productname=='watch'){
   d. log('watch');
          random=2;
}
     
    // random=1;
    // if(random==1){
    //      decrementProductCount('cap');
    // }
    decrementCount();
    
 
    
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
 static  Stream<QuerySnapshot<Map<String, dynamic>>> fetchProducts() {
    return firestore
        .collection("spinEvent")
        .doc("product")
        .collection("day").where('isClaim',isEqualTo: false)
        .snapshots();
        
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