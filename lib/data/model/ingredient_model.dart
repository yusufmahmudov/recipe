// To parse this JSON data, do
//
//     final ingredientModel = ingredientModelFromJson(jsonString);

import 'dart:convert';

IngredientModel ingredientModelFromJson(String str) =>
    IngredientModel.fromJson(json.decode(str));

String ingredientModelToJson(IngredientModel data) =>
    json.encode(data.toJson());

class IngredientModel {
  final int? productId;
  final String? quantity;
  final String? ingredient;

  IngredientModel({
    this.productId,
    this.quantity,
    this.ingredient,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      IngredientModel(
        productId: json["product_id"],
        quantity: json["quantity"],
        ingredient: json["ingredient"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        "ingredient": ingredient,
      };
}
