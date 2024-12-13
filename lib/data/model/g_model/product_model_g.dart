// To parse this JSON data, do
//
//     final productModelG = productModelGFromJson(jsonString);

import 'dart:convert';

ProductModelG productModelGFromJson(String str) =>
    ProductModelG.fromJson(json.decode(str));

String productModelGToJson(ProductModelG data) => json.encode(data.toJson());

class ProductModelG {
  final String? name;
  final int? portion;
  final String? time;
  final int? categoryId;
  final int? userId;

  ProductModelG({
    this.name,
    this.portion,
    this.time,
    this.categoryId,
    this.userId,
  });

  factory ProductModelG.fromJson(Map<String, dynamic> json) => ProductModelG(
        name: json["name"],
        portion: json["portion"],
        time: json["time"],
        categoryId: json["category_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "portion": portion,
        "time": time,
        "category_id": categoryId,
        "user_id": userId,
      };
}
