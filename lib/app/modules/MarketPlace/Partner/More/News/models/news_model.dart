class NewsModel {
  bool? success;
  Data? data;

  NewsModel({this.success, this.data});

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "data": data?.toJson()};
}

class Data {
  List<News>? news;
  Pagination? pagination;

  Data({this.news, this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    news: json["news"] == null
        ? []
        : List<News>.from(json["news"]!.map((x) => News.fromJson(x))),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "news": news == null
        ? []
        : List<dynamic>.from(news!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class News {
  int? id;
  String? title;
  String? description;
  bool? isMerchantNews;
  bool? isConnectorNews;
  int? createdBy;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  News({
    this.id,
    this.title,
    this.description,
    this.isMerchantNews,
    this.isConnectorNews,
    this.createdBy,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    isMerchantNews: json["is_merchant_news"],
    isConnectorNews: json["is_connector_news"],
    createdBy: json["created_by"],
    isActive: json["is_active"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "is_merchant_news": isMerchantNews,
    "is_connector_news": isConnectorNews,
    "created_by": createdBy,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Pagination {
  int? total;
  int? limit;
  int? offset;
  bool? hasMore;

  Pagination({this.total, this.limit, this.offset, this.hasMore});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    limit: json["limit"],
    offset: json["offset"],
    hasMore: json["has_more"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "limit": limit,
    "offset": offset,
    "has_more": hasMore,
  };
}
