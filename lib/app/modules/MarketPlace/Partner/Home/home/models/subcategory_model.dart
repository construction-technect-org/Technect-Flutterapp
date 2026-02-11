class FullSubCategoryModel {
  bool? success;
  List<SubCategoryData>? data;

  FullSubCategoryModel({this.success, this.data});

  FullSubCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SubCategoryData>[];
      json['data'].forEach((v) {
        data?.add(SubCategoryData.fromJson(v));
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

class SubCategoryData {
  String? id;
  String? categoryId;
  String? name;
  bool? isActive;
  int? sortOrder;
  String? createdAt;
  SubCategoryImage? image;
  String? updatedAt;

  SubCategoryData({
    this.id,
    this.categoryId,
    this.name,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.image,
    this.updatedAt,
  });

  SubCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    name = json['name'];
    isActive = json['isActive'];
    sortOrder = json['sortOrder'];
    createdAt = json['createdAt'];
    image = json['image'] != null
        ? SubCategoryImage.fromJson(json['image'])
        : null;
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
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

class SubCategoryImage {
  String? key;
  String? url;
  String? contentType;
  int? size;
  String? originalName;

  SubCategoryImage({
    this.key,
    this.url,
    this.contentType,
    this.size,
    this.originalName,
  });

  SubCategoryImage.fromJson(Map<String, dynamic> json) {
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
