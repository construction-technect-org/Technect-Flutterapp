class LeadModel {
  final String id;
  final String name;
  final String connector;
  final String product;
  final double distanceKm;
  final DateTime dateTime;
  final String avatarUrl;

  LeadModel({
    required this.id,
    required this.name,
    required this.connector,
    required this.product,
    required this.distanceKm,
    required this.dateTime,
    required this.avatarUrl,
  });
}
