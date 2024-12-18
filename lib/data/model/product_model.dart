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
  final String? categoryName;
  final int? userId;
  final int? ingredientCount;

  String? imageUrl;

  ProductModel({
    this.id,
    this.name,
    this.portion,
    this.time,
    this.categoryId,
    this.categoryName,
    this.userId,
    this.imageUrl,
    this.ingredientCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json["id"],
      name: json["name"],
      portion: json["portion"],
      time: json["time"],
      categoryId: json["category_id"],
      categoryName: json["category_name"],
      userId: json["user_id"],
      imageUrl: json["image_url"],
      ingredientCount: json["ingredient_count"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "portion": portion,
        "time": time,
        "category_id": categoryId,
        "category_name": categoryName,
        "user_id": userId,
        "image_url": imageUrl,
        "ingredient_count": ingredientCount,
      };
}
