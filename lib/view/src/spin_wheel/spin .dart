import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:spin_event_2023/const/animation.dart';
import 'package:spin_event_2023/controller/spin_api.dart';
import 'package:spin_event_2023/model/DB_product_model.dart';
import 'package:spin_event_2023/model/product_model.dart';

import 'package:spin_event_2023/view/src/spin_wheel/users%20.dart';

import '../../../model/modeluser.dart';

class SpinWheel extends StatefulWidget {
  User user;
  List dbProducts;

  SpinWheel({super.key, required this.user, required this.dbProducts});

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> with TickerProviderStateMixin {
  StreamController<int> selected = StreamController<int>();
  late final AnimationController _defaultLottieController;
  final player = AssetsAudioPlayer();
  int? gamecount;
  @override
  void initState() {
    selected = StreamController<int>();
    _defaultLottieController = AnimationController(vsync: this)
      ..duration = const Duration(seconds: 5);
    SpinApi(dbProducts: widget.dbProducts).spinButtonClik();
    super.initState();
  }

  @override
  void dispose() {
    selected.close();
    _defaultLottieController.dispose();
    super.dispose();
  }

  _buildLotties() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: IgnorePointer(
          child: Lottie.asset(
            defaultLottie,
            controller: _defaultLottieController,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<User> userList = [];
    int? index;
    String email = widget.user.email!;
    var nameuser = email.split("@");
    var emailcaracter = email.replaceRange(
        2, nameuser[0].length, "*" * (nameuser[0].length - 2));
    print(emailcaracter);
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg_img.jpg"), fit: BoxFit.fill)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: 150,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: StreamBuilder(
                stream: SpinApi.fetchOneUser(widget.user.usId),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                    case ConnectionState.done:
                      userList = snapshot.data!.docs
                          .map((e) => User.fromJson(e.data()))
                          .toList();
                      if (userList.isNotEmpty) {
                        return Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(userList.first.image!),
                              radius: 50,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userList.first.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                Text(
                                  emailcaracter,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text("error"),
                        );
                      }
                  }
                }),
          ),
          body: GestureDetector(
            onTap: () {
              player.open(Audio.file("assets/wheel_fortune_1.mp3"));
              //  log(userList.first.isSpin.toString());
              if (userList.first.isSpin == false) {
                setState(() {
                  selected.add(SpinApi.random);
                });
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
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
                                  "assets/sad2.png",
                                  height: 300,
                                ),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade100,
                                      elevation: 10,
                                    ),
                                    onPressed: () {
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
                  },
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Stack(
                children: [
                  _buildLotties(),
                  const Center(
                    child: CircleAvatar(
                      backgroundColor: Color(0xff8dca87),
                      radius: 540,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FortuneWheel(
                        indicators: [],
                        duration: const Duration(seconds: 20),
                        onAnimationStart: () {
                          SpinApi.decrementCount();
                        },
                        onAnimationEnd: () {
                          if (SpinApi.random == 0 ||
                              SpinApi.random == 3 ||
                              SpinApi.random == 6 ||
                              SpinApi.random == 9) {
                            badluckPopup(context);
                          } else {
                            popup(context, productlist);
                            player.open(Audio.file("assets/congragulation,bgm.mpeg"));
                            _defaultLottieController
                                .forward()
                                .then(
                                    (value) => _defaultLottieController.reset());


                          }

                          SpinApi.updateUserStatus(userList.first.usId);
                        },
                        animateFirst: false,
                        selected: selected.stream,
                        items: [
                          for (var it in productlist)
                            FortuneItem(
                                child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: it.color,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(
                                    width: 100,
                                  ),
                                  // Transform.rotate(
                                  //     angle: pi / 0.4, child: Text(it.name)),
                                  it.name != "Voucher"
                                      ? Transform.rotate(
                                          angle: pi / 0.4,
                                          child: Image(
                                            image: it.image,
                                            height: 120,
                                          ))
                                      : Transform.rotate(
                                          angle: pi / 0.2,
                                          child: Image(
                                            image: it.image,
                                            height: 80,
                                          ),
                                        ),
                                ],
                              ),
                            )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 280),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          "assets/arrow.png",
                          height: 100,
                          color: Colors.red,
                        )),
                  ),
                  _buildLotties(),
                  const Center(
                      child: Image(
                    image: AssetImage("assets/center_button.png"),
                    height: 160,
                  ))
                ],
              ),
            ),
          )),
    );
  }

  Future<dynamic> popup(BuildContext context, List<Products> productlist) {
    return showDialog(
      context: context,
// user must tap button!
      builder: (BuildContext context) {
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
                    const Text(
                      "Congratulations you Won",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          letterSpacing: 1),
                    ),
                    Image(
                      image: productlist[SpinApi.random].image,
                      height: 180,
                    ),
                    Text(productlist[SpinApi.random].name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            letterSpacing: 1)),
                    Center(
                      child: productlist[SpinApi.random].name == 'Repeat'
                          ? OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            elevation: 10,
                          ),
                              onPressed: () {
                                setState(() {

                                   selected.add(0);
                                });
                                 Navigator.pop(context);
                              },
                              child: const Text(
                                "Repeat",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ))
                          : 
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.grey.shade100,
                                elevation: 10,
                              ),
                              onPressed: () {
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
                              )),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  badluckPopup(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
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
                    const Text(" BETTER LUCK NEXT TIME",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: 1)),
                    Image.asset(
                      "assets/sad2.png",
                      height: 300,
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.grey.shade100,
                          elevation: 10,
                        ),
                        onPressed: () {
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
      },
    );
  }
}
