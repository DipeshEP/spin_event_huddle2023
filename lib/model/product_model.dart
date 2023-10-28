import 'package:flutter/material.dart';

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
// Cerulean Blue: #007BA7
// Emerald Green: #50C878
// Sunset Orange: #FD5E53
// Magenta Pink: #FF00FF
// Golden Yellow: #FFD700
// Purple Haze: #7D7C7C
// final List<Products> productlist = [
//   Products(
//     name: 'Cherry',
//     price: "100",
//     color: const Color(0xFF007BA7),
//   ),

//   Products(
//     name: 'Earbud',
//     price: "600",
//     color:  const Color(0xFFFD5E53),
//   ),
//    Products(
//     name: 'Wocher 200',
//     price: "200",
//     color: const Color(0xFF50C878),
//   ),
//   Products(
//     name: 'Watch',
//     price: "300",
//     color: const Color(0xFFED1F24),
//   ),
//   Products(
//     name: 'Cherry',
//     price: "400",
//     color: const Color(0xFFFFD700),
//   ),
//   Products(
//     name: 'Wocher 100',
//     price: "500",
//     color: const Color(0xFF7D7C7C),
//   ),

//   Products(
//     name: 'Cherry',
//     price: "700",
//     color:const Color(0xFF007BA7),
//   ),

//   Products(
//     name: 'Speaker',
//     price: "900",
//     color: const Color(0xFFFD5E53),
//   ),
//    Products(
//     name: 'Wocher 200',
//     price: "800",
//     color: const Color(0xFF50C878),
//   ),
//   Products(
//     name: 'Cherry',
//     price: "1000",
//     color:  const Color(0xFFED1F24),
//   ),
//   Products(
//     name: 'Wocher 100',
//     price: "1100",
//     color:  const Color(0xFFFFD700),
//   ),
//   Products(
//     name: 'Cap',
//     price: "1200",
//     color: const Color(0xFF7D7C7C),
//   ),
// ];

//***************** */
// final List<Products> productlist = [
//   Products(
//     name: 'Cherry',
//     price: "100",
//     color: const Color(0xFFED1F24),
//   ),
//   Products(
//     name: 'Wocher 200',
//     price: "200",
//     color: const Color(0xFF2776BB),
//   ),
//   Products(
//     name: 'Watch',
//     price: "300",
//     color: const Color(0xFF00E100),
//   ),
//   Products(
//     name: 'Cherry',
//     price: "400",
//     color: const Color(0xFFE1E100),
//   ),
//   Products(
//     name: 'Wocher 100',
//     price: "500",
//     color: const Color(0xFFED1F24),
//   ),
//   Products(
//     name: 'Earbud',
//     price: "600",
//     color:  const Color(0xFF2776BB),
//   ),
//   Products(
//     name: 'Cherry',
//     price: "700",
//     color: const Color(0xFF00E100),
//   ),
//   Products(
//     name: 'Wocher 200',
//     price: "800",
//     color: const Color(0xFFE1E100),
//   ),
//   Products(
//     name: 'Speaker',
//     price: "900",
//     color:const Color(0xFFED1F24),
//   ),
//   Products(
//     name: 'Cherry',
//     price: "1000",
//     color:  const Color(0xFF2776BB),
//   ),
//   Products(
//     name: 'Wocher 100',
//     price: "1100",
//     color: const Color(0xFF00E100),
//   ),
//   Products(
//     name: 'Cap',
//     price: "1200",
//     color: const Color(0xFFE1E100),
//   ),
// ];

//************** */
final List<Products> productlist = [
  Products(
    name: 'Cherry',
    price: "100",
    color: const Color(0xffE0115F),
    image: const AssetImage("assets/cherry.png"),
  ),
  Products(
    name: 'Wocher 200',
    price: "200",
    color: const Color(0xff0067A5),
    image: const AssetImage("assets/5.png"),
  ),
  Products(
    name: 'Watch',
    price: "300",
    color: const Color(0xff50C878),
    image: const AssetImage("assets/2.png"),
  ),
  Products(
    name: 'Cherry',
    price: "400",
    color: const Color(0xff9966CC),
    image: const AssetImage("assets/cherry.png"),
  ),
  Products(
    name: 'Wocher 100',
    price: "500",
    color: const Color(0xffFFD700),
    image: const AssetImage("assets/4.png"),
  ),
  Products(
    name: 'Earbud',
    price: "600",
    color: const Color(0xff40E0D0),
    image: const AssetImage("assets/1.png"),
  ),
  Products(
    name: 'Cherry',
    price: "700",
    color: const Color(0xffB76E79),
    image: const AssetImage("assets/cherry.png"),
  ),
  Products(
    name: 'Wocher 200',
    price: "800",
    color: const Color(0xffDC143C),
    image: const AssetImage("assets/5.png"),
  ),
  Products(
    name: 'Speaker',
    price: "900",
    color: const Color(0xff4B0082),
    image: const AssetImage("assets/3.png"),
  ),
  Products(
    name: 'Cherry',
    price: "1000",
    color: const Color(0xff98FF98),
    image: const AssetImage("assets/cherry.png"),
  ),
  Products(
    name: 'Wocher 100',
    price: "1100",
    color: const Color(0xffFF6F61),
    image: const AssetImage("assets/4.png"),
  ),
  Products(
    name: 'Repeat',
    price: "1200",
    color: const Color(0xffC0C0C0),
    image: const AssetImage("assets/repat.png"),
  ),
];