class SupportMyTicketsModel {
  bool success;
  SupportTicketsData data;
  String message;

  SupportMyTicketsModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory SupportMyTicketsModel.fromJson(Map<String, dynamic> json) {
    return SupportMyTicketsModel(
      success: json['success'] ?? false,
      data: SupportTicketsData.fromJson(json['data']),
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
      'message': message,
    };
  }
}

class Statistics {
  int? openTickets;
  int? inProgressTickets;
  int? resolvedTickets;
  int? avgResponse;
  int? totalTeamMember;
  int? activeTeamMember;
  int? totalRoles;
  int? activeRoles;

  Statistics(
      {this.openTickets,
        this.inProgressTickets,
        this.resolvedTickets,
        this.totalTeamMember,
        this.totalRoles,
        this.activeRoles,
        this.activeTeamMember,
        this.avgResponse});

  Statistics.fromJson(Map<String, dynamic> json) {
    openTickets = json['open_tickets'];
    inProgressTickets = json['in_progress_tickets'];
    resolvedTickets = json['resolved_tickets'];
    avgResponse = json['avg_response'];
    totalTeamMember = json['total_team_members'];
    totalRoles = json['total_roles'];
    activeRoles = json['active_roles'];
    activeTeamMember = json['active_team_members'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['open_tickets'] = openTickets;
    data['in_progress_tickets'] = inProgressTickets;
    data['resolved_tickets'] = resolvedTickets;
    data['avg_response'] = avgResponse;
    data['total_team_members'] = totalTeamMember;
    data['active_team_members'] = activeTeamMember;
    data['total_roles'] = totalRoles;
    data['active_roles'] = activeRoles;
    return data;
  }
}

class SupportTicketsData {
  List<SupportMyTickets> tickets;
  Pagination pagination;
  Statistics? statistics;

  SupportTicketsData({
    required this.tickets,
    required this.pagination,
    this.statistics,
  });

  factory SupportTicketsData.fromJson(Map<String, dynamic> json) {
    return SupportTicketsData(
      tickets: (json['tickets'] as List<dynamic>?)
          ?.map((e) => SupportMyTickets.fromJson(e))
          .toList() ??
          [],
      statistics: json['statistics'] != null
          ? Statistics.fromJson(json['statistics'])
          : null,
      pagination: Pagination.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tickets': tickets.map((e) => e.toJson()).toList(),
      'pagination': pagination.toJson(),
      'statistics': statistics?.toJson(),
    };
  }
}


class SupportMyTickets {
  int id;
  String ticketNumber;
  int userId;
  int merchantProfileId;
  int categoryId;
  int priorityId;
  int statusId;
  String subject;
  String description;
  String? assignedTo;
  String? resolutionNotes;
  String? resolvedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String categoryName;
  String priorityName;
  String statusName;
  String userMobile;
  String? assignedToMobile;

  SupportMyTickets({
    required this.id,
    required this.ticketNumber,
    required this.userId,
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

  factory SupportMyTickets.fromJson(Map<String, dynamic> json) {
    return SupportMyTickets(
      id: json['id'] ?? 0,
      ticketNumber: json['ticket_number'] ?? '',
      userId: json['user_id'] ?? 0,
      merchantProfileId: json['merchant_profile_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      priorityId: json['priority_id'] ?? 0,
      statusId: json['status_id'] ?? 0,
      subject: json['subject'] ?? '',
      description: json['description'] ?? '',
      assignedTo: json['assigned_to'],
      resolutionNotes: json['resolution_notes'],
      resolvedAt: json['resolved_at'],
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
      'merchant_profile_id': merchantProfileId,
      'category_id': categoryId,
      'priority_id': priorityId,
      'status_id': statusId,
      'subject': subject,
      'description': description,
      'assigned_to': assignedTo,
      'resolution_notes': resolutionNotes,
      'resolved_at': resolvedAt,
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

class Pagination {
  int currentPage;
  int totalPages;
  int totalTickets;
  int perPage;
  bool hasNext;
  bool hasPrev;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalTickets,
    required this.perPage,
    required this.hasNext,
    required this.hasPrev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
      totalTickets: json['total_tickets'] ?? 0,
      perPage: json['per_page'] ?? 20,
      hasNext: json['has_next'] ?? false,
      hasPrev: json['has_prev'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'total_pages': totalPages,
      'total_tickets': totalTickets,
      'per_page': perPage,
      'has_next': hasNext,
      'has_prev': hasPrev,
    };
  }
}
