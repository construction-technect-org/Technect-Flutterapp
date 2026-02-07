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
    data['success'] = this.success;
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
  String? updatedAt;

  CategoryProductData({
    this.id,
    this.subCategoryId,
    this.name,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.image,
    this.updatedAt,
  });

  CategoryProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCategoryId = json['subCategoryId'];
    name = json['name'];
    isActive = json['isActive'];
    sortOrder = json['sortOrder'];
    createdAt = json['createdAt'];
    image = json['image'] != null
        ? CategoryProductImage.fromJson(json['image'])
        : null;
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['subCategoryId'] = this.subCategoryId;
    data['name'] = this.name;
    data['isActive'] = this.isActive;
    data['sortOrder'] = this.sortOrder;
    data['createdAt'] = this.createdAt;
    if (this.image != null) {
      data['image'] = this.image?.toJson();
    }
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class CategoryProductImage {
  String? key;
  String? url;
  String? contentType;
  int? size;
  String? originalName;

  CategoryProductImage({
    this.key,
    this.url,
    this.contentType,
    this.size,
    this.originalName,
  });

  CategoryProductImage.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    url = json['url'];
    contentType = json['contentType'];
    size = json['size'];
    originalName = json['originalName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = this.key;
    data['url'] = this.url;
    data['contentType'] = this.contentType;
    data['size'] = this.size;
    data['originalName'] = this.originalName;
    return data;
  }
}
