class GetFilterModel {
  final bool? success;
  final List<FilterData>? data;
  final String? message;

  GetFilterModel({this.success, this.data, this.message});

  factory GetFilterModel.fromJson(Map<String, dynamic> json) => GetFilterModel(
    success: json["success"],
    data: json["data"] == null
        ? []
        : List<FilterData>.from(
        json["data"].map((x) => FilterData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class FilterData {
  final int? id;
  final int? productId;
  final String? filterName;
  final String? filterLabel;
  final String? filterType;
  final String? unit;
  final String? minValue;
  final String? maxValue;
  final bool? isRequired;
  final List<String>? dropdownList;
  final String? productName;
  final String? subCategoryName;
  final String? mainCategoryName;

  FilterData({
    this.id,
    this.productId,
    this.filterName,
    this.filterLabel,
    this.filterType,
    this.unit,
    this.minValue,
    this.maxValue,
    this.isRequired,
    this.dropdownList,
    this.productName,
    this.subCategoryName,
    this.mainCategoryName,
  });

  factory FilterData.fromJson(Map<String, dynamic> json) => FilterData(
    id: json["id"],
    productId: json["product_id"],
    filterName: json["filter_name"],
    filterLabel: json["filter_label"],
    filterType: json["filter_type"],
    unit: json["unit"],
    minValue: json["min_value"],
    maxValue: json["max_value"],
    isRequired: json["is_required"],
    dropdownList: json["dropdown_list"] == null
        ? []
        : List<String>.from(json["dropdown_list"].map((x) => x)),
    productName: json["product_name"],
    subCategoryName: json["sub_category_name"],
    mainCategoryName: json["main_category_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "filter_name": filterName,
    "filter_label": filterLabel,
    "filter_type": filterType,
    "unit": unit,
    "min_value": minValue,
    "max_value": maxValue,
    "is_required": isRequired,
    "dropdown_list": dropdownList == null
        ? []
        : List<dynamic>.from(dropdownList!.map((x) => x)),
    "product_name": productName,
    "sub_category_name": subCategoryName,
    "main_category_name": mainCategoryName,
  };
}
