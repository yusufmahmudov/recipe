// To parse this JSON data, do
//
//     final usersG = usersGFromJson(jsonString);

import 'dart:convert';

UserModelG usersGFromJson(String str) => UserModelG.fromJson(json.decode(str));

String usersGToJson(UserModelG data) => json.encode(data.toJson());

class UserModelG {
  final String? name;
  final String? phone;
  final String? password;
  final String? salt;

  UserModelG({
    this.name,
    this.phone,
    this.password,
    this.salt,
  });

  factory UserModelG.fromJson(Map<String, dynamic> json) => UserModelG(
        name: json["name"],
        phone: json["phone"],
        password: json["password"],
        salt: json["salt"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "password": password,
        "salt": salt,
      };
}
