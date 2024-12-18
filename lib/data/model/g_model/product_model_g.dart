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
  final String? categoryName;
  final int? userId;
  final int? ingredientCount;

  ProductModelG({
    this.name,
    this.portion,
    this.time,
    this.categoryId,
    this.categoryName,
    this.userId,
    this.ingredientCount,
  });

  factory ProductModelG.fromJson(Map<String, dynamic> json) => ProductModelG(
      name: json["name"],
      portion: json["portion"],
      time: json["time"],
      categoryId: json["category_id"],
      categoryName: json["category_name"],
      userId: json["user_id"],
      ingredientCount: json["ingredient_count"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "portion": portion,
        "time": time,
        "category_id": categoryId,
        "category_name": categoryName,
        "user_id": userId,
        "ingredient_count": ingredientCount,
      };
}
