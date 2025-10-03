class SavedAddressesModel {
  final bool success;
  final AddressData data;

  SavedAddressesModel({
    required this.success,
    required this.data,
  });

  factory SavedAddressesModel.fromJson(Map<String, dynamic> json) {
    return SavedAddressesModel(
      success: json['success'] ?? false,
      data: AddressData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

class AddressData {
  final List<SavedAddresses> addresses;
  final int count;

  AddressData({
    required this.addresses,
    required this.count,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      addresses: (json['addresses'] as List<dynamic>)
          .map((e) => SavedAddresses.fromJson(e))
          .toList(),
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addresses': addresses.map((e) => e.toJson()).toList(),
      'count': count,
    };
  }
}

class SavedAddresses {
  final int id;
  final int userId;
  final String addressLine1;
  final String addressLine2;
  final String landmark;
  final String city;
  final String state;
  final String pinCode;
  final String latitude;
  final String longitude;
  final bool isDefault;
  final String addressType;
  final String createdAt;
  final String updatedAt;

  SavedAddresses({
    required this.id,
    required this.userId,
    required this.addressLine1,
    required this.addressLine2,
    required this.landmark,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
    required this.addressType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SavedAddresses.fromJson(Map<String, dynamic> json) {
    return SavedAddresses(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      addressLine1: json['address_line1'] ?? '',
      addressLine2: json['address_line2'] ?? '',
      landmark: json['landmark'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      pinCode: json['pin_code'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      isDefault: json['is_default'] ?? false,
      addressType: json['address_type'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      'landmark': landmark,
      'city': city,
      'state': state,
      'pin_code': pinCode,
      'latitude': latitude,
      'longitude': longitude,
      'is_default': isDefault,
      'address_type': addressType,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
