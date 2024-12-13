// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  final int? id;
  final String? name;
  final String? phone;
  final String? password;
  final String? salt;
  final DateTime? createdAt;

  Users({
    this.id,
    this.name,
    this.phone,
    this.password,
    this.salt,
    this.createdAt,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        password: json["password"],
        salt: json["salt"],
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "password": password,
        "salt": salt,
      };
}
