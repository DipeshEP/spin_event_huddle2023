import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:spin_event_2023/const/animation.dart';
import 'package:spin_event_2023/controller/spin_api.dart';
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

  late AudioPlayer audioPlayer;
  late AudioPlayer audioPlayer1;
  late AudioPlayer audioPlayer2;
  int? gamecount;


  int lastSentIndex = 0;
  int lastsendIndex2=0;
  bool isRepeatButtonPressed = false;

  @override
  void initState() {
    audioPlayer=AudioPlayer();
    audioPlayer1=AudioPlayer();
    audioPlayer2=AudioPlayer();
    selected = StreamController<int>();
    _defaultLottieController = AnimationController(vsync: this)
      ..duration = const Duration(seconds: 5);
    SpinApi(dbProducts: widget.dbProducts).spinButtonClik();
    super.initState();
  }

  @override
  void dispose() {
     audioPlayer.dispose();
     audioPlayer1.dispose();
     audioPlayer2.dispose();
    selected.close();
    _defaultLottieController.dispose();
    super.dispose();
  }

  playSpinSoundSpinSound() async {
    String spinSoundPath = 'assets/spinwheel.mp3';
    await audioPlayer.setAsset(spinSoundPath);
    await audioPlayer.play();

  }
  playSpinSoundBadPop() async {
    String spinSoundPath = 'assets/_better Luck Next Ti (1).mp3';
    await audioPlayer1.setAsset(spinSoundPath);
    await audioPlayer1.play();

  }
  playSpinSoundCong() async {
    String spinSoundPath = 'assets/congratulation_audio.mpeg';
    await audioPlayer2.setAsset(spinSoundPath);
    await audioPlayer2.play();

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
              if(userList.first.isSpin==false)
              playSpinSoundSpinSound();
              // player.open(Audio.file("assets/spinsound_effect.mp.wav"));
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
                                      audioPlayer2.stop();
                                      audioPlayer.stop();
                                      audioPlayer1.stop();
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
                  Center(
                    child: SizedBox(
                      width: 850,
                      height: 800,
                      child: FortuneWheel(
                        indicators: [],
                        duration: const Duration(seconds: 20),
                        onAnimationStart: () {
                          SpinApi.voucherLink100();
                          SpinApi.voucherLink200();
                          SpinApi.decrementCount();
                        },
                        onAnimationEnd: () {
                          if (SpinApi.random == 0 ||
                              SpinApi.random == 3 ||
                              SpinApi.random == 6 ||
                              SpinApi.random == 9) {
                            badluckPopup(context);
                             playSpinSoundBadPop();
                            // audio_effect("assets/sad_audio.mpeg");
                            SpinApi.updateWinedProduct(widget.user.usId,productlist[SpinApi.random].name);
                          } else {
                            if( SpinApi.random == 0 || SpinApi.random==7 || SpinApi.random ==10){

                              print(               widget.user.usId             );
                              print(               widget.user.name             );
                              SpinApi.updateWinedProduct(widget.user.usId,productlist[SpinApi.random].name);
                              // SpinApi.sendMessage(widget.user.usId!,
                              //     '${SpinApi.voucherListOne[0]['link']}',
                              //     "text",
                              //     widget.user.pushToken!);
                              if (lastSentIndex < SpinApi.voucherListOne.length) {
                                // Check if there are more messages in the list
                                String msggg="You have won the voucher.\n"
                                    "You will receive it within 24 hours";
                                // String messageToSend = SpinApi.voucherListOne[lastSentIndex]['link'];
                                 SpinApi.sendMessage(widget.user.usId!, msggg, "text", widget.user.pushToken!);
                                //
                                // // Update the last sent index
                                // SpinApi.voucherListOne.removeAt(0);
                              } else {
                                // No more messages to send
                                print("All messages have been sent.");
                              }


                              popup(context, productlist);
                              playSpinSoundCong();
                              // player.open(Audio.file("assets/congratulation_audio.mpeg"));
                              _defaultLottieController
                                  .forward()
                                  .then(
                                      (value) => _defaultLottieController.reset());
                            }
                            else if(SpinApi.random == 4){

                              print(               widget.user.usId             );
                              print(               widget.user.name             );
                              SpinApi.updateWinedProduct(widget.user.usId,productlist[SpinApi.random].name);
                              // SpinApi.sendMessage(widget.user.usId!,
                              //     '${SpinApi.voucherListTwo[0]['link']}',
                              //     "text",
                              //     widget.user.pushToken!);
                              if (lastSentIndex < SpinApi.voucherListTwo.length) {
                                // Check if there are more messages in the list
                                String msgg="You have won the voucher.\n"
                                    "You will receive it within 24 hours";
                                //String messageToSend = SpinApi.voucherListTwo[lastSentIndex]['link'];
                                SpinApi.sendMessage(widget.user.usId!, msgg, "text", widget.user.pushToken!);

                                // Update the last sent index
                                SpinApi.voucherListTwo.removeAt(0);
                              } else {
                                // No more messages to send
                                print("All messages have been sent.");
                              }
                              popup(context, productlist);
                              playSpinSoundCong();
                              // player.open(Audio.file("assets/congratulation_audio.mpeg"));
                              _defaultLottieController
                                  .forward()
                                  .then(
                                      (value) => _defaultLottieController.reset());
                            }else{

                              print(               widget.user.usId             );
                              print(               widget.user.name             );
                              SpinApi.updateWinedProduct(widget.user.usId,productlist[SpinApi.random].name);
                              popup(context, productlist);
                              playSpinSoundCong();
                              _defaultLottieController
                                  .forward()
                                  .then(
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
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: it.color,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(
                                        width: 160,
                                      ),

                                      it.name == "Voucher"
                                          ? Transform.rotate(
                                          angle: pi / 0.2,
                                          child: Image(
                                            image: it.image,
                                            height: 90,
                                          ))
                                          :  it.name == "Earbud" ?

                                      Transform.rotate(
                                        angle: pi / 0.4,
                                        child: Image(
                                          image: it.image,
                                          height: 160,
                                        ),
                                      )
                                          :  it.name == "Watch" ?
                                      Transform.rotate(
                                        angle: pi / 0.4,
                                        child: Image(
                                          image: it.image,
                                          height: 160,
                                        ),
                                      )  : it.name== 'Speaker'?
                                      Transform.rotate(
                                        angle: pi / 0.4,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 50),
                                          child: Image(
                                            image: it.image,
                                            height: 120,
                                          ),
                                        ),
                                      ):it.name== 'Repeat'?
                                      Transform.rotate(
                                        angle: pi / 0.4,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 50),
                                          child: Image(
                                            image: it.image,
                                            height: 100,
                                          ),
                                        ),
                                      ):
                                      Transform.rotate(
                                        angle: pi / 0.4,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 40),
                                          child: Image(
                                            image: it.image,
                                            height: 120,
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
                          "assets/arrow.png",
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
                          image:  AssetImage("assets/Logo28-WB - Copy.png",),
                        ),
                      ),
                      // Container(
                      //   width: 180,
                      //   height: 180,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: Colors.black,
                      //     // image: DecorationImage(
                      //
                      //     //   image:  AssetImage("assets/Logo28-WB - Copy.png",),
                      //     // )
                      //   ),
                      //   child:
                      //
                      // ),
                      // Image(
                      //   image: AssetImage("assets/center_button.png"),
                      //   height: 160,
                      // ),
                  )
                ],
              ),
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
            onTap: (){
              if(productlist[SpinApi.random].name == 'Repeat'){

                setState(() {
                  SpinApi(dbProducts: widget.dbProducts).spinButtonClik().then((value){
                    selected.add(SpinApi.random);
                  });

                });

                playSpinSoundSpinSound();
                audioPlayer2.stop();

                // player.open(Audio.file("assets/spinsound_effect.mp.wav"));
                //  audioPlayer.stop();
                Navigator.pop(context);

              }else{

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Users(),

                  ),
                );
                audioPlayer2.stop();
                // audio_stopMusic();
                // player.stop();
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
                      if(productlist[SpinApi.random].name == "Voucher" && productlist[SpinApi.random].price == "100")
                        const Text("You won Amazon Gift Voucher\n Worth ₹100",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                letterSpacing: 1)),
                      if(productlist[SpinApi.random].name == "Voucher" && productlist[SpinApi.random].price == "200")
                        const Text("You Won Amazon Gift Voucher \n Worth ₹200",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                letterSpacing: 1)),
                      if(productlist[SpinApi.random].name == "Speaker")
                        const Text("You Won ZEBRONICS Bluetooth Speaker\n Worth ₹1000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                letterSpacing: 1)),
                      if(productlist[SpinApi.random].name == "Earbud")
                        const Text("You won Boult Audio Y1\n Worth ₹ 5499",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                letterSpacing: 1)),
                      if(productlist[SpinApi.random].name == "Watch")
                        const Text("You Won Fastrack Revoltt X Smartwatch \n Worth ₹3995",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                letterSpacing: 1)),
                      if(productlist[SpinApi.random].name == "Repeat")
                        const Text("It Seems Like Your Luck Is So Close.\n Spin Again",
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                                SpinApi(dbProducts: widget.dbProducts).spinButtonClik().then((value){
                                  selected.add(SpinApi.random);
                                });

                              });
                              playSpinSoundSpinSound();
                              audioPlayer2.stop();

                              // player.open(Audio.file("assets/spinsound_effect.mp.wav"));
                            //  audioPlayer.stop();
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
                              audioPlayer2.stop();
                              // audio_stopMusic();
                              // player.stop();
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

  badluckPopup(
      BuildContext context,
      ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: InkWell(
            onTap: (){

              audioPlayer1.stop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Users(),
                ),
              );
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
                      const Text(" Better Luck Next Time.",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
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
                            audioPlayer1.stop();
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
      },
    );
  }
}
