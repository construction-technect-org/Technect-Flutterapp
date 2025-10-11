import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';

class AllWishListModel {
  bool? success;
  String? message;
  List<Product>? data;
  Pagination? pagination;

  AllWishListModel({this.success, this.message, this.data, this.pagination});

  AllWishListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}


class Images {
  String? s3Key;
  String? s3Url;
  int? sortOrder;

  Images({this.s3Key, this.s3Url, this.sortOrder});

  Images.fromJson(Map<String, dynamic> json) {
    s3Key = json['s3_key'];
    s3Url = json['s3_url'];
    sortOrder = json['sort_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['s3_key'] = s3Key;
    data['s3_url'] = s3Url;
    data['sort_order'] = sortOrder;
    return data;
  }
}

class Pagination {
  int? total;
  int? limit;
  int? offset;
  int? currentPage;
  int? totalPages;
  bool? hasNext;
  bool? hasPrev;

  Pagination(
      {this.total,
        this.limit,
        this.offset,
        this.currentPage,
        this.totalPages,
        this.hasNext,
        this.hasPrev});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    offset = json['offset'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    hasNext = json['has_next'];
    hasPrev = json['has_prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['limit'] = limit;
    data['offset'] = offset;
    data['current_page'] = currentPage;
    data['total_pages'] = totalPages;
    data['has_next'] = hasNext;
    data['has_prev'] = hasPrev;
    return data;
  }
}
