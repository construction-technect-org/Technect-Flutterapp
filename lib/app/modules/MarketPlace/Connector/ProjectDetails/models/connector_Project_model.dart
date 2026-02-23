class ProjectListModel {
  final bool success;
  final List<ConnectorProject> data;
  final int total;
  final int page;
  final int limit;

  ProjectListModel({
    required this.success,
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
  });

  factory ProjectListModel.fromJson(Map<String, dynamic> json) {
    return ProjectListModel(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ConnectorProject.fromJson(e))
          .toList() ??
          [],
      total: json['total'] ?? 0,
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((e) => e.toJson()).toList(),
      'total': total,
      'page': page,
      'limit': limit,
    };
  }
}

class ConnectorProject {
  final String id;
  final String connectorProfileId;
  final String name;
  final String code;
  final String area;
  final String address;
  final int numberOfFloors;
  final String projectType;
  final String status;
  final String description;
  final List<ProjectFile> images;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  ConnectorProject({
    required this.id,
    required this.connectorProfileId,
    required this.name,
    required this.code,
    required this.area,
    required this.address,
    required this.numberOfFloors,
    required this.projectType,
    required this.status,
    required this.description,
    required this.images,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConnectorProject.fromJson(Map<String, dynamic> json) {
    return ConnectorProject(
      id: json['id'] ?? '',
      connectorProfileId: json['connectorProfileId'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      area: json['area'] ?? '',
      address: json['address'] ?? '',
      numberOfFloors: json['numberOfFloors'] ?? 0,
      projectType: json['projectType'] ?? '',
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ProjectFile.fromJson(e))
          .toList() ??
          [],
      isActive: json['isActive'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
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
      'images': images.map((e) => e.toJson()).toList(),
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class ProjectFile {
  final String key;
  final String url;
  final int size;
  final String contentType;
  final String originalName;

  ProjectFile({
    required this.key,
    required this.url,
    required this.size,
    required this.contentType,
    required this.originalName,
  });

  factory ProjectFile.fromJson(Map<String, dynamic> json) {
    return ProjectFile(
      key: json['key'] ?? '',
      url: json['url'] ?? '',
      size: json['size'] ?? 0,
      contentType: json['contentType'] ?? '',
      originalName: json['originalName'] ?? '',
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