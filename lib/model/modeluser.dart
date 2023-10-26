class User {
  User({
    required this.name,
    required this.email,
    required this.image,
    this.isSpin,
    this.spinTime,
    this.usId,
    this.phone,
  });
  String? name;
  String? email;
  String? image;
  bool? isSpin;
  String? spinTime;
  String? usId;
  String? phone;

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    image = json['image'] ?? '';

    isSpin = json['is_spin'] ?? false;
    spinTime = json['spin_time'] ?? '';
    usId = json['id'] ?? '';
    phone = json['phone'] ?? '';
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;

    data['is_spin'] = isSpin;
    data['spin_time'] = spinTime;
    data['id'] = usId;
    data['phone'] = phone;

    return data;
  }
}
