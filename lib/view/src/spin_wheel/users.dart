import 'package:flutter/material.dart';
import 'package:spin_event_2023/view/src/spin_wheel/profile.dart';

import '../../../const/firebase_const.dart';
import '../../../model/modeluser.dart';


class Users extends StatelessWidget {
  Users({super.key});

  final List<User> userlist = [
    User(
        "John",
        "john@gmail.com",
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600",
        "9564856212"),
    User(
        "Parthipan",
        "parthi@gmail.com",
        "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=600",
        "90000212"),
    User(
        "Sidharth",
        "sidhu@gmail.com",
        "https://images.pexels.com/photos/846741/pexels-photo-846741.jpeg?auto=compress&cs=tinysrgb&w=600",
        "9511111212"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "Users",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView.builder(
          itemCount: userlist.length,
          itemBuilder: (context, index) {
            String email = userlist[index].email;
            var nameuser = email.split("@");
            var emailcaracter = email.replaceRange(
                2, nameuser[0].length, "*" * (nameuser[0].length - 2));
            print(emailcaracter);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ListTile(
                horizontalTitleGap: 20,
                minVerticalPadding: 30,
                isThreeLine: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                tileColor: Color(0xFDFDFDFD),
                leading: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(userlist[index].proimage),
                ),
                title: Text(
                  userlist[index].name.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  emailcaracter,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.black,
                      ),
                ),
                trailing: ElevatedButton(
                  onPressed: ()async {
                   await firestore.collection("web test").add({
                      "data":"data"
                    });
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => Profile(user: userlist[index]),
                    // ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      fixedSize: const Size(150, 50)),
                  child: Text(
                    "Next",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
