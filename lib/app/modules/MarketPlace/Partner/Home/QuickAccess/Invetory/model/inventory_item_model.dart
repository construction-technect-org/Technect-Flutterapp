// Model for /v1/api/marketplace/inventory/products API response
// Used for displaying the list of merchant inventory items

import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:intl/intl.dart';

class InventoryListResponse {
  final bool? success;
  final List<InventoryItem>? data;
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPages;

  InventoryListResponse({
    this.success,
    this.data,
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory InventoryListResponse.fromJson(Map<String, dynamic> json) => InventoryListResponse(
    success: json["success"],
    data: json["data"] == null
        ? []
        : List<InventoryItem>.from(json["data"].map((x) => InventoryItem.fromJson(x))),
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
  );
}

class InventoryItem {
  final String? id;
  final String? merchantProfileId;
  final String? categoryProductId;
  final Map<String, dynamic>? categoryProduct;
  final String? inventoryType;
  final String? inventorySKU;
  final Map<String, dynamic>? productDetails;
  final String? name;
  final String? brand;
  final String? description;
  final List<ProductImage>? images;
  final List<dynamic>? videos;
  final String? price;
  final String? gstPercentage;
  final String? gstAmount;
  final String? finalPrice;
  final int? stock;
  final bool? isAvailable;
  final String? approvalStatus;
  final String? status;
  final String? comment;
  final String? createdAt;
  final String? updatedAt;

  InventoryItem({
    this.id,
    this.merchantProfileId,
    this.categoryProductId,
    this.categoryProduct,
    this.inventoryType,
    this.inventorySKU,
    this.productDetails,
    this.name,
    this.brand,
    this.description,
    this.images,
    this.videos,
    this.price,
    this.gstPercentage,
    this.gstAmount,
    this.finalPrice,
    this.stock,
    this.isAvailable,
    this.approvalStatus,
    this.status,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) => InventoryItem(
    id: json["id"],
    merchantProfileId: json["merchantProfileId"],
    categoryProductId: json["categoryProductId"],
    categoryProduct: json["categoryProduct"],
    inventoryType: json["inventoryType"],
    inventorySKU: json["inventorySKU"],
    productDetails: json["productDetails"],
    name: json["name"],
    brand: json["brand"],
    description: json["description"],
    images: json["images"] == null
        ? []
        : List<ProductImage>.from(json["images"].map((x) => ProductImage.fromJson(x))),
    videos: json["videos"] == null ? [] : List<dynamic>.from(json["videos"].map((x) => x)),
    price: json["price"],
    gstPercentage: json["gstPercentage"],
    gstAmount: json["gstAmount"],
    finalPrice: json["finalPrice"],
    stock: json["stock"],
    isAvailable: json["isAvailable"],
    approvalStatus: json["approvalStatus"],
    status: json["status"],
    comment: json["comment"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  String get formattedPrice =>
      "₹${double.tryParse(finalPrice ?? '0')?.toStringAsFixed(2) ?? '0.00'}";

  String get categoryProductName => (categoryProduct?['name'] as String?) ?? '';

  String get formattedDate {
    if (createdAt == null) return '';
    try {
      final dt = DateTime.parse(createdAt!);
      return DateFormat('dd MMM yyyy, hh:mm a').format(dt);
    } catch (_) {
      return '';
    }
  }

  bool get isApproved => approvalStatus == 'approved';
  bool get isPending => approvalStatus == 'pending';
  bool get isRejected => approvalStatus == 'rejected';

  Product toProduct() {
    return Product(
      id: id,
      productName: name,
      brand: brand,
      images: images,
      price: price,
      gstPercentage: gstPercentage,
      gstAmount: gstAmount,
      totalAmount: finalPrice,
      stockQty: stock,
      approvalStatus: approvalStatus,
      status: status,
      productVideo: videos != null && videos!.isNotEmpty ? videos!.first.toString() : null,
      merchantProfileId: int.tryParse(merchantProfileId ?? ""),
    );
  }
}
