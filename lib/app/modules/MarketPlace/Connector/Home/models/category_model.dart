class CategoryResponse {
  final bool? success;
  final List<CCategory> data;

  CategoryResponse({
    this.success,
    required this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List?)
          ?.map((e) => CCategory.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class CCategory {
  final String? id;
  final String? mainCategoryId;
  final String? name;
  final bool? isActive;
  final int? sortOrder;
  final CategoryImage? image;
  final String? createdAt;
  final String? updatedAt;

  CCategory({
    this.id,
    this.mainCategoryId,
    this.name,
    this.isActive,
    this.sortOrder,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory CCategory.fromJson(Map<String, dynamic> json) {
    return CCategory(
      id: json['id'],
      mainCategoryId: json['mainCategoryId'],
      name: json['name'],
      isActive: json['isActive'],
      sortOrder: json['sortOrder'],
      image: json['image'] != null
          ? CategoryImage.fromJson(json['image'])
          : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mainCategoryId': mainCategoryId,
      'name': name,
      'isActive': isActive,
      'sortOrder': sortOrder,
      'image': image?.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class CategoryImage {
  final String? key;
  final String? url;
  final int? size;
  final String? contentType;
  final String? originalName;

  CategoryImage({
    this.key,
    this.url,
    this.size,
    this.contentType,
    this.originalName,
  });

  factory CategoryImage.fromJson(Map<String, dynamic> json) {
    return CategoryImage(
      key: json['key'],
      url: json['url'],
      size: json['size'],
      contentType: json['contentType'],
      originalName: json['originalName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'url': url,
      'size': size,
      'contentType': contentType,
      'originalName': originalName,
    };
  }
}