class ManufacturerAddressModel {
  bool? success;
  String? message;
  List<ManufacturerAddressData>? data;

  ManufacturerAddressModel({this.success, this.message, this.data});

  ManufacturerAddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ManufacturerAddressData>[];
      json['data'].forEach((v) {
        data!.add(ManufacturerAddressData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ManufacturerAddressData {
  int? id;
  String? addressName;
  String? fullAddress;
  String? landmark;
  double? latitude;
  double? longitude;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;

  ManufacturerAddressData({
    this.id,
    this.addressName,
    this.fullAddress,
    this.landmark,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  ManufacturerAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressName = json['address_name'];
    fullAddress = json['full_address'];
    landmark = json['landmark'];
    latitude = json['latitude']?.toDouble();
    longitude = json['longitude']?.toDouble();
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address_name'] = addressName;
    data['full_address'] = fullAddress;
    data['landmark'] = landmark;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_default'] = isDefault;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
