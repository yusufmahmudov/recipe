// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final int? id;
  final String? name;
  final int? portion;
  final String? time;
  final int? categoryId;
  final int? userId;

  ProductModel({
    this.id,
    this.name,
    this.portion,
    this.time,
    this.categoryId,
    this.userId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        portion: json["portion"],
        time: json["time"],
        categoryId: json["category_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "portion": portion,
        "time": time,
        "category_id": categoryId,
        "user_id": userId,
      };
}
