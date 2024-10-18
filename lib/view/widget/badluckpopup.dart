import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:spin_event_2023/const/image.dart';
import 'package:spin_event_2023/const/sounds.dart';

import '../src/users .dart';

class BadluckPopup extends StatelessWidget {
  const BadluckPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: InkWell(
        onTap: () {
          audioPlayer.stop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Users(),
            ),
          );
        },
        child: GlassmorphicContainer(
          height: 500,
          width: 450,
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
                  const Stack(
                    children: [
                      CircleAvatar(
                        radius: 150,
                        backgroundColor: Colors.white70,
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 4,
                        right: 2,
                        child: CircleAvatar(
                          radius: 150,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                          badluckPopupimg,
                          ),
                        ),
                      ),
                    ],
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
      ),
    );
  }
}