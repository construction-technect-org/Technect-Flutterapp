class SupportTicketCreateModel {
  final bool success;
  final SupportTicketCreat data;
  final String message;

  SupportTicketCreateModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory SupportTicketCreateModel.fromJson(Map<String, dynamic> json) {
    return SupportTicketCreateModel(
      success: json['success'] ?? false,
      data: SupportTicketCreat.fromJson(json['data']),
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'data': data.toJson(), 'message': message};
  }
}

class SupportTicketCreat {
  final int id;
  final String ticketNumber;
  final int userId;
  final int? connectorProfileId;
  final int merchantProfileId;
  final int categoryId;
  final int priorityId;
  final int statusId;
  final String subject;
  final String description;
  final String? assignedTo;
  final String? resolutionNotes;
  final DateTime? resolvedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String categoryName;
  final String priorityName;
  final String statusName;
  final String userMobile;
  final String? assignedToMobile;

  SupportTicketCreat({
    required this.id,
    required this.ticketNumber,
    required this.userId,
    required this.connectorProfileId,
    required this.merchantProfileId,
    required this.categoryId,
    required this.priorityId,
    required this.statusId,
    required this.subject,
    required this.description,
    this.assignedTo,
    this.resolutionNotes,
    this.resolvedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryName,
    required this.priorityName,
    required this.statusName,
    required this.userMobile,
    this.assignedToMobile,
  });

  factory SupportTicketCreat.fromJson(Map<String, dynamic> json) {
    return SupportTicketCreat(
      id: json['id'] ?? 0,
      ticketNumber: json['ticket_number'] ?? '',
      userId: json['user_id'] ?? 0,
      merchantProfileId: json['merchant_profile_id'] ?? 0,
      connectorProfileId: json["connector_profile_id"] ?? 0,
      categoryId: json['category_id'] ?? 0,
      priorityId: json['priority_id'] ?? 0,
      statusId: json['status_id'] ?? 0,
      subject: json['subject'] ?? '',
      description: json['description'] ?? '',
      assignedTo: json['assigned_to'],
      resolutionNotes: json['resolution_notes'],
      resolvedAt: json['resolved_at'] != null
          ? DateTime.parse(json['resolved_at'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      categoryName: json['category_name'] ?? '',
      priorityName: json['priority_name'] ?? '',
      statusName: json['status_name'] ?? '',
      userMobile: json['user_mobile'] ?? '',
      assignedToMobile: json['assigned_to_mobile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticket_number': ticketNumber,
      'user_id': userId,
      "connector_profile_id": connectorProfileId,
      'merchant_profile_id': merchantProfileId,
      'category_id': categoryId,
      'priority_id': priorityId,
      'status_id': statusId,
      'subject': subject,
      'description': description,
      'assigned_to': assignedTo,
      'resolution_notes': resolutionNotes,
      'resolved_at': resolvedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'category_name': categoryName,
      'priority_name': priorityName,
      'status_name': statusName,
      'user_mobile': userMobile,
      'assigned_to_mobile': assignedToMobile,
    };
  }
}
