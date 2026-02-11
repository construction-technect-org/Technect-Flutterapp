class ModulesResponse {
  final bool? success;
  final ModulesData? data;

  ModulesResponse({
    this.success,
    this.data,
  });

  factory ModulesResponse.fromJson(Map<String, dynamic> json) {
    return ModulesResponse(
      success: json['success'],
      data: json['data'] != null
          ? ModulesData.fromJson(json['data'])
          : null,
    );
  }
}

// ---------------- DATA ----------------

class ModulesData {
  final List<ModuleModel>? modules;

  ModulesData({this.modules});

  factory ModulesData.fromJson(Map<String, dynamic> json) {
    return ModulesData(
      modules: json['modules'] != null
          ? List<ModuleModel>.from(
        json['modules'].map((x) => ModuleModel.fromJson(x)),
      )
          : [],
    );
  }
}

// ---------------- MODULE ----------------

class ModuleModel {
  final String? id;
  final String? name;
  final bool? isActive;
  final int? sortOrder;
  final String? moduleFor;
  final String? createdAt;
  final String? updatedAt;
  final ModuleImage? image;

  ModuleModel({
    this.id,
    this.name,
    this.isActive,
    this.sortOrder,
    this.moduleFor,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) {
    return ModuleModel(
      id: json['id'],
      name: json['name'],
      isActive: json['isActive'],
      sortOrder: json['sortOrder'],
      moduleFor: json['moduleFor'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      image:
      json['image'] != null ? ModuleImage.fromJson(json['image']) : null,
    );
  }
}

// ---------------- IMAGE ----------------

class ModuleImage {
  final String? key;
  final String? url;
  final String? contentType;
  final int? size;
  final String? originalName;

  ModuleImage({
    this.key,
    this.url,
    this.contentType,
    this.size,
    this.originalName,
  });

  factory ModuleImage.fromJson(Map<String, dynamic> json) {
    return ModuleImage(
      key: json['key'],
      url: json['url'],
      contentType: json['contentType'],
      size: json['size'],
      originalName: json['originalName'],
    );
  }
}
