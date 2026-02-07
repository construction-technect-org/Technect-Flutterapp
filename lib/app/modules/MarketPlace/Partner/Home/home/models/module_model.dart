class ModuleModel {
  bool? success;
  ModuleData? data;

  ModuleModel({this.success, this.data});

  ModuleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? ModuleData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class ModuleData {
  List<Modules>? modules;

  ModuleData({this.modules});

  ModuleData.fromJson(Map<String, dynamic> json) {
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules?.add(Modules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.modules != null) {
      data['modules'] = this.modules?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Modules {
  String? id;
  String? name;
  bool? isActive;
  int? sortOrder;
  String? moduleFor;
  ModuleImage? image;
  String? createdAt;
  String? updatedAt;

  Modules({
    this.id,
    this.name,
    this.isActive,
    this.sortOrder,
    this.moduleFor,
    this.createdAt,
    this.updatedAt,
  });

  Modules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'];
    sortOrder = json['sortOrder'];
    moduleFor = json['moduleFor'];
    image = json['image'] != null ? ModuleImage.fromJson(json['image']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['isActive'] = this.isActive;
    data['sortOrder'] = this.sortOrder;
    data['moduleFor'] = this.moduleFor;
    if (this.image != null) {
      data['image'] = this.image?.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ModuleImage {
  String? key;
  String? url;
  String? contentType;
  int? size;
  String? originalName;

  ModuleImage({
    this.key,
    this.url,
    this.contentType,
    this.size,
    this.originalName,
  });

  ModuleImage.fromJson(Map<String, dynamic> json) {
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
