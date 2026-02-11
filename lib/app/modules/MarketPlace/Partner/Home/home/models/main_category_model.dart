class MainCategoryModel {
  bool? success;
  List<MainCategoryData>? data;

  MainCategoryModel({this.success, this.data});

  MainCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <MainCategoryData>[];
      json['data'].forEach((v) {
        data?.add(MainCategoryData.fromJson(v));
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

class MainCategoryData {
  String? id;
  String? moduleId;
  String? name;
  bool? isActive;
  int? sortOrder;
  String? createdAt;
  MainCategoryImage? image;
  String? updatedAt;

  MainCategoryData({
    this.id,
    this.moduleId,
    this.name,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.image,
    this.updatedAt,
  });

  MainCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleId = json['moduleId'];
    name = json['name'];
    isActive = json['isActive'];
    sortOrder = json['sortOrder'];
    createdAt = json['createdAt'];
    image = json['image'] != null
        ? MainCategoryImage.fromJson(json['image'])
        : null;
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['moduleId'] = this.moduleId;
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

class MainCategoryImage {
  String? key;
  String? url;
  String? contentType;
  int? size;
  String? originalName;

  MainCategoryImage({
    this.key,
    this.url,
    this.contentType,
    this.size,
    this.originalName,
  });

  MainCategoryImage.fromJson(Map<String, dynamic> json) {
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
