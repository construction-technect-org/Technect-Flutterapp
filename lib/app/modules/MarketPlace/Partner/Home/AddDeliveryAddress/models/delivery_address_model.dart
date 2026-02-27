class DeliveryAddressModel {
  bool? success;
  String? message;
  List<DeliveryAddressData>? addresses;

  DeliveryAddressModel({this.success, this.message, this.addresses});

  factory DeliveryAddressModel.fromJson(Map<String, dynamic> json) => DeliveryAddressModel(
    success: json["success"],
    message: json["message"],
    addresses: json["addresses"] == null
        ? []
        : List<DeliveryAddressData>.from(
            json["addresses"]!.map((x) => DeliveryAddressData.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "addresses": addresses == null ? [] : List<dynamic>.from(addresses!.map((x) => x.toJson())),
  };
}

class DeliveryAddressData {
  String? id;
  String? userId;
  String? label;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? pincode;
  String? country;
  String? latitude;
  String? longitude;
  bool? isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;

  DeliveryAddressData({
    this.id,
    this.userId,
    this.label,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.pincode,
    this.country,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory DeliveryAddressData.fromJson(Map<String, dynamic> json) => DeliveryAddressData(
    id: json["id"],
    userId: json["userId"],
    label: json["label"],
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    country: json["country"],
    latitude: json["latitude"]?.toString(),
    longitude: json["longitude"]?.toString(),
    isDefault: json["isDefault"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "label": label,
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "city": city,
    "state": state,
    "pincode": pincode,
    "country": country,
    "latitude": latitude,
    "longitude": longitude,
    "isDefault": isDefault,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  // Helper to get formatted full address
  String get fullAddress {
    return [
      addressLine1,
      addressLine2,
      city,
      state,
      pincode,
    ].where((e) => e != null && e.isNotEmpty).join(", ");
  }
}
