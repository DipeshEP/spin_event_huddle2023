import 'package:flutter/material.dart';
import 'package:spin_event_2023/controller/script.dart';
import 'package:spin_event_2023/view/src/spin_wheel/profile.dart';

import '../../../model/modeluser.dart';


class Users extends StatelessWidget {
  Users({super.key});

  List<AllAddedUsers> userlist = [];

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
      body: StreamBuilder(
        stream: SpinApi.fetchUser(),
        builder: (context, snapshot) {
         switch(snapshot.connectionState){
          case ConnectionState.waiting:
          case ConnectionState.none:
          return Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
           userlist = snapshot.data!.docs.map((e) => AllAddedUsers.fromJson(e.data())).toList();
           if (userlist.isNotEmpty) {
            return Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView.builder(
              itemCount: userlist.length,
              itemBuilder: (context, index) {
                String email = userlist[index].email!;
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
                      backgroundImage: NetworkImage(userlist[index].image!),
                    ),
                    title: Text(
                      userlist[index].name!.toUpperCase(),
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
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Profile(user: userlist[index]),
                        ));
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
          );
          }else{
            return Center(child: Text("no user"),);
          }
          

         }
          
        }
      ),
    );
  }
}
