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
  ServiceAnalytics? serviceAnalytics;
  TeamAnalytics? teamAnalytics;
  RoleAnalytics? roleAnalytics;
  SupportTicketAnalytics? supportTicketAnalytics;
  WishlistAnalytics? wishlist;
  ProductConnectionsAnalytics? productConnections;
  ServiceConnectionsAnalytics? serviceConnections;
  ServiceRequirementsAnalytics? serviceRequirements;
  ProductRequirementsAnalytics? productRequirements;
  ConnectorSupportTicketsAnalytics? connectorSupportTickets;
  String? generatedAt;
  DateRange? dateRange;
  OverallStatistics? overallStatistics;

  Analysis({
    this.productAnalytics,
    this.serviceAnalytics,
    this.teamAnalytics,
    this.overallStatistics,
    this.roleAnalytics,
    this.wishlist,
    this.productConnections,
    this.serviceConnections,
    this.serviceRequirements,
    this.productRequirements,
    this.connectorSupportTickets,
    this.supportTicketAnalytics,
    this.generatedAt,
    this.dateRange,
  });

  Analysis.fromJson(Map<String, dynamic> json) {
    productAnalytics = json['product_analytics'] != null
        ? ProductAnalytics.fromJson(json['product_analytics'])
        : null;
    serviceAnalytics = json['service_analytics'] != null
        ? ServiceAnalytics.fromJson(json['service_analytics'])
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
    productConnections = json['product_connections'] != null
        ? ProductConnectionsAnalytics.fromJson(json['product_connections'])
        : null;
    serviceConnections = json['services_connections'] != null
        ? ServiceConnectionsAnalytics.fromJson(json['services_connections'])
        : null;
    serviceRequirements = json['service_requirements'] != null
        ? ServiceRequirementsAnalytics.fromJson(json['service_requirements'])
        : null;
    productRequirements = json['product_requirements'] != null
        ? ProductRequirementsAnalytics.fromJson(json['product_requirements'])
        : null;
    connectorSupportTickets = json['support_tickets'] != null
        ? ConnectorSupportTicketsAnalytics.fromJson(json['support_tickets'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productAnalytics != null) {
      data['product_analytics'] = productAnalytics!.toJson();
    }
    if (serviceAnalytics != null) {
      data['service_analytics'] = serviceAnalytics!.toJson();
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
    if (productConnections != null) {
      data['product_connections'] = productConnections!.toJson();
    }
    if (serviceConnections != null) {
      data['services_connections'] = serviceConnections!.toJson();
    }
    if (serviceRequirements != null) {
      data['service_requirements'] = serviceRequirements!.toJson();
    }
    if (productRequirements != null) {
      data['product_requirements'] = productRequirements!.toJson();
    }
    if (connectorSupportTickets != null) {
      data['support_tickets'] = connectorSupportTickets!.toJson();
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
  int? totalMerchant;
  int? activeConnectors;
  int? activeMerchant;
  int? totalUsers;
  int? activeUsers;
  int? totalProducts;
  int? activeProducts;
  int? totalServices;
  int? activeServices;

  OverallStatistics({
    this.totalConnectors,
    this.activeConnectors,
    this.totalUsers,
    this.activeUsers,
    this.totalProducts,
    this.activeProducts,
    this.totalServices,
    this.activeServices,
    this.activeMerchant,
    this.totalMerchant,
  });

  OverallStatistics.fromJson(Map<String, dynamic> json) {
    totalConnectors = json['total_connectors'];
    activeConnectors = json['active_connectors'];
    totalUsers = json['total_users'];
    activeUsers = json['active_users'];
    totalProducts = json['total_products'];
    activeProducts = json['active_products'];
    totalServices = json['total_services'];
    activeServices = json['active_services'];
    totalMerchant = json['total_merchants'];
    activeMerchant = json['active_merchants'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_connectors'] = totalConnectors;
    data['active_connectors'] = activeConnectors;
    data['total_users'] = totalUsers;
    data['active_users'] = activeUsers;
    data['total_products'] = totalProducts;
    data['active_products'] = activeProducts;
    data['total_services'] = totalServices;
    data['active_services'] = activeServices;
    data['total_merchants'] = totalMerchant;
    data['active_merchants'] = activeMerchant;
    return data;
  }
}

// ------------------- SERVICE -------------------
class ServiceAnalytics {
  int? totalServices;
  int? servicesAdded;
  int? servicesOnReview;
  int? activeServices;
  int? rejectedServices;
  List<ServiceMonthlyBreakdown>? monthlyBreakdown;

  ServiceAnalytics({
    this.totalServices,
    this.servicesAdded,
    this.servicesOnReview,
    this.activeServices,
    this.rejectedServices,
    this.monthlyBreakdown,
  });

  ServiceAnalytics.fromJson(Map<String, dynamic> json) {
    totalServices = json['total_services'];
    servicesAdded = json['services_added'];
    servicesOnReview = json['services_on_review'];
    activeServices = json['active_services'];
    rejectedServices = json['rejected_services'];
    if (json['monthly_breakdown'] != null) {
      monthlyBreakdown = <ServiceMonthlyBreakdown>[];
      json['monthly_breakdown'].forEach((v) {
        monthlyBreakdown!.add(ServiceMonthlyBreakdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_services'] = totalServices;
    data['services_added'] = servicesAdded;
    data['services_on_review'] = servicesOnReview;
    data['active_services'] = activeServices;
    data['rejected_services'] = rejectedServices;
    if (monthlyBreakdown != null) {
      data['monthly_breakdown'] = monthlyBreakdown!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class ServiceMonthlyBreakdown {
  int? monthNumber;
  String? monthName;
  int? year;
  int? servicesAdded;
  int? servicesOnReview;
  int? activeServices;
  int? rejectedServices;

  ServiceMonthlyBreakdown({
    this.monthNumber,
    this.monthName,
    this.year,
    this.servicesAdded,
    this.servicesOnReview,
    this.activeServices,
    this.rejectedServices,
  });

  ServiceMonthlyBreakdown.fromJson(Map<String, dynamic> json) {
    monthNumber = json['month_number'];
    monthName = json['month_name'];
    year = json['year'];
    servicesAdded = json['services_added'];
    servicesOnReview = json['services_on_review'];
    activeServices = json['active_services'];
    rejectedServices = json['rejected_services'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_number'] = monthNumber;
    data['month_name'] = monthName;
    data['year'] = year;
    data['services_added'] = servicesAdded;
    data['services_on_review'] = servicesOnReview;
    data['active_services'] = activeServices;
    data['rejected_services'] = rejectedServices;
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

  ProductAnalytics({
    this.totalProducts,
    this.productsAdded,
    this.productsOnReview,
    this.activeProducts,
    this.rejectedProducts,
    this.monthlyBreakdown,
  });

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
      data['monthly_breakdown'] = monthlyBreakdown!
          .map((v) => v.toJson())
          .toList();
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

  ProductMonthlyBreakdown({
    this.monthNumber,
    this.monthName,
    this.year,
    this.productsAdded,
    this.productsOnReview,
    this.activeProducts,
    this.rejectedProducts,
  });

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

  TeamAnalytics({
    this.totalTeamMembers,
    this.teamMembersAdded,
    this.availableTeamMembers,
    this.monthlyBreakdown,
  });

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
      data['monthly_breakdown'] = monthlyBreakdown!
          .map((v) => v.toJson())
          .toList();
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

  TeamMonthlyBreakdown({
    this.monthNumber,
    this.monthName,
    this.year,
    this.teamMembersAdded,
    this.availableTeamMembers,
  });

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

  RoleAnalytics({
    this.totalRoles,
    this.rolesCreated,
    this.activeRoles,
    this.roleDistribution,
    this.monthlyBreakdown,
  });

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
      data['role_distribution'] = roleDistribution!
          .map((v) => v.toJson())
          .toList();
    }
    if (monthlyBreakdown != null) {
      data['monthly_breakdown'] = monthlyBreakdown!
          .map((v) => v.toJson())
          .toList();
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

  RoleMonthlyBreakdown({
    this.monthNumber,
    this.monthName,
    this.year,
    this.rolesCreated,
    this.activeRoles,
  });

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

  SupportTicketAnalytics({
    this.totalTickets,
    this.ticketsCreated,
    this.openTickets,
    this.closedTickets,
    this.resolvedTickets,
    this.monthlyBreakdown,
  });

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
      data['monthly_breakdown'] = monthlyBreakdown!
          .map((v) => v.toJson())
          .toList();
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

  SupportTicketMonthlyBreakdown({
    this.monthNumber,
    this.monthName,
    this.year,
    this.ticketsCreated,
    this.openTickets,
    this.closedTickets,
    this.resolvedTickets,
  });

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

  WishlistAnalytics({
    this.totalItems,
    this.itemsAddedInPeriod,
    this.monthlyBreakdown,
  });

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
      data['monthly_breakdown'] = monthlyBreakdown!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class WishlistMonthlyBreakdown {
  int? monthNumber;
  String? monthName;
  int? year;
  int? itemsAdded;

  WishlistMonthlyBreakdown({
    this.monthNumber,
    this.monthName,
    this.year,
    this.itemsAdded,
  });

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

// ------------------- PRODUCT CONNECTIONS (CONNECTOR) -------------------
class ProductConnectionsAnalytics {
  int? totalConnections;
  int? connectionsCreatedInPeriod;
  List<ProductConnectionsMonthlyBreakdown>? monthlyBreakdown;

  ProductConnectionsAnalytics({
    this.totalConnections,
    this.connectionsCreatedInPeriod,
    this.monthlyBreakdown,
  });

  ProductConnectionsAnalytics.fromJson(Map<String, dynamic> json) {
    totalConnections = json['total_connections'];
    connectionsCreatedInPeriod = json['connections_created_in_period'];
    if (json['monthly_breakdown'] != null) {
      monthlyBreakdown = <ProductConnectionsMonthlyBreakdown>[];
      json['monthly_breakdown'].forEach((v) {
        monthlyBreakdown!.add(ProductConnectionsMonthlyBreakdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_connections'] = totalConnections;
    data['connections_created_in_period'] = connectionsCreatedInPeriod;
    if (monthlyBreakdown != null) {
      data['monthly_breakdown'] = monthlyBreakdown!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class ProductConnectionsMonthlyBreakdown {
  int? monthNumber;
  String? monthName;
  int? year;
  int? connectionsCreated;

  ProductConnectionsMonthlyBreakdown({
    this.monthNumber,
    this.monthName,
    this.year,
    this.connectionsCreated,
  });

  ProductConnectionsMonthlyBreakdown.fromJson(Map<String, dynamic> json) {
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

// ------------------- SERVICE CONNECTIONS (CONNECTOR) -------------------
class ServiceConnectionsAnalytics {
  int? totalServiceConnections;
  int? serviceConnectionsCreatedInPeriod;
  List<ServiceConnectionsMonthlyBreakdown>? monthlyBreakdown;

  ServiceConnectionsAnalytics({
    this.totalServiceConnections,
    this.serviceConnectionsCreatedInPeriod,
    this.monthlyBreakdown,
  });

  ServiceConnectionsAnalytics.fromJson(Map<String, dynamic> json) {
    totalServiceConnections = json['total_service_connections'];
    serviceConnectionsCreatedInPeriod =
        json['service_connections_created_in_period'];
    if (json['monthly_breakdown'] != null) {
      monthlyBreakdown = <ServiceConnectionsMonthlyBreakdown>[];
      json['monthly_breakdown'].forEach((v) {
        monthlyBreakdown!.add(ServiceConnectionsMonthlyBreakdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_service_connections'] = totalServiceConnections;
    data['service_connections_created_in_period'] =
        serviceConnectionsCreatedInPeriod;
    if (monthlyBreakdown != null) {
      data['monthly_breakdown'] = monthlyBreakdown!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class ServiceConnectionsMonthlyBreakdown {
  int? monthNumber;
  String? monthName;
  int? year;
  int? serviceConnectionsCreated;

  ServiceConnectionsMonthlyBreakdown({
    this.monthNumber,
    this.monthName,
    this.year,
    this.serviceConnectionsCreated,
  });

  ServiceConnectionsMonthlyBreakdown.fromJson(Map<String, dynamic> json) {
    monthNumber = json['month_number'];
    monthName = json['month_name'];
    year = json['year'];
    serviceConnectionsCreated = json['service_connections_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_number'] = monthNumber;
    data['month_name'] = monthName;
    data['year'] = year;
    data['service_connections_created'] = serviceConnectionsCreated;
    return data;
  }
}

// ------------------- SERVICE REQUIREMENTS (CONNECTOR) -------------------
class ServiceRequirementsAnalytics {
  int? totalRequirements;
  int? requirementsCreatedInPeriod;
  int? pendingRequirements;
  int? fulfilledRequirements;
  int? cancelledRequirements;
  List<ServiceRequirementsMonthlyBreakdown>? monthlyBreakdown;

  ServiceRequirementsAnalytics({
    this.totalRequirements,
    this.requirementsCreatedInPeriod,
    this.pendingRequirements,
    this.fulfilledRequirements,
    this.cancelledRequirements,
    this.monthlyBreakdown,
  });

  ServiceRequirementsAnalytics.fromJson(Map<String, dynamic> json) {
    totalRequirements = json['total_requirements'];
    requirementsCreatedInPeriod = json['requirements_created_in_period'];
    pendingRequirements = json['pending_requirements'];
    fulfilledRequirements = json['fulfilled_requirements'];
    cancelledRequirements = json['cancelled_requirements'];
    if (json['monthly_breakdown'] != null) {
      monthlyBreakdown = <ServiceRequirementsMonthlyBreakdown>[];
      json['monthly_breakdown'].forEach((v) {
        monthlyBreakdown!.add(ServiceRequirementsMonthlyBreakdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_requirements'] = totalRequirements;
    data['requirements_created_in_period'] = requirementsCreatedInPeriod;
    data['pending_requirements'] = pendingRequirements;
    data['fulfilled_requirements'] = fulfilledRequirements;
    data['cancelled_requirements'] = cancelledRequirements;
    if (monthlyBreakdown != null) {
      data['monthly_breakdown'] = monthlyBreakdown!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class ServiceRequirementsMonthlyBreakdown {
  int? monthNumber;
  String? monthName;
  int? year;
  int? requirementsCreated;
  int? pendingRequirements;
  int? fulfilledRequirements;
  int? cancelledRequirements;

  ServiceRequirementsMonthlyBreakdown({
    this.monthNumber,
    this.monthName,
    this.year,
    this.requirementsCreated,
    this.pendingRequirements,
    this.fulfilledRequirements,
    this.cancelledRequirements,
  });

  ServiceRequirementsMonthlyBreakdown.fromJson(Map<String, dynamic> json) {
    monthNumber = json['month_number'];
    monthName = json['month_name'];
    year = json['year'];
    requirementsCreated = json['requirements_created'];
    pendingRequirements = json['pending_requirements'];
    fulfilledRequirements = json['fulfilled_requirements'];
    cancelledRequirements = json['cancelled_requirements'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_number'] = monthNumber;
    data['month_name'] = monthName;
    data['year'] = year;
    data['requirements_created'] = requirementsCreated;
    data['pending_requirements'] = pendingRequirements;
    data['fulfilled_requirements'] = fulfilledRequirements;
    data['cancelled_requirements'] = cancelledRequirements;
    return data;
  }
}

// ------------------- PRODUCT REQUIREMENTS (CONNECTOR) -------------------
class ProductRequirementsAnalytics {
  int? totalRequirements;
  int? requirementsCreatedInPeriod;
  int? pendingRequirements;
  int? fulfilledRequirements;
  int? cancelledRequirements;
  List<ProductRequirementsMonthlyBreakdown>? monthlyBreakdown;

  ProductRequirementsAnalytics({
    this.totalRequirements,
    this.requirementsCreatedInPeriod,
    this.pendingRequirements,
    this.fulfilledRequirements,
    this.cancelledRequirements,
    this.monthlyBreakdown,
  });

  ProductRequirementsAnalytics.fromJson(Map<String, dynamic> json) {
    totalRequirements = json['total_requirements'];
    requirementsCreatedInPeriod = json['requirements_created_in_period'];
    pendingRequirements = json['pending_requirements'];
    fulfilledRequirements = json['fulfilled_requirements'];
    cancelledRequirements = json['cancelled_requirements'];
    if (json['monthly_breakdown'] != null) {
      monthlyBreakdown = <ProductRequirementsMonthlyBreakdown>[];
      json['monthly_breakdown'].forEach((v) {
        monthlyBreakdown!.add(ProductRequirementsMonthlyBreakdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_requirements'] = totalRequirements;
    data['requirements_created_in_period'] = requirementsCreatedInPeriod;
    data['pending_requirements'] = pendingRequirements;
    data['fulfilled_requirements'] = fulfilledRequirements;
    data['cancelled_requirements'] = cancelledRequirements;
    if (monthlyBreakdown != null) {
      data['monthly_breakdown'] = monthlyBreakdown!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class ProductRequirementsMonthlyBreakdown {
  int? monthNumber;
  String? monthName;
  int? year;
  int? requirementsCreated;
  int? pendingRequirements;
  int? fulfilledRequirements;
  int? cancelledRequirements;

  ProductRequirementsMonthlyBreakdown({
    this.monthNumber,
    this.monthName,
    this.year,
    this.requirementsCreated,
    this.pendingRequirements,
    this.fulfilledRequirements,
    this.cancelledRequirements,
  });

  ProductRequirementsMonthlyBreakdown.fromJson(Map<String, dynamic> json) {
    monthNumber = json['month_number'];
    monthName = json['month_name'];
    year = json['year'];
    requirementsCreated = json['requirements_created'];
    pendingRequirements = json['pending_requirements'];
    fulfilledRequirements = json['fulfilled_requirements'];
    cancelledRequirements = json['cancelled_requirements'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_number'] = monthNumber;
    data['month_name'] = monthName;
    data['year'] = year;
    data['requirements_created'] = requirementsCreated;
    data['pending_requirements'] = pendingRequirements;
    data['fulfilled_requirements'] = fulfilledRequirements;
    data['cancelled_requirements'] = cancelledRequirements;
    return data;
  }
}

// ------------------- CONNECTOR SUPPORT TICKETS -------------------
class ConnectorSupportTicketsAnalytics {
  int? totalTickets;
  int? ticketsCreatedInPeriod;
  int? openTickets;
  int? closedTickets;
  int? resolvedTickets;
  List<ConnectorSupportTicketsMonthlyBreakdown>? monthlyBreakdown;

  ConnectorSupportTicketsAnalytics({
    this.totalTickets,
    this.ticketsCreatedInPeriod,
    this.openTickets,
    this.closedTickets,
    this.resolvedTickets,
    this.monthlyBreakdown,
  });

  ConnectorSupportTicketsAnalytics.fromJson(Map<String, dynamic> json) {
    totalTickets = json['total_tickets'];
    ticketsCreatedInPeriod = json['tickets_created_in_period'];
    openTickets = json['open_tickets'];
    closedTickets = json['closed_tickets'];
    resolvedTickets = json['resolved_tickets'];
    if (json['monthly_breakdown'] != null) {
      monthlyBreakdown = <ConnectorSupportTicketsMonthlyBreakdown>[];
      json['monthly_breakdown'].forEach((v) {
        monthlyBreakdown!.add(
          ConnectorSupportTicketsMonthlyBreakdown.fromJson(v),
        );
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_tickets'] = totalTickets;
    data['tickets_created_in_period'] = ticketsCreatedInPeriod;
    data['open_tickets'] = openTickets;
    data['closed_tickets'] = closedTickets;
    data['resolved_tickets'] = resolvedTickets;
    if (monthlyBreakdown != null) {
      data['monthly_breakdown'] = monthlyBreakdown!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class ConnectorSupportTicketsMonthlyBreakdown {
  int? monthNumber;
  String? monthName;
  int? year;
  int? ticketsCreated;
  int? openTickets;
  int? closedTickets;
  int? resolvedTickets;

  ConnectorSupportTicketsMonthlyBreakdown({
    this.monthNumber,
    this.monthName,
    this.year,
    this.ticketsCreated,
    this.openTickets,
    this.closedTickets,
    this.resolvedTickets,
  });

  ConnectorSupportTicketsMonthlyBreakdown.fromJson(Map<String, dynamic> json) {
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
