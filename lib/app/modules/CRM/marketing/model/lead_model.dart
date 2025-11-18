class LeadModel {
  final String id;
  final String name;
  final String connector;
  final String product;
  final Status status;
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
    this.status = Status.pending,
    required this.avatarUrl,
  });
}

enum Status {
  pending('Pending'),
  completed('Completed'),
  missed('Missed'),
  closed('Closed');

  final String text;
  const Status(this.text);
}
