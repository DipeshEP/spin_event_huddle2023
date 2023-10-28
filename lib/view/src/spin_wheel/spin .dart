import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:spin_event_2023/const/animation.dart';
import 'package:spin_event_2023/controller/spin_api.dart';
import 'package:spin_event_2023/model/product_model.dart';
import 'package:spin_event_2023/view/src/spin_wheel/users%20.dart';

import '../../../model/modeluser.dart';

class SpinWheel extends StatefulWidget {
  User user;
  SpinWheel({super.key, required this.user});

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> with TickerProviderStateMixin {
  StreamController<int> selected = StreamController<int>();
  late final AnimationController _defaultLottieController;

  @override
  void initState() {
    selected = StreamController<int>();
    _defaultLottieController = AnimationController(vsync: this)
      ..duration = const Duration(seconds: 5);
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
              //  log(userList.first.isSpin.toString());
              if (userList.first.isSpin == false) {
                setState(() {
                  selected.add(SpinApi.spinButtonClik());
                });
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: GlassmorphicContainer(
                        height: 450,
                        width: 450,
                        alignment: Alignment.center,
                        border: 2,
                        linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.purple.withOpacity(0.1),
                          ],
                        ),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.purple.withOpacity(0.1),
                          ],
                        ),
                        blur: 2,
                        borderRadius: 20,
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    "${userList.first.name},You Already Traied",
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
                                          color: Colors.grey,
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
                      duration: const Duration(seconds: 20),
                      onAnimationStart: () {
                        SpinApi.updateCount();
                      },
                      onAnimationEnd: () {
                        _defaultLottieController
                            .forward()
                            .then((value) => _defaultLottieController.reset())
                            .then((value) => popup(context, productlist));
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // SizedBox(width: 100,),
                                // Transform.rotate(
                                //   angle:  pi /0.4,
                                //   child: Text(it.price)),
                                const SizedBox(
                                  width: 100,
                                ),
                                Transform.rotate(
                                    angle: pi / 0.4, child: Text(it.name)),

                                Transform.rotate(
                                    angle: pi / 0.4,
                                    child: Image(
                                      image: it.image,
                                      height: 100,
                                    )),
                              ],
                            ),
                          )),
                      ],
                    ),
                  ),
                ),
                _buildLotties()
              ],
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
            height: 450,
            width: 450,
            alignment: Alignment.center,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.purple.withOpacity(0.1),
              ],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.purple.withOpacity(0.1),
              ],
            ),
            blur: 2,
            borderRadius: 20,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    const Text("Congratulations you Won",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            letterSpacing: 1)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Text(productlist[SpinApi.random].name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            letterSpacing: 1)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Center(
                      child: OutlinedButton(
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
                                color: Colors.grey,
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
}
