class MarketplaceProductsResponse {
  final bool success;
  final List<MarketplaceProduct> data;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  MarketplaceProductsResponse({
    required this.success,
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory MarketplaceProductsResponse.fromJson(Map<String, dynamic> json) {
    return MarketplaceProductsResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => MarketplaceProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 20,
      totalPages: json['totalPages'] ?? 0,
    );
  }
}

class MarketplaceProduct {
  final String id;
  final String merchantProfileId;
  final String categoryProductId;
  final String inventoryType;
  final String inventorySKU;
  final String name;
  final String brand;
  final String? description;
  final List<MarketplaceProductImage>? images;
  final List<dynamic>? videos;
  final String price;
  final String gstPercentage;
  final String gstAmount;
  final String finalPrice;
  final int stock;
  final bool isAvailable;
  final String approvalStatus;
  final String status;
  final String? comment;

  MarketplaceProduct({
    required this.id,
    required this.merchantProfileId,
    required this.categoryProductId,
    required this.inventoryType,
    required this.inventorySKU,
    required this.name,
    required this.brand,
    this.description,
    this.images,
    this.videos,
    required this.price,
    required this.gstPercentage,
    required this.gstAmount,
    required this.finalPrice,
    required this.stock,
    required this.isAvailable,
    required this.approvalStatus,
    required this.status,
    this.comment,
  });

  factory MarketplaceProduct.fromJson(Map<String, dynamic> json) {
    return MarketplaceProduct(
      id: json['id'] ?? '',
      merchantProfileId: json['merchantProfileId'] ?? '',
      categoryProductId: json['categoryProductId'] ?? '',
      inventoryType: json['inventoryType'] ?? '',
      inventorySKU: json['inventorySKU'] ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      description: json['description'],
      images: json['images'] != null
          ? (json['images'] as List).map((i) => MarketplaceProductImage.fromJson(i)).toList()
          : null,
      videos: json['videos'] as List<dynamic>?,
      price: json['price']?.toString() ?? '0.0',
      gstPercentage: json['gstPercentage']?.toString() ?? '0.0',
      gstAmount: json['gstAmount']?.toString() ?? '0.0',
      finalPrice: json['finalPrice']?.toString() ?? '0.0',
      stock: json['stock'] ?? 0,
      isAvailable: json['isAvailable'] ?? false,
      approvalStatus: json['approvalStatus'] ?? '',
      status: json['status'] ?? '',
      comment: json['comment'],
    );
  }
}

class MarketplaceProductImage {
  final String key;
  final String url;
  final int size;
  final String contentType;
  final String originalName;

  MarketplaceProductImage({
    required this.key,
    required this.url,
    required this.size,
    required this.contentType,
    required this.originalName,
  });

  factory MarketplaceProductImage.fromJson(Map<String, dynamic> json) {
    return MarketplaceProductImage(
      key: json['key'] ?? '',
      url: json['url'] ?? '',
      size: json['size'] ?? 0,
      contentType: json['contentType'] ?? '',
      originalName: json['originalName'] ?? '',
    );
  }
}
