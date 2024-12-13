// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

import 'dart:convert';

CategoryModelG modelFromJson(String str) =>
    CategoryModelG.fromJson(json.decode(str));

String modelToJson(CategoryModelG data) => json.encode(data.toJson());

class CategoryModelG {
  final String? name;

  CategoryModelG({
    this.name,
  });

  factory CategoryModelG.fromJson(Map<String, dynamic> json) => CategoryModelG(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
