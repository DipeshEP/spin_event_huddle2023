import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as d;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:http/http.dart';
import 'package:spin_event_2023/model/DB_product_model.dart';
import 'package:spin_event_2023/model/message_model.dart';
import '../const/firebase_const.dart';

class SpinApi {
  List dbProducts;

  SpinApi({required this.dbProducts});

  static late int random;
  List<DocumentSnapshot> products = [];
  List<int> cherrylist = [0,3,6,9,11];
  List<int> voucherlist = [1, 7];
  List<int> prevoucherlist = [4, 10];

  Future spinButtonClik() async {
    if(dbProducts.isNotEmpty){
         print("api page list count==========${dbProducts.length}");
    int produtindex = Fortune.randomInt(0, dbProducts.length);
    print(dbProducts[produtindex].productname);
    int gamecount = await getGameCount();

    print("game count===========$gamecount");
    if (gamecount == 0 ) {
      if (dbProducts[produtindex].productname == 'bluetoothSpeaker') {
        d.log('bluetoothSpeaker');

        random = 8;
        decrementProductCount('bluetoothSpeaker');
      } else if (dbProducts[produtindex].productname == 'EarBud') {
        d.log('EarBud');

        random = 5;
        decrementProductCount('earbud');
      } else if (dbProducts[produtindex].productname == 'preVoucher') {
        d.log('prevoucher');
        int randomindex = Random().nextInt(prevoucherlist.length);

        random = prevoucherlist[randomindex];
        decrementProductCount('preVoucher');
      } else if (dbProducts[produtindex].productname == 'voucher') {
        d.log('voucher');

        int randomindex = Random().nextInt(voucherlist.length);
        random = voucherlist[randomindex];
        decrementProductCount('voucher');
      } else if (dbProducts[produtindex].productname == 'watch') {
        d.log('watch');
        random = 2;
        decrementProductCount("watch");
      }
    }
     else {
      int randomindex = Random().nextInt(cherrylist.length);
      print("this is the cherry randomindex======$randomindex");
      random = cherrylist[randomindex];

      print("this is the cherry random======$random");
    }

    // decrementCount(gamecount);
    } else {
      int randomindex = Random().nextInt(cherrylist.length);
      print("this is the cherry randomindex======$randomindex");
       random = cherrylist[randomindex];
      // random=11;

      print("this is the cherry random======$random");
    }
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

  static Future<int> getGameCount() async {
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
  static String getConversationID(String Userid) =>
      reachOutID.hashCode <= Userid.hashCode
          ? '${reachOutID}_$Userid'
          : '${Userid}_${reachOutID}';
  static String reachOutID = 'clm4ii9ol00n9zqqshfukbj0w';
  
 static Future<void> sendMessage(String UserID , String msg, Type type ,String pushToken) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
        toId: UserID,
        msg: msg,
        read: '',
        type: type,
        fromId: reachOutID,
        sent: time);
    // print(message);
    final ref = firestore.collection(
        '${chatsCollection}/${getConversationID(UserID)}/${messagesCollection}/'); //${getConversationID(UserID)}
    await ref.doc(time).set(message.toJson()).then((value) =>
        sendPushNotification(pushToken, type == Type.text ? msg : 'image'));
    // then((value) =>
    //   sendPushNotification(chatUser, type == Type.text ? msg : 'image'));
    firestore
        .collection(userCollection)
        .doc(reachOutID)
        .collection(my_userscollection)
        .doc(UserID)
        .update({"last_active": time}).then(
      (value) {
        firestore
            .collection(userCollection)
            .doc(UserID)
            .collection(my_userscollection)
            .doc(reachOutID)
            .update({"last_active": time});
      },
    );
    firestore.collection(userCollection).doc(UserID).update({
      "is_chatNotification": true,
    });
  }
   // for sending push notification
  static Future<void> sendPushNotification(String pushToken , String msg) async {
    try {
      final body = {
        "to":pushToken,
        "notification": {
          "title": "ReachOut",
          "body": msg,
          "android_channel_id": "chats"
        },
        "data": {
          "some_data": "User ID: ${reachOutID}",
        },
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAAJzS2t10:APA91bGpIdIlrDQHT9txMC2wv55TApAOFqv3leBY27blZ8BrjB4FG58NaB-_1PZB1g-GpTyE7kMSbnL8g9rx2knMGEEaP8WvZKeqhFgcfP3_HkpszJex1KCj9v_Y4NXDHVBXXM6x_4e6'
            //'Key=AAAATAJr6AA:APA91bHQgQCqvtZiPDWl1Bn_Iab-vo-jaJe8X1z_6QajorFNxS4SlRd6igvtJmQsjug2QPsynBmUhzP2A4B1FhVI3nwTwPB4tXE7_6U12Z9UQqNZ4-d8vC7XY_9mZtJbtw8JauSgU6NQ'
          },
          body: jsonEncode(body));
     
    } catch (e) {
    
    }
  }
}
