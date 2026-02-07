class FullCategoryModel {
  bool? success;
  List<FullCategoryData>? data;

  FullCategoryModel({this.success, this.data});

  FullCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <FullCategoryData>[];
      json['data'].forEach((v) {
        data?.add(FullCategoryData.fromJson(v));
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

class FullCategoryData {
  String? id;
  String? mainCategoryId;
  String? name;
  bool? isActive;
  int? sortOrder;
  String? createdAt;
  CategoryImage? image;
  String? updatedAt;

  FullCategoryData({
    this.id,
    this.mainCategoryId,
    this.name,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.image,
    this.updatedAt,
  });

  FullCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainCategoryId = json['mainCategoryId'];
    name = json['name'];
    isActive = json['isActive'];
    sortOrder = json['sortOrder'];
    createdAt = json['createdAt'];
    image = json['image'] != null
        ? CategoryImage.fromJson(json['image'])
        : null;
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['mainCategoryId'] = this.mainCategoryId;
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

class CategoryImage {
  String? key;
  String? url;
  String? contentType;
  int? size;
  String? originalName;

  CategoryImage({
    this.key,
    this.url,
    this.contentType,
    this.size,
    this.originalName,
  });

  CategoryImage.fromJson(Map<String, dynamic> json) {
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
