import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:spin_event_2023/model/modeluser.dart';
import 'package:spin_event_2023/const/sounds.dart';
import 'package:spin_event_2023/view/src/users%20.dart';

import '../../const/image.dart';

class AlreadyTried extends StatelessWidget {
  const AlreadyTried({
    super.key,
    required this.userList,
  });

  final List<User> userList;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: GlassmorphicContainer(
        height: 550,
        width: 500,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.1),
          ],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.1),
          ],
        ),
        blur: 2,
        borderRadius: 20,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("${userList.first.name},You Already Tried",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: 1)),
                Image.asset(
                  sadimg,
                  height: 300,
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      elevation: 10,
                    ),
                    onPressed: () {
                      audioPlayer.stop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Users(),
                        ),
                      );
                    },
                    child: const Text(
                      "Ok",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}