class UserModel {
  String uid;
  String? name;
  String? phone;

  UserModel({
    required this.uid,
    required this.name,
    required this.phone,
  });

  UserModel.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        name = map['name'],
        phone = map['phone'];

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
    };
  }
}
