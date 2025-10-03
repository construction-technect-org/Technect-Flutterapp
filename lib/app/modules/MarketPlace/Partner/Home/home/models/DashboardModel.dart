class DashboardModel {
  bool? success;
  Data? data;
  String? message;

  DashboardModel({this.success, this.data, this.message});

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  int? totalPartnerProfiles;
  int? totalConnectorProfiles;
  int? totalProducts;
  int? merchantSupportTickets;
  int? merchantProductNotifications;

  Data({
    this.totalPartnerProfiles,
    this.totalConnectorProfiles,
    this.totalProducts,
    this.merchantSupportTickets,
    this.merchantProductNotifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalPartnerProfiles: json["total_partner_profiles"],
    totalConnectorProfiles: json["total_connector_profiles"],
    totalProducts: json["total_products"],
    merchantSupportTickets: json["merchant_support_tickets"],
    merchantProductNotifications: json["merchant_product_notifications"],
  );

  Map<String, dynamic> toJson() => {
    "total_partner_profiles": totalPartnerProfiles,
    "total_connector_profiles": totalConnectorProfiles,
    "total_products": totalProducts,
    "merchant_support_tickets": merchantSupportTickets,
    "merchant_product_notifications": merchantProductNotifications,
  };
}
