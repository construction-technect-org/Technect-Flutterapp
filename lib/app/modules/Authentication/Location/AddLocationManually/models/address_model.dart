class AddressModel {
  final String? addressLine1;
  final String? addressLine2;
  final String? landmark;
  final String? city;
  final String? state;
  final String? pinCode;
  final double? latitude;
  final double? longitude;
  final bool? isDefault;
  final String? addressType;

  AddressModel({
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
  });

  Map<String, dynamic> toJson() {
    return {
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
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      landmark: json['landmark'],
      city: json['city'],
      state: json['state'],
      pinCode: json['pin_code'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      isDefault: json['is_default'],
      addressType: json['address_type'],
    );
  }
}
