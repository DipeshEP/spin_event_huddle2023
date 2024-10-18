import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:spin_event_2023/const/animation.dart';
import 'package:spin_event_2023/const/image.dart';
import 'package:spin_event_2023/const/sounds.dart';
import 'package:spin_event_2023/controller/spin_api.dart';
import 'package:spin_event_2023/model/product_model.dart';
import 'package:spin_event_2023/view/src/users%20.dart';
import 'package:spin_event_2023/view/widget/alreadyTriedPopup.dart';
import 'package:spin_event_2023/view/widget/badluckpopup.dart';

import '../../model/modeluser.dart';

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



  @override
  void initState() {
       
    selected = StreamController<int>();
    _defaultLottieController = AnimationController(vsync: this)
      ..duration = const Duration(seconds: 5);
    SpinApi(dbProducts: widget.dbProducts).spinButtonClik();
     audioPlayer.stop();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
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
            height: 800,
            width: 800,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<User> userList = [];
    String email = widget.user.email!;
    var nameuser = email.split("@");
    var emailcaracter = email.replaceRange(
        2, nameuser[0].length, "*" * (nameuser[0].length - 2));
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration:  BoxDecoration(
          image: DecorationImage(
              image: AssetImage(spinBg), fit: BoxFit.fill)),
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
              if (userList.first.isSpin == false) {
                setState(() {
                  selected.add(SpinApi.random);
                });
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlreadyTried(userList: userList);
                  },
                );
              }
            },
            child: Stack(
              children: [
                _buildLotties(),
                 Center(
                  child: Container(
                    width: 1020,  // 2 * radius (510 * 2)
                    height: 1020, // 2 * radius (510 * 2)
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [
                          Colors.redAccent,
                          Colors.orange,
                          Colors.yellow,
                          Colors.green,
                          Colors.blueAccent,
                          Colors.purple,
                          Colors.pinkAccent,
                          Colors.redAccent,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 950,
                        height: 950,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 1100,
                    height: 1000,
                    child: FortuneWheel(
                      indicators: [],
                      duration: const Duration(seconds: 20),
                      onAnimationStart: () {
                        spinplayAudio();
                        SpinApi.decrementCount();
                      },
                      onAnimationEnd: () {
                        if (SpinApi.random == 3 ||SpinApi.random == 6) {
                         // candy
                          betterLuckAudio();
                          showDialog(
                             barrierDismissible: false,
                             context: context,
                             builder: (BuildContext context) {
                               return Padding(
                                 padding: const EdgeInsets.only(top: 180),
                                 child: BadluckPopup()
                               );
                             },
                           );
                          SpinApi.updateWinedProduct(uid: widget.user.usId.toString(),product: productlist[SpinApi.random].name,price: productlist[SpinApi.random].price);
                        } else {
                          if (
                            SpinApi.random == 1 ||
                            SpinApi.random == 2 ||
                            SpinApi.random == 4 ||
                            SpinApi.random == 5 ||
                            SpinApi.random == 7
                              ) {

                            SpinApi.updateWinedProduct(
                              uid: widget.user.usId.toString(),
                              product: productlist[SpinApi.random].name,
                              price: productlist[SpinApi.random].price
                              );
                            popup(context, productlist);
                            congratulationAudio();
                            _defaultLottieController.forward().then(
                                (value) => _defaultLottieController.reset());
                          } else if (SpinApi.random == 0) {
                            popup(context, productlist);
                            _defaultLottieController.forward().then(
                                (value) => _defaultLottieController.reset());
                          } else {
                            SpinApi.updateWinedProduct(
                              uid: widget.user.usId.toString(),
                              product: productlist[SpinApi.random].name,
                              price: productlist[SpinApi.random].price
                              );
                              popup(context, productlist);
                              congratulationAudio();
                            _defaultLottieController.forward().then(
                                (value) => _defaultLottieController.reset());
                          }
                        }

                        SpinApi.updateUserStatus(userList.first.usId);
                      },
                      animateFirst: false,
                      selected: selected.stream,
                      items: [
                        for (var it in productlist)
                          FortuneItem(
                              child: Container(
                            width: 600,
                            height: double.infinity,
                            color: it.color,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  width: 160,
                                ),
                                it.name == ProductType.voucher.name
                                    ? Transform.rotate(
                                        angle: pi / 0.2,
                                        child: Image(
                                          image: it.image,
                                          height: 150,
                                        ))
                                : it.name == ProductType.repeat.name
                                     ? Transform.rotate(
                                          angle: pi / 0.4,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets
                                                    .only(
                                                    bottom: 50),
                                            child: Image(
                                              image: it.image,
                                              height: 190,
                                            ),
                                          ),
                                        )
                                : Transform.rotate(
                                     angle: pi / 0.4,
                                       child: Padding(
                                         padding:const EdgeInsets.only(bottom: 40),
                                         child: Image(
                                           image: it.image,
                                           height: 190,
                                         ),
                                       ),
                                     )
                              ],
                            ),
                          )),
                      ],
                    ),
                  ),
                ),
              
                Padding(
                  padding: const EdgeInsets.only(top: 230),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        spinArrow,
                        height: 120,
                        color: Colors.red,
                      )),
                ),
                _buildLotties(),
                Center(
                  child: CircleAvatar(
                    radius: 84,
                    backgroundColor: Colors.grey,
                  ),
                ),
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.black,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 26),
                    child: Image(
                      height: 120,
                      width: 120,
                      image: AssetImage(reachoutLogo),
                    ),
                  ),
                 
                )
              ],
            ),
          )),
    );
  }

  Future<dynamic> popup(BuildContext context, List<Products> productlist) {
    return showDialog(
      barrierDismissible: false,
      context: context,
// user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: InkWell(
            onTap: () {
              if (productlist[SpinApi.random].name == ProductType.repeat.name) {
                setState(() {
                  SpinApi(dbProducts: widget.dbProducts)
                      .spinButtonClik()
                      .then((value) {
                    selected.add(SpinApi.random);
                  });
                });                
                Navigator.pop(context);
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Users(),
                  ),
                );
                audioPlayer.stop();

              }
            },
            child: GlassmorphicContainer(
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
                        "Congratulations !",
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
                      if (productlist[SpinApi.random].name == ProductType.voucher.name)
                         Text("You won Amazon Gift Voucher\n Worth ₹${productlist[SpinApi.random].price}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                letterSpacing: 1)),
                      if (productlist[SpinApi.random].name == ProductType.repeat.name)
                        const Text(
                            "It Seems Like Your Luck Is So Close.\n Spin Again",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                letterSpacing: 1)),
                      Center(
                        child: productlist[SpinApi.random].name == ProductType.repeat.name
                            ? OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade100,
                                  elevation: 10,
                                ),
                                onPressed: () {
                                  setState(() {
                                    SpinApi(dbProducts: widget.dbProducts)
                                        .spinButtonClik()
                                        .then((value) {
                                      selected.add(SpinApi.random);
                                    });
                                  });
                                  audioPlayer.stop();                                 
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Repeat",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ))
                            : OutlinedButton(
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
                                  audioPlayer.stop();
                                  
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
          ),
        );
      },
    );
  }

}




