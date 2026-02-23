class DynamicFilterModel {
  bool? success;
  List<DynamicFilterData>? data;

  DynamicFilterModel({this.success, this.data});

  DynamicFilterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DynamicFilterData>[];
      json['data'].forEach((v) {
        data!.add(DynamicFilterData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DynamicFilterData {
  String? id;
  String? categoryProductId;
  String? filterName;
  String? filterLabel;
  String? filterType;
  List<String>? filterOptions;
  String? unit;
  String? maxValue;
  String? minValue;
  String? filterValue;
  String? selectType;
  bool? isRequired;
  bool? isActive;
  int? sortOrder;
  String? createdAt;
  String? updatedAt;

  DynamicFilterData({
    this.id,
    this.categoryProductId,
    this.filterName,
    this.filterLabel,
    this.filterType,
    this.filterOptions,
    this.unit,
    this.maxValue,
    this.minValue,
    this.filterValue,
    this.selectType,
    this.isRequired,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  DynamicFilterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryProductId = json['categoryProductId'];
    filterName = json['filterName'];
    filterLabel = json['filterLabel'];
    filterType = json['filterType'];
    if (json['filterOptions'] != null) {
      filterOptions = json['filterOptions'].cast<String>();
    }
    unit = json['unit'];
    maxValue = json['maxValue'];
    minValue = json['minValue'];
    filterValue = json['filterValue'];
    selectType = json['selectType'];
    isRequired = json['isRequired'];
    isActive = json['isActive'];
    sortOrder = json['sortOrder'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryProductId'] = categoryProductId;
    data['filterName'] = filterName;
    data['filterLabel'] = filterLabel;
    data['filterType'] = filterType;
    data['filterOptions'] = filterOptions;
    data['unit'] = unit;
    data['maxValue'] = maxValue;
    data['minValue'] = minValue;
    data['filterValue'] = filterValue;
    data['selectType'] = selectType;
    data['isRequired'] = isRequired;
    data['isActive'] = isActive;
    data['sortOrder'] = sortOrder;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
