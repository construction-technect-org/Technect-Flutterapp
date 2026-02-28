class ProjectResponse {
  final bool? success;
  final List<Project>? data;
  final int? total;
  final int? page;
  final int? limit;

  ProjectResponse({this.success, this.data, this.total, this.page, this.limit});

  factory ProjectResponse.fromJson(Map<String, dynamic> json) {
    return ProjectResponse(
      success: json['success'],
      data: json['data'] != null
          ? List<Project>.from(json['data'].map((x) => Project.fromJson(x)))
          : [],
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((x) => x.toJson()).toList(),
      'total': total,
      'page': page,
      'limit': limit,
    };
  }
}

class Project {
  final String? id;
  final String? connectorProfileId;
  final String? name;
  final String? code;
  final String? area;
  final String? address;
  final int? numberOfFloors;
  final String? projectType;
  final String? status;
  final String? description;
  final List<String>? images;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  Project({
    this.id,
    this.connectorProfileId,
    this.name,
    this.code,
    this.area,
    this.address,
    this.numberOfFloors,
    this.projectType,
    this.status,
    this.description,
    this.images,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      connectorProfileId: json['connectorProfileId'],
      name: json['name'],
      code: json['code'],
      area: json['area'],
      address: json['address'],
      numberOfFloors: json['numberOfFloors'],
      projectType: json['projectType'],
      status: json['status'],
      description: json['description'],
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'connectorProfileId': connectorProfileId,
      'name': name,
      'code': code,
      'area': area,
      'address': address,
      'numberOfFloors': numberOfFloors,
      'projectType': projectType,
      'status': status,
      'description': description,
      'images': images,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
