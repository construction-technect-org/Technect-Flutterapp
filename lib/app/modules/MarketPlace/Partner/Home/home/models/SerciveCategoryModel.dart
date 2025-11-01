class ServiceCategoryModel {
  bool? success;
  String? message;
  List<ServiceCategoryData>? data;
  Counts? counts;

  ServiceCategoryModel({this.success, this.message, this.data, this.counts});

  ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ServiceCategoryData>[];
      json['data'].forEach((v) {
        data!.add(ServiceCategoryData.fromJson(v));
      });
    }
    counts =
    json['counts'] != null ? Counts.fromJson(json['counts']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (counts != null) {
      data['counts'] = counts!.toJson();
    }
    return data;
  }
}

class ServiceCategoryData {
  int? id;
  String? name;
  String? description;
  int? sortOrder;
  List<ServicesSubCategories>? subCategories;

  ServiceCategoryData(
      {this.id,
        this.name,
        this.description,
        this.sortOrder,
        this.subCategories});

  ServiceCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    sortOrder = json['sort_order'];
    if (json['sub_categories'] != null) {
      subCategories = <ServicesSubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(ServicesSubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['sort_order'] = sortOrder;
    if (subCategories != null) {
      data['sub_categories'] =
          subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServicesSubCategories {
  int? id;
  int? mainCategoryId;
  String? name;
  String? image;
  String? description;
  int? sortOrder;
  List<ServiceCategories>? serviceCategories;

  ServicesSubCategories(
      {this.id,
        this.mainCategoryId,
        this.name,
        this.description,
        this.image,
        this.sortOrder,
        this.serviceCategories});

  ServicesSubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainCategoryId = json['main_category_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    sortOrder = json['sort_order'];
    if (json['service_categories'] != null) {
      serviceCategories = <ServiceCategories>[];
      json['service_categories'].forEach((v) {
        serviceCategories!.add(ServiceCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main_category_id'] = mainCategoryId;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['sort_order'] = sortOrder;
    if (serviceCategories != null) {
      data['service_categories'] =
          serviceCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceCategories {
  int? id;
  String? name;
  String? description;
  int? sortOrder;

  ServiceCategories({this.id, this.name, this.description, this.sortOrder});

  ServiceCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    sortOrder = json['sort_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['sort_order'] = sortOrder;
    return data;
  }
}

class Counts {
  int? mainCategories;
  int? subCategories;
  int? serviceCategories;

  Counts({this.mainCategories, this.subCategories, this.serviceCategories});

  Counts.fromJson(Map<String, dynamic> json) {
    mainCategories = json['main_categories'];
    subCategories = json['sub_categories'];
    serviceCategories = json['service_categories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['main_categories'] = mainCategories;
    data['sub_categories'] = subCategories;
    data['service_categories'] = serviceCategories;
    return data;
  }
}
