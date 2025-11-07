class ProductRatingModel {
  bool? success;
  Data? data;
  String? message;

  ProductRatingModel({this.success, this.data, this.message});

  ProductRatingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  List<Ratings>? ratings;
  Pagination? pagination;

  Data({this.ratings, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(Ratings.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ratings != null) {
      data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Ratings {
  int? id;
  int? rating;
  String? reviewText;
  bool? isAnonymous;
  String? createdAt;
  String? userName;
  String? userEmail;

  Ratings({
    this.id,
    this.rating,
    this.reviewText,
    this.isAnonymous,
    this.createdAt,
    this.userName,
    this.userEmail,
  });

  Ratings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    reviewText = json['review_text'];
    isAnonymous = json['is_anonymous'];
    createdAt = json['created_at'];
    userName = json['user_name'];
    userEmail = json['user_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rating'] = rating;
    data['review_text'] = reviewText;
    data['is_anonymous'] = isAnonymous;
    data['created_at'] = createdAt;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    return data;
  }
}

class Pagination {
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  Pagination({this.total, this.page, this.limit, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['page'] = page;
    data['limit'] = limit;
    data['total_pages'] = totalPages;
    return data;
  }
}
