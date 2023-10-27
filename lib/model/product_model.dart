class Products {
  late String name;
  late String price;

  Products({
    required this.name,
    required this.price,
  });
}

final List<Products> productlist = [
  Products(name: 'Cherry', price: "100"),
  Products(name: 'Wocher 200', price: "200"),
  Products(name: 'Watch', price: "300"),
  Products(name: 'Cherry', price: "400"),
  Products(name: 'Wocher 100', price: "500"),
  Products(name: 'Earbud', price: "600"),
  Products(name: 'Cherry', price: "700"),
  Products(name: 'Wocher 200', price: "800"),
  Products(name: 'Speaker', price: "900"),
  Products(name: 'Cherry', price: "1000"),
  Products(name: 'Wocher 100', price: "1100"),
  Products(name: 'Cap', price: "1200"),
];
