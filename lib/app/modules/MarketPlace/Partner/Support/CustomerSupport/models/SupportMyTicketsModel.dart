class SupportMyTicketsModel {
  bool? success;
  SupportTicketsData? data;
  String? message;

  SupportMyTicketsModel({this.success, this.data, this.message});

  factory SupportMyTicketsModel.fromJson(Map<String, dynamic> json) =>
      SupportMyTicketsModel(
        success: json["success"],
        data: json["data"] == null ? null : SupportTicketsData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class SupportTicketsData {
  List<Ticket>? tickets;
  Statistics? statistics;
  Pagination? pagination;
  dynamic filter;

  SupportTicketsData({this.tickets, this.statistics, this.pagination, this.filter});

  factory SupportTicketsData.fromJson(Map<String, dynamic> json) => SupportTicketsData(
    tickets: json["tickets"] == null
        ? []
        : List<Ticket>.from(json["tickets"]!.map((x) => Ticket.fromJson(x))),
    statistics: json["statistics"] == null
        ? null
        : Statistics.fromJson(json["statistics"]),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
    filter: json["filter"],
  );

  Map<String, dynamic> toJson() => {
    "tickets": tickets == null ? [] : List<dynamic>.from(tickets!.map((x) => x.toJson())),
    "statistics": statistics?.toJson(),
    "pagination": pagination?.toJson(),
    "filter": filter,
  };
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalTickets;
  int? perPage;
  bool? hasNext;
  bool? hasPrev;

  Pagination({
    this.currentPage,
    this.totalPages,
    this.totalTickets,
    this.perPage,
    this.hasNext,
    this.hasPrev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["current_page"],
    totalPages: json["total_pages"],
    totalTickets: json["total_tickets"],
    perPage: json["per_page"],
    hasNext: json["has_next"],
    hasPrev: json["has_prev"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "total_pages": totalPages,
    "total_tickets": totalTickets,
    "per_page": perPage,
    "has_next": hasNext,
    "has_prev": hasPrev,
  };
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
  Statistics({
    this.openTickets,
    this.inProgressTickets,
    this.resolvedTickets,
    this.totalTeamMember,
    this.totalRoles,
    this.activeRoles,
    this.activeTeamMember,
    this.avgResponse,
  });

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

class Ticket {
  int? id;
  String? ticketNumber;
  int? userId;
  int? merchantProfileId;
  int? connectorProfileId;
  int? categoryId;
  int? priorityId;
  int? statusId;
  String? subject;
  String? description;
  dynamic assignedTo;
  dynamic resolutionNotes;
  dynamic resolvedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? categoryName;
  String? priorityName;
  String? statusName;
  String? userMobile;
  dynamic assignedToMobile;

  Ticket({
    this.id,
    this.ticketNumber,
    this.userId,
    this.merchantProfileId,
    this.connectorProfileId,
    this.categoryId,
    this.priorityId,
    this.statusId,
    this.subject,
    this.description,
    this.assignedTo,
    this.resolutionNotes,
    this.resolvedAt,
    this.createdAt,
    this.updatedAt,
    this.categoryName,
    this.priorityName,
    this.statusName,
    this.userMobile,
    this.assignedToMobile,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"],
    ticketNumber: json["ticket_number"],
    userId: json["user_id"],
    merchantProfileId: json["merchant_profile_id"],
    connectorProfileId: json["connector_profile_id"],
    categoryId: json["category_id"],
    priorityId: json["priority_id"],
    statusId: json["status_id"],
    subject: json["subject"],
    description: json["description"],
    assignedTo: json["assigned_to"],
    resolutionNotes: json["resolution_notes"],
    resolvedAt: json["resolved_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    categoryName: json["category_name"],
    priorityName: json["priority_name"],
    statusName: json["status_name"],
    userMobile: json["user_mobile"],
    assignedToMobile: json["assigned_to_mobile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ticket_number": ticketNumber,
    "user_id": userId,
    "merchant_profile_id": merchantProfileId,
    "connector_profile_id": connectorProfileId,
    "category_id": categoryId,
    "priority_id": priorityId,
    "status_id": statusId,
    "subject": subject,
    "description": description,
    "assigned_to": assignedTo,
    "resolution_notes": resolutionNotes,
    "resolved_at": resolvedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "category_name": categoryName,
    "priority_name": priorityName,
    "status_name": statusName,
    "user_mobile": userMobile,
    "assigned_to_mobile": assignedToMobile,
  };
}
