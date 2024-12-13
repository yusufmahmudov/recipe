// To parse this JSON data, do
//
//     final servesModel = servesModelFromJson(jsonString);

import 'dart:convert';

ServesModel servesModelFromJson(String str) =>
    ServesModel.fromJson(json.decode(str));

String servesModelToJson(ServesModel data) => json.encode(data.toJson());

class ServesModel {
  final int? productId;
  final String? servesName;
  final String? servesBody;

  ServesModel({
    this.productId,
    this.servesName,
    this.servesBody,
  });

  factory ServesModel.fromJson(Map<String, dynamic> json) => ServesModel(
        productId: json["product_id"],
        servesName: json["serves_name"],
        servesBody: json["serves_body"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "serves_name": servesName,
        "serves_body": servesBody,
      };
}
