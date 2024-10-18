//  import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:spin_event_2023/controller/spin_api.dart';
// import 'package:spin_event_2023/model/product_model.dart';

// AlertDialog afterpopup(List<Products> productlist, BuildContext context) {
//     return AlertDialog(
//         backgroundColor: Colors.transparent,
//         content: InkWell(
//           onTap: () {
//             if (productlist[SpinApi.random].name == ProductType.repeat.name) {
//               setState(() {
//                 SpinApi(dbProducts: widget.dbProducts)
//                     .spinButtonClik()
//                     .then((value) {
//                   selected.add(SpinApi.random);
//                 });
//               });
              
//               audioPlayer.stop();
//               playSpinSoundSpinSound();
             
//               Navigator.pop(context);
//             } else {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => Users(),
//                 ),
//               );
//               audioPlayer.stop();

//             }
//           },
//           child: GlassmorphicContainer(
//             height: 550,
//             width: 500,
//             alignment: Alignment.center,
//             border: 2,
//             linearGradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.white.withOpacity(0.1),
//                 Colors.white.withOpacity(0.1),
//               ],
//             ),
//             borderGradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.white.withOpacity(0.1),
//                 Colors.white.withOpacity(0.1),
//               ],
//             ),
//             blur: 2,
//             borderRadius: 20,
//             child: Stack(
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     const Text(
//                       "Congratulations !",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 30,
//                           letterSpacing: 1),
//                     ),
//                     Image(
//                       image: productlist[SpinApi.random].image,
//                       height: 180,
//                     ),
//                     if (productlist[SpinApi.random].name == "Voucher" &&
//                         productlist[SpinApi.random].price == "100")
//                       const Text("You won Amazon Gift Voucher\n Worth ₹100",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 20,
//                               letterSpacing: 1)),
//                     if (productlist[SpinApi.random].name == "Voucher" &&
//                         productlist[SpinApi.random].price == "200")
//                       const Text("You Won Amazon Gift Voucher \n Worth ₹200",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 20,
//                               letterSpacing: 1)),
//                     if (productlist[SpinApi.random].name == "Speaker")
//                       const Text(
//                           "You Won ZEBRONICS Bluetooth Speaker\n Worth ₹1000",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 20,
//                               letterSpacing: 1)),
//                     if (productlist[SpinApi.random].name == "Earbud")
//                       const Text("You won Boult Audio Y1\n Worth ₹ 5500",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 20,
//                               letterSpacing: 1)),
//                     if (productlist[SpinApi.random].name == "Watch")
//                       const Text(
//                           "You Won BeatXp Marv Neo Smartwatch \n Worth ₹6500",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 20,
//                               letterSpacing: 1)),
//                     if (productlist[SpinApi.random].name == "Repeat")
//                       const Text(
//                           "It Seems Like Your Luck Is So Close.\n Spin Again",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 20,
//                               letterSpacing: 1)),
//                     Center(
//                       child: productlist[SpinApi.random].name == 'Repeat'
//                           ? OutlinedButton(
//                               style: OutlinedButton.styleFrom(
//                                 backgroundColor: Colors.grey.shade100,
//                                 elevation: 10,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   SpinApi(dbProducts: widget.dbProducts)
//                                       .spinButtonClik()
//                                       .then((value) {
//                                     selected.add(SpinApi.random);
//                                   });
//                                 });
//                                 playSpinSoundSpinSound();
//                                 audioPlayer2.stop();

//                                 // player.open(Audio.file("assets/spinsound_effect.mp.wav"));
//                                 //  audioPlayer.stop();
//                                 Navigator.pop(context);
//                               },
//                               child: const Text(
//                                 "Repeat",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w600),
//                               ))
//                           : OutlinedButton(
//                               style: OutlinedButton.styleFrom(
//                                 backgroundColor: Colors.grey.shade100,
//                                 elevation: 10,
//                               ),
//                               onPressed: () {
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                     builder: (context) => Users(),
//                                   ),
//                                 );
//                                 audioPlayer2.stop();
//                                 // audio_stopMusic();
//                                 // player.stop();
//                               },
//                               child: const Text(
//                                 "Ok",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w600),
//                               )),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//   }