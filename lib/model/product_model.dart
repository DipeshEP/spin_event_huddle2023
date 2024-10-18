import 'package:flutter/material.dart';
import 'package:spin_event_2023/const/image.dart';

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

enum ProductType<String> {repeat ,voucher, candy}



final List<Products> productlist = [
   Products(
    //0
    name: ProductType.repeat.name,
    price: "0",
    color: Colors.black,
    image: const AssetImage(reachoutLogo),
  ),
  Products(
    //1
    name: ProductType.voucher.name,
    price: "2000",
    color: const Color(0xffE0115F),
    image:  AssetImage(giftVoucher2000),
  ),
  Products(
    //2
    name: ProductType.voucher.name,
    price: "100",
    color: const Color(0xffFFD700),
    image:  AssetImage(giftVoucher100),
  ),
  Products(
    //3
    name: ProductType.candy.name,
    price: "0",
    color: const Color(0xff9966CC),
    image: const AssetImage(candy),
  ),
  Products(
    //4
    name: ProductType.voucher.name,
    price: "500",
    color: const Color(0xff4B0082),
    image:  AssetImage(giftVoucher500),
  ),
  Products(
    //5
    name: ProductType.voucher.name,
    price: "1000",
    color: const Color(0xffE0115F),
    // color: const Color(0xffFF6F61),
    image:  AssetImage(giftVoucher1000),
  ),
  Products(
    //6
    name: ProductType.candy.name,
    price: "0",
    color: const Color(0xffFFD700),
    // color: const Color(0xffB76E79),
    image:  AssetImage(candy),
  ),Products(
    //7
    name: ProductType.voucher.name,
    price: "200",
    color: const Color(0xff9966CC),
    image:  AssetImage(giftVoucher200),
  ),
 
];

