// To parse this JSON data, do
//
//     final createProductModel = createProductModelFromJson(jsonString);

import 'dart:convert';

import 'package:construction_technect/app/modules/ProductManagement/model/product_model.dart';


CreateProductModel createProductModelFromJson(String str) => CreateProductModel.fromJson(json.decode(str));

String createProductModelToJson(CreateProductModel data) => json.encode(data.toJson());

class CreateProductModel {
  final bool? success;
  final Product? data;
  final String? message;

  CreateProductModel({
    this.success,
    this.data,
    this.message,
  });

  factory CreateProductModel.fromJson(Map<String, dynamic> json) => CreateProductModel(
    success: json["success"],
    data: json["data"] == null ? null : Product.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

