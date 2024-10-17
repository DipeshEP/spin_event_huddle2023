import 'package:flutter/material.dart';
import 'package:spin_event_2023/const/animation.dart';

class Products {
  late String name;
  late String price;
  late Color color;
  late AssetImage image;

  Products({
    required this.name,
    required this.price,
    required this.color,
    required this.image,
  });
}


final List<Products> productlist = [
  Products(
    name: 'Voucher',
    price: "100",
    color: const Color(0xffE0115F),
    image: const AssetImage(Voucher2000),
    // image: const AssetImage("assets/voucherOne.png"),
  ),
  Products(
    name: 'Voucher',
    price: "200",
    color: const Color(0xffFFD700),
    image: const AssetImage(Voucher100),
    // image: const AssetImage("assets/voucherTwo.png"),
  ),
  Products(
    name: 'Cherry',
    price: "400",
    color: const Color(0xff9966CC),
    image: const AssetImage("assets/images (1) (1).png"),
  ),
  Products(
    name: 'Voucher',
    price: "100",
    color: const Color(0xff4B0082),
    image: const AssetImage(Voucher500),
    // image: const AssetImage("assets/voucherOne.png"),
  ),
  Products(
    name: 'Voucher',
    price: "100",
    color: const Color(0xffE0115F),
    // color: const Color(0xffFF6F61),
    image: const AssetImage(Voucher1000),
    // image: const AssetImage("assets/voucherOne.png"),
  ),

  Products(
    name: 'Cherry',
    price: "100",
    color: const Color(0xffFFD700),
    // color: const Color(0xffB76E79),
    image: const AssetImage("assets/images (1) (1).png"),
  ),Products(
    name: 'Voucher',
    price: "100",
    color: const Color(0xff9966CC),
    // color: const Color(0xff0067A5),
    image: const AssetImage(Voucher200),
    // image: const AssetImage("assets/voucherOne.png"),
  ),
  Products(
    name: 'Repeat',
    price: "1200",
    color: Colors.black,
    image: const AssetImage("assets/Logo28-WB - Copy.png"),
  ),
];


// final List<Products> productlist = [
//   Products(
//     name: 'Cherry',
//     price: "100",
//     color: const Color(0xff0067A5),
//     image: const AssetImage("assets/images (1) (1).png"),
//   ),
//   Products(
//     name: 'Voucher',
//     price: "100",
//     color: const Color(0xffE0115F),
//     image: const AssetImage("assets/voucherOne.png"),
//   ),
//   Products(
//     name: 'Watch',
//     price: "300",
//     color: const Color(0xff50C878),
//     image: const AssetImage("assets/4-6-bxio2003-bxsm2003-bxsm2001-android-ios-beatxp-yes-original-imaguyfzcesjgfrr (1).png"),
//   ),
//   Products(
//     name: 'Cherry',
//     price: "400",
//     color: const Color(0xff9966CC),
//     image: const AssetImage("assets/images (1) (1).png"),
//   ),
//   Products(
//     name: 'Voucher',
//     price: "200",
//     color: const Color(0xffFFD700),
//     image: const AssetImage("assets/voucherTwo.png"),
//   ),
//   Products(
//     name: 'Earbud',
//     price: "600",
//     color: const Color(0xff40E0D0),
//     image:  AssetImage("assets/earpodOne.png",),
//   ),
//   Products(
//     name: 'Cherry',
//     price: "700",
//     color: const Color(0xffB76E79),
//     image: const AssetImage("assets/images (1) (1).png"),
//   ),
//   Products(
//     name: 'Voucher',
//     price: "100",
//     color: const Color(0xff4B0082),
//     image: const AssetImage("assets/voucherOne.png"),
//   ),
//   Products(
//     name: 'Speaker',
//     price: "900",
//     color: const Color(0xffDC143C),
//     image: const AssetImage("assets/3.png"),
//   ),
//   Products(
//     name: 'Cherry',
//     price: "1000",
//     color: const Color(0xff98FF98),
//     image: const AssetImage("assets/images (1) (1).png"),
//   ),
//   Products(
//     name: 'Voucher',
//     price: "100",
//     color: const Color(0xffFF6F61),
//     image: const AssetImage("assets/voucherOne.png"),
//   ),
//   Products(
//     name: 'Repeat',
//     price: "1200",
//     color:  Colors.black,
//     image: const AssetImage("assets/Logo28-WB - Copy.png"),
//   ),
// ];
