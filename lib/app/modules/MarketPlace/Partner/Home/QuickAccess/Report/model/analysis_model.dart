class AnalysisModel {
  bool? success;
  Analysis? data;
  String? message;

  AnalysisModel({this.success, this.data, this.message});

  AnalysisModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Analysis.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Analysis {
  ProductAnalytics? productAnalytics;
  TeamAnalytics? teamAnalytics;
  RoleAnalytics? roleAnalytics;
  SupportTicketAnalytics? supportTicketAnalytics;
  WishlistAnalytics? wishlist;
  ConnectionsAnalytics? connections;
  String? generatedAt;
  DateRange? dateRange;
  OverallStatistics? overallStatistics;


  Analysis(
      {this.productAnalytics,
        this.teamAnalytics,
        this.overallStatistics,
        this.roleAnalytics,
        this.wishlist,
        this.connections,
        this.supportTicketAnalytics,
        this.generatedAt,
        this.dateRange});

  Analysis.fromJson(Map<String, dynamic> json) {
    productAnalytics = json['product_analytics'] != null
        ? ProductAnalytics.fromJson(json['product_analytics'])
        : null;
    teamAnalytics = json['team_analytics'] != null
        ? TeamAnalytics.fromJson(json['team_analytics'])
        : null;
    roleAnalytics = json['role_analytics'] != null
        ? RoleAnalytics.fromJson(json['role_analytics'])
        : null;
    supportTicketAnalytics = json['support_ticket_analytics'] != null
        ? SupportTicketAnalytics.fromJson(json['support_ticket_analytics'])
        : null;
    generatedAt = json['generated_at'];
    overallStatistics = json['overall_statistics'] != null
        ? OverallStatistics.fromJson(json['overall_statistics'])
        : null;
    dateRange = json['date_range'] != null
        ? DateRange.fromJson(json['date_range'])
        : null;
    wishlist = json['wishlist'] != null
        ? WishlistAnalytics.fromJson(json['wishlist'])
        : null;
    connections = json['connections'] != null
        ? ConnectionsAnalytics.fromJson(json['connections'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productAnalytics != null) {
      data['product_analytics'] = productAnalytics!.toJson();
    }
    if (teamAnalytics != null) {
      data['team_analytics'] = teamAnalytics!.toJson();
    }
    if (roleAnalytics != null) {
      data['role_analytics'] = roleAnalytics!.toJson();
    }
    if (supportTicketAnalytics != null) {
      data['support_ticket_analytics'] = supportTicketAnalytics!.toJson();
    }
    if (overallStatistics != null) {
      data['overall_statistics'] = overallStatistics!.toJson();
    }
    if (wishlist != null) {
      data['wishlist'] = wishlist!.toJson();
    }
    if (connections != null) {
      data['connections'] = connections!.toJson();
    }
    data['generated_at'] = generatedAt;
    if (dateRange != null) {
      data['date_range'] = dateRange!.toJson();
    }
    return data;
  }
}

class OverallStatistics {
  int? totalConnectors;
  int? activeConnectors;
  int? totalUsers;
  int? activeUsers;
  int? totalProducts;
  int? activeProducts;

  OverallStatistics({
    this.totalConnectors,
    this.activeConnectors,
    this.totalUsers,
    this.activeUsers,
    this.totalProducts,
    this.activeProducts,
  });

  OverallStatistics.fromJson(Map<String, dynamic> json) {
    totalConnectors = json['total_connectors'];
    activeConnectors = json['active_connectors'];
    totalUsers = json['total_users'];
    activeUsers = json['active_users'];
    totalProducts = json['total_products'];
    activeProducts = json['active_products'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_connectors'] = totalConnectors;
    data['active_connectors'] = activeConnectors;
    data['total_users'] = totalUsers;
    data['active_users'] = activeUsers;
    data['total_products'] = totalProducts;
    data['active_products'] = activeProducts;
    return data;
  }
}
// ------------------- PRODUCT -------------------
class ProductAnalytics {
  int? totalProducts;
  int? productsAdded;
  int? productsOnReview;
  int? activeProducts;
  int? rejectedProducts;
  List<ProductMonthlyBreakdown>? monthlyBreakdown;

  ProductAnalytics(
      {this.totalProducts,
        this.productsAdded,
        this.productsOnReview,
        this.activeProducts,
        this.rejectedProducts,
        this.monthlyBreakdown});

  ProductAnalytics.fromJson(Map<String, dynamic> json) {
    totalProducts = json['total_products'];
    productsAdded = json['products_added'];
    productsOnReview = json['products_on_review'];
    activeProducts = json['active_products'];
    rejectedProducts = json['rejected_products'];
    if (json['monthly_breakdown'] != null) {
      monthlyBreakdown = <ProductMonthlyBreakdown>[];
      json['monthly_breakdown'].forEach((v) {
        monthlyBreakdown!.add(ProductMonthlyBreakdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_products'] = totalProducts;
    data['products_added'] = productsAdded;
    data['products_on_review'] = productsOnReview;
    data['active_products'] = activeProducts;
    data['rejected_products'] = rejectedProducts;
    if (monthlyBreakdown != null) {
      data['monthly_breakdown'] =
          monthlyBreakdown!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductMonthlyBreakdown {
  int? monthNumber;
  String? monthName;
  int? year;
  int? productsAdded;
  int? productsOnReview;
  int? activeProducts;
  int? rejectedProducts;

  ProductMonthlyBreakdown(
      {this.monthNumber,
        this.monthName,
        this.year,
        this.productsAdded,
        this.productsOnReview,
        this.activeProducts,
        this.rejectedProducts});

  ProductMonthlyBreakdown.fromJson(Map<String, dynamic> json) {
    monthNumber = json['month_number'];
    monthName = json['month_name'];
    year = json['year'];
    productsAdded = json['products_added'];
    productsOnReview = json['products_on_review'];
    activeProducts = json['active_products'];
    rejectedProducts = json['rejected_products'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_number'] = monthNumber;
    data['month_name'] = monthName;
    data['year'] = year;
    data['products_added'] = productsAdded;
    data['products_on_review'] = productsOnReview;
    data['active_products'] = activeProducts;
    data['rejected_products'] = rejectedProducts;
    return data;
  }
}

// ------------------- TEAM -------------------
class TeamAnalytics {
  int? totalTeamMembers;
  int? teamMembersAdded;
  int? availableTeamMembers;
  List<TeamMonthlyBreakdown>? monthlyBreakdown;

  TeamAnalytics(
      {this.totalTeamMembers,
        this.teamMembersAdded,
        this.availableTeamMembers,
        this.monthlyBreakdown});

  TeamAnalytics.fromJson(Map<String, dynamic> json) {
    totalTeamMembers = json['total_team_members'];
    teamMembersAdded = json['team_members_added'];
    availableTeamMembers = json['available_team_members'];
    if (json['monthly_breakdown'] != null) {
      monthlyBreakdown = <TeamMonthlyBreakdown>[];
      json['monthly_breakdown'].forEach((v) {
        monthlyBreakdown!.add(TeamMonthlyBreakdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_team_members'] = totalTeamMembers;
    data['team_members_added'] = teamMembersAdded;
    data['available_team_members'] = availableTeamMembers;
    if (monthlyBreakdown != null) {
      data['monthly_breakdown'] =
          monthlyBreakdown!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamMonthlyBreakdown {
  int? monthNumber;
  String? monthName;
  int? year;
  int? teamMembersAdded;
  int? availableTeamMembers;

  TeamMonthlyBreakdown(
      {this.monthNumber,
        this.monthName,
        this.year,
        this.teamMembersAdded,
        this.availableTeamMembers});

  TeamMonthlyBreakdown.fromJson(Map<String, dynamic> json) {
    monthNumber = json['month_number'];
    monthName = json['month_name'];
    year = json['year'];
    teamMembersAdded = json['team_members_added'];
    availableTeamMembers = json['available_team_members'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_number'] = monthNumber;
    data['month_name'] = monthName;
    data['year'] = year;
    data['team_members_added'] = teamMembersAdded;
    data['available_team_members'] = availableTeamMembers;
    return data;
  }
}

// ------------------- ROLE -------------------
class RoleAnalytics {
  int? totalRoles;
  int? rolesCreated;
  int? activeRoles;
  List<RoleDistribution>? roleDistribution;
  List<RoleMonthlyBreakdown>? monthlyBreakdown;

  RoleAnalytics(
      {this.totalRoles,
        this.rolesCreated,
        this.activeRoles,
        this.roleDistribution,
        this.monthlyBreakdown});

  RoleAnalytics.fromJson(Map<String, dynamic> json) {
    totalRoles = json['total_roles'];
    rolesCreated = json['roles_created'];
    activeRoles = json['active_roles'];
    if (json['role_distribution'] != null) {
      roleDistribution = <RoleDistribution>[];
      json['role_distribution'].forEach((v) {
        roleDistribution!.add(RoleDistribution.fromJson(v));
      });
    }
    if (json['monthly_breakdown'] != null) {
      monthlyBreakdown = <RoleMonthlyBreakdown>[];
      json['monthly_breakdown'].forEach((v) {
        monthlyBreakdown!.add(RoleMonthlyBreakdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_roles'] = totalRoles;
    data['roles_created'] = rolesCreated;
    data['active_roles'] = activeRoles;
    if (roleDistribution != null) {
      data['role_distribution'] =
          roleDistribution!.map((v) => v.toJson()).toList();
    }
    if (monthlyBreakdown != null) {
      data['monthly_breakdown'] =
          monthlyBreakdown!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class RoleDistribution {
  String? roleName;
  int? count;

  RoleDistribution({this.roleName, this.count});

  RoleDistribution.fromJson(Map<String, dynamic> json) {
    roleName = json['role_name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role_name'] = roleName;
    data['count'] = count;
    return data;
  }
}
class RoleMonthlyBreakdown {
  int? monthNumber;
  String? monthName;
  int? year;
  int? rolesCreated;
  int? activeRoles;

  RoleMonthlyBreakdown(
      {this.monthNumber, this.monthName, this.year, this.rolesCreated, this.activeRoles});

  RoleMonthlyBreakdown.fromJson(Map<String, dynamic> json) {
    monthNumber = json['month_number'];
    monthName = json['month_name'];
    year = json['year'];
    rolesCreated = json['roles_created'];
    activeRoles = json['active_roles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_number'] = monthNumber;
    data['month_name'] = monthName;
    data['year'] = year;
    data['roles_created'] = rolesCreated;
    data['active_roles'] = activeRoles;
    return data;
  }
}

// ------------------- SUPPORT TICKET -------------------
class SupportTicketAnalytics {
  int? totalTickets;
  int? ticketsCreated;
  int? openTickets;
  int? closedTickets;
  int? resolvedTickets;
  List<SupportTicketMonthlyBreakdown>? monthlyBreakdown;

  SupportTicketAnalytics(
      {this.totalTickets,
        this.ticketsCreated,
        this.openTickets,
        this.closedTickets,
        this.resolvedTickets,
        this.monthlyBreakdown});

  SupportTicketAnalytics.fromJson(Map<String, dynamic> json) {
    totalTickets = json['total_tickets'];
    ticketsCreated = json['tickets_created'];
    openTickets = json['open_tickets'];
    closedTickets = json['closed_tickets'];
    resolvedTickets = json['resolved_tickets'];
    if (json['monthly_breakdown'] != null) {
      monthlyBreakdown = <SupportTicketMonthlyBreakdown>[];
      json['monthly_breakdown'].forEach((v) {
        monthlyBreakdown!.add(SupportTicketMonthlyBreakdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_tickets'] = totalTickets;
    data['tickets_created'] = ticketsCreated;
    data['open_tickets'] = openTickets;
    data['closed_tickets'] = closedTickets;
    data['resolved_tickets'] = resolvedTickets;
    if (monthlyBreakdown != null) {
      data['monthly_breakdown'] =
          monthlyBreakdown!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupportTicketMonthlyBreakdown {
  int? monthNumber;
  String? monthName;
  int? year;
  int? ticketsCreated;
  int? openTickets;
  int? closedTickets;
  int? resolvedTickets;

  SupportTicketMonthlyBreakdown(
      {this.monthNumber,
        this.monthName,
        this.year,
        this.ticketsCreated,
        this.openTickets,
        this.closedTickets,
        this.resolvedTickets});

  SupportTicketMonthlyBreakdown.fromJson(Map<String, dynamic> json) {
    monthNumber = json['month_number'];
    monthName = json['month_name'];
    year = json['year'];
    ticketsCreated = json['tickets_created'];
    openTickets = json['open_tickets'];
    closedTickets = json['closed_tickets'];
    resolvedTickets = json['resolved_tickets'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_number'] = monthNumber;
    data['month_name'] = monthName;
    data['year'] = year;
    data['tickets_created'] = ticketsCreated;
    data['open_tickets'] = openTickets;
    data['closed_tickets'] = closedTickets;
    data['resolved_tickets'] = resolvedTickets;
    return data;
  }
}

// ------------------- DATE RANGE -------------------
class DateRange {
  String? startDate;
  String? endDate;

  DateRange({this.startDate, this.endDate});

  DateRange.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}


class WishlistAnalytics {
  int? totalItems;
  int? itemsAddedInPeriod;
  List<WishlistMonthlyBreakdown>? monthlyBreakdown;

  WishlistAnalytics({this.totalItems, this.itemsAddedInPeriod, this.monthlyBreakdown});

  WishlistAnalytics.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    itemsAddedInPeriod = json['items_added_in_period'];
    if (json['monthly_breakdown'] != null) {
      monthlyBreakdown = <WishlistMonthlyBreakdown>[];
      json['monthly_breakdown'].forEach((v) {
        monthlyBreakdown!.add(WishlistMonthlyBreakdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_items'] = totalItems;
    data['items_added_in_period'] = itemsAddedInPeriod;
    if (monthlyBreakdown != null) {
      data['monthly_breakdown'] =
          monthlyBreakdown!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishlistMonthlyBreakdown {
  int? monthNumber;
  String? monthName;
  int? year;
  int? itemsAdded;

  WishlistMonthlyBreakdown(
      {this.monthNumber, this.monthName, this.year, this.itemsAdded});

  WishlistMonthlyBreakdown.fromJson(Map<String, dynamic> json) {
    monthNumber = json['month_number'];
    monthName = json['month_name'];
    year = json['year'];
    itemsAdded = json['items_added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_number'] = monthNumber;
    data['month_name'] = monthName;
    data['year'] = year;
    data['items_added'] = itemsAdded;
    return data;
  }
}
class ConnectionsAnalytics {
  int? totalConnections;
  int? connectionsCreatedInPeriod;
  List<ConnectionsMonthlyBreakdown>? monthlyBreakdown;

  ConnectionsAnalytics({
    this.totalConnections,
    this.connectionsCreatedInPeriod,
    this.monthlyBreakdown,
  });

  ConnectionsAnalytics.fromJson(Map<String, dynamic> json) {
    totalConnections = json['total_connections'];
    connectionsCreatedInPeriod = json['connections_created_in_period'];
    if (json['monthly_breakdown'] != null) {
      monthlyBreakdown = <ConnectionsMonthlyBreakdown>[];
      json['monthly_breakdown'].forEach((v) {
        monthlyBreakdown!.add(ConnectionsMonthlyBreakdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_connections'] = totalConnections;
    data['connections_created_in_period'] = connectionsCreatedInPeriod;
    if (monthlyBreakdown != null) {
      data['monthly_breakdown'] =
          monthlyBreakdown!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConnectionsMonthlyBreakdown {
  int? monthNumber;
  String? monthName;
  int? year;
  int? connectionsCreated;

  ConnectionsMonthlyBreakdown({
    this.monthNumber,
    this.monthName,
    this.year,
    this.connectionsCreated,
  });

  ConnectionsMonthlyBreakdown.fromJson(Map<String, dynamic> json) {
    monthNumber = json['month_number'];
    monthName = json['month_name'];
    year = json['year'];
    connectionsCreated = json['connections_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_number'] = monthNumber;
    data['month_name'] = monthName;
    data['year'] = year;
    data['connections_created'] = connectionsCreated;
    return data;
  }
}
