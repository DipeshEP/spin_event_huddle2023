import 'package:flutter/material.dart';
import 'package:spin_event_2023/view/src/spin_wheel/spin.dart';

import '../../../model/modeluser.dart';

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  User user;
  Profile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    String email = user.email;
    var nameuser = email.split("@");
    var emailcaracter = email.replaceRange(
        2, nameuser[0].length, "*" * (nameuser[0].length - 2));
    print(emailcaracter);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          clipBehavior: Clip.antiAlias,
          width: width * 0.6,
          height: height * 0.28,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                  height: height * 0.15,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(user.proimage), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            emailcaracter,
                            style:
                            Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SpinWheel(
                              user: user,
                            ),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: Text(
                          "confirm",
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}