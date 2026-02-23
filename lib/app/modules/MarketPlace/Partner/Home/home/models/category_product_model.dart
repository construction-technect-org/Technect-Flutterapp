class CategoryProductModel {
  bool? success;
  List<CategoryProductData>? data;

  CategoryProductModel({this.success, this.data});

  CategoryProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CategoryProductData>[];
      json['data'].forEach((v) {
        data?.add(CategoryProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryProductData {
  String? id;
  String? subCategoryId;
  String? name;
  bool? isActive;
  int? sortOrder;
  String? createdAt;
  CategoryProductImage? image;
  List<String>? images;
  String? categoryName;
  String? price;
  String? unit;
  String? updatedAt;

  CategoryProductData({
    this.id,
    this.subCategoryId,
    this.name,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.image,
    this.images,
    this.categoryName,
    this.price,
    this.unit,
    this.updatedAt,
  });

  CategoryProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCategoryId = json['subCategoryId'];
    name = json['name'];
    isActive = json['isActive'];
    sortOrder = json['sortOrder'];
    createdAt = json['createdAt'];
    image = json['image'] != null ? CategoryProductImage.fromJson(json['image']) : null;
    if (json['images'] != null) {
      images = List<String>.from(json['images']);
    } else if (image?.url != null) {
      images = [image!.url!];
    }
    categoryName = json['categoryName'];
    price = json['price']?.toString();
    unit = json['unit'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subCategoryId'] = subCategoryId;
    data['name'] = name;
    data['isActive'] = isActive;
    data['sortOrder'] = sortOrder;
    data['createdAt'] = createdAt;
    if (image != null) {
      data['image'] = image?.toJson();
    }
    data['images'] = images;
    data['categoryName'] = categoryName;
    data['price'] = price;
    data['unit'] = unit;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class CategoryProductImage {
  String? key;
  String? url;
  String? contentType;
  int? size;
  String? originalName;

  CategoryProductImage({this.key, this.url, this.contentType, this.size, this.originalName});

  CategoryProductImage.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    url = json['url'];
    contentType = json['contentType'];
    size = json['size'];
    originalName = json['originalName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['url'] = url;
    data['contentType'] = contentType;
    data['size'] = size;
    data['originalName'] = originalName;
    return data;
  }
}
