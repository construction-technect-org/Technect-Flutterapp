class SubCategoryItemResponse {
  final bool? success;
  final List<SubCategoryItem>? data;

  SubCategoryItemResponse({
    this.success,
    this.data,
  });

  factory SubCategoryItemResponse.fromJson(Map<String, dynamic> json) {
    return SubCategoryItemResponse(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? (json['data'] as List)
          .map((e) => SubCategoryItem.fromJson(e))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class SubCategoryItem {
  final String? id;
  final String? subCategoryId;
  final String? name;
  final bool? isActive;
  final int? sortOrder;
  final SubCategoryItemImage? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SubCategoryItem({
    this.id,
    this.subCategoryId,
    this.name,
    this.isActive,
    this.sortOrder,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategoryItem.fromJson(Map<String, dynamic> json) {
    return SubCategoryItem(
      id: json['id'] as String?,
      subCategoryId: json['subCategoryId'] as String?,
      name: json['name'] as String?,
      isActive: json['isActive'] as bool?,
      sortOrder: json['sortOrder'] as int?,
      image: json['image'] != null
          ? SubCategoryItemImage.fromJson(json['image'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subCategoryId': subCategoryId,
      'name': name,
      'isActive': isActive,
      'sortOrder': sortOrder,
      'image': image?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class SubCategoryItemImage {
  final String? key;
  final String? url;
  final int? size;
  final String? contentType;
  final String? originalName;

  SubCategoryItemImage({
    this.key,
    this.url,
    this.size,
    this.contentType,
    this.originalName,
  });

  factory SubCategoryItemImage.fromJson(Map<String, dynamic> json) {
    return SubCategoryItemImage(
      key: json['key'] as String?,
      url: json['url'] as String?,
      size: json['size'] as int?,
      contentType: json['contentType'] as String?,
      originalName: json['originalName'] as String?,
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