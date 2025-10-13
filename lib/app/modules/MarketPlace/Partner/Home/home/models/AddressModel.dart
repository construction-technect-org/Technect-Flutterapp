class AddressModel {
  bool? success;
  Data? data;

  AddressModel({this.success, this.data});

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "data": data?.toJson()};
}

class Data {
  List<Address>? addresses;
  int? count;

  Data({this.addresses, this.count});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    addresses: json["addresses"] == null
        ? []
        : List<Address>.from(json["addresses"]!.map((x) => Address.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "addresses": addresses == null
        ? []
        : List<dynamic>.from(addresses!.map((x) => x.toJson())),
    "count": count,
  };
}

class Address {
  int? id;
  int? userId;
  String? addressLine1;
  String? addressLine2;
  String? landmark;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  String? latitude;
  String? longitude;
  bool? isDefault;
  String? addressType;
  DateTime? createdAt;
  DateTime? updatedAt;

  Address({
    this.id,
    this.userId,
    this.addressLine1,
    this.addressLine2,
    this.landmark,
    this.city,
    this.state,
    this.pinCode,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.addressType,
    this.country,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    userId: json["user_id"],
    addressLine1: json["address_line1"],
    addressLine2: json["address_line2"],
    landmark: json["landmark"],
    city: json["city"],
    state: json["state"],
    pinCode: json["pin_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    country: json["country"],
    isDefault: json["is_default"],
    addressType: json["address_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "landmark": landmark,
    "city": city,
    "state": state,
    "pin_code": pinCode,
    "latitude": latitude,
    "country": country,
    "longitude": longitude,
    "is_default": isDefault,
    "address_type": addressType,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
