class DBProducts {
  DBProducts({
    required this.count,
    required this.is_claim,
    

    required this.image,
    required this.prize,
    required this.productname,
  });
  late String count;
  late String is_claim;
  late String image;
  late String prize;
  late String productname;

  DBProducts.fromJson(Map<String, dynamic> json) {
    count = json['count'] ?? 0;
    is_claim=json['isClaim']??false;
    image = json['proImage'] ?? '';
    prize = json['price'] ?? 0;
    productname = json['proName'] ?? '';
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['count'] = count;
    data['isClaim']=is_claim;
    data['proImage'] = image;
    data['price'] = prize;
    data['proName'] = productname;
    return data;
  }
}
