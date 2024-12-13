// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

FavoriteModel favoriteModelFromJson(String str) =>
    FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  final int? productId;
  final int? userId;

  FavoriteModel({
    this.productId,
    this.userId,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        productId: json["product_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "user_id": userId,
      };
}
