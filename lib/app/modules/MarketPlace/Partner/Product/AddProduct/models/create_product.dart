import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';

class CreateProductModel {
  final bool? success;
  final Product? data;
  final String? message;

  CreateProductModel({this.success, this.data, this.message});

  factory CreateProductModel.fromJson(Map<String, dynamic> json) =>
      CreateProductModel(
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
