import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';

class ProductDetailsModel {
  bool? success;
  String? message;
  Data? data;

  ProductDetailsModel({this.success, this.message, this.data});

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Product? product;
  List<Product>? similarProducts;

  Data({this.product, this.similarProducts});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    similarProducts: json["similar_products"] == null
        ? []
        : List<Product>.from(json["similar_products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "similar_products": similarProducts == null
        ? []
        : List<dynamic>.from(similarProducts!.map((x) => x.toJson())),
  };
}
