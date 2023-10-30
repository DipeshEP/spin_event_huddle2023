import 'dart:math';
import 'dart:developer' as d;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:spin_event_2023/model/DB_product_model.dart';
import '../const/firebase_const.dart';

class SpinApi {
  List dbProducts;
  
  

  SpinApi({required this.dbProducts});

  static late int random;
  List<DocumentSnapshot> products = [];
 List<int> cherrylist = [0,3,6,9];
  List<int> voucherlist = [1,7];
  List<int> prevoucherlist = [4,10];


  
 Future spinButtonClik()async {
    print("api page list count==========${dbProducts.length}");
    int produtindex = Fortune.randomInt(0, dbProducts.length);
    print(dbProducts[produtindex].productname);
    int gamecount=await getGameCount();

    print("game count===========$gamecount");
     if(gamecount==0){
       if (dbProducts[produtindex].productname == 'bluetoothSpeaker') {
      d.log('bluetoothSpeaker');


      random = 8;
      decrementProductCount('bluetoothSpeaker');
    } else if (dbProducts[produtindex].productname == 'EarBud') {
      d.log('EarBud');

      random = 5;
      decrementProductCount('EarBud');
    } else if (dbProducts[produtindex].productname == 'preVoucher') {
      d.log('prevoucher');
      int randomindex=Random().nextInt(prevoucherlist.length);
    
       random=prevoucherlist[randomindex];
        decrementProductCount('preVoucher');
     
    } else if (dbProducts[produtindex].productname == 'voucher') {
      d.log('voucher');

       int randomindex=Random().nextInt(voucherlist.length);
      random=voucherlist[randomindex];
        decrementProductCount('voucher');
    } else if (dbProducts[produtindex].productname == 'watch') {
      d.log('watch');
      random = 2;
      decrementProductCount("watch");
    }
     }else{
      int randomindex=Random().nextInt(cherrylist.length);
      print("this is the cherry randomindex======$randomindex");
       random=cherrylist[randomindex];

      print("this is the cherry random======$random");
      
     }
    

   
    // decrementCount(gamecount);
  }

  static Future<void> decrementProductCount(product) async {
    final docRef = firestore
        .collection(spinEventCollection)
        .doc(productDoc)
        .collection('day')
        .doc(product);
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await docRef.get();
      if (documentSnapshot.exists) {
        int currentCount = documentSnapshot.get('count');
        print("current cap count..................$currentCount");
        int newcount = currentCount - 1;

        if (newcount > 0) {
          await docRef.update({'count': newcount});
          print('Count decremented successfully.');
        } else if (newcount == 0) {
          await docRef.update({'isClaim': true, 'count': 0});

          print('isClaimed successfully.');
        }
      } else {
        print("document does not exist");
      }
    } catch (e) {
      print("error decrementing $e");
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchProducts() {
    return firestore
        .collection("spinEvent")
        .doc("product")
        .collection("day")
        .where('isClaim', isEqualTo: false)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchUser() {
    return firestore
        .collection("spinEvent")
        .doc("EventUser")
        .collection("users")
        .snapshots();
  }
    static Future<int> getGameCount() async{
       final docRef = firestore.collection(spinEventCollection).doc(logic);
       
           DocumentSnapshot documentSnapshot = await docRef.get();
          
              int currentCount = documentSnapshot.get('count');
             
               return currentCount;
           
     
       
    }

  static Future<void> decrementCount() async {
    final docRef = firestore.collection(spinEventCollection).doc(logic);
    try {
      DocumentSnapshot documentSnapshot = await docRef.get();
      if (documentSnapshot.exists) {
        int currentCount = documentSnapshot.get('count');
       
        print("this is current count============$currentCount");
        int newcount = currentCount - 1;
        print("==========$newcount");

        if (newcount >= 0) {
          await docRef.update({'count': newcount});
          print('Count decremented successfully.');
        } else {
          // Reset the count to random
          int resetCount = Random().nextInt(5) + 4;
          await docRef.update({'count': resetCount});
          print('Count reset to $resetCount.');
        }
      } else {
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
        .collection("users")
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static updateCount() async {
    await firestore
        .collection("spinEvent")
        .doc('logic')
        .update({"count": FieldValue.increment(-1)});
  }

  static updateUserStatus(uid) async {
    await firestore
        .collection("spinEvent")
        .doc('EventUser')
        .collection("users")
        .doc(uid)
        .update({
      "is_spin": true,
    });
  }
}
