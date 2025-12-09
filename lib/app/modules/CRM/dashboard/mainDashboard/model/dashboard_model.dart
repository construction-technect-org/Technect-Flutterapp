class DashboardModel {
  final bool success;
  final String message;
  final AllDashboardData data;

  DashboardModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: AllDashboardData.fromJson(json['data'] ?? {}),
    );
  }
}

class AllDashboardData {
  final DashboardData marketing;
  final DashboardData sales;
  final DashboardData account;

  AllDashboardData({
    required this.marketing,
    required this.sales,
    required this.account,
  });

  factory AllDashboardData.fromJson(Map<String, dynamic> json) {
    return AllDashboardData(
      marketing: DashboardData.fromJson(json['marketing'] ?? {}),
      sales: DashboardData.fromJson(json['sales'] ?? {}),
      account: DashboardData.fromJson(json['account'] ?? {}),
    );
  }
}

class DashboardData {
  final TotalCount totalCount;
  final TotalCount? totalDue; // Only for account dashboard
  final List<StatCard> statCards;
  final List<FunnelData> funnelData;
  final List<ProductChartData> productChart;
  final double? conversionRate; // Only for marketing dashboard
  final RevenueSummary? revenueSummary; // Only for sales dashboard

  DashboardData({
    required this.totalCount,
    this.totalDue,
    required this.statCards,
    required this.funnelData,
    required this.productChart,
    this.conversionRate,
    this.revenueSummary,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      totalCount: TotalCount.fromJson(json['total_count'] ?? {}),
      totalDue: json['total_due'] != null
          ? TotalCount.fromJson(json['total_due'])
          : null,
      statCards:
          (json['stat_cards'] as List<dynamic>?)
              ?.map((e) => StatCard.fromJson(e))
              .toList() ??
          [],
      funnelData:
          (json['funnel_data'] as List<dynamic>?)
              ?.map((e) => FunnelData.fromJson(e))
              .toList() ??
          [],
      productChart:
          (json['product_chart'] as List<dynamic>?)
              ?.map((e) => ProductChartData.fromJson(e))
              .toList() ??
          [],
      conversionRate: json['conversion_rate']?.toDouble(),
      revenueSummary: json['revenue_summary'] != null
          ? RevenueSummary.fromJson(json['revenue_summary'])
          : null,
    );
  }
}

class TotalCount {
  final String title;
  final int count;
  final double percentageChange;

  TotalCount({
    required this.title,
    required this.count,
    required this.percentageChange,
  });

  factory TotalCount.fromJson(Map<String, dynamic> json) {
    return TotalCount(
      title: json['title'] ?? '',
      count: json['count'] ?? 0,
      percentageChange: (json['percentage_change'] ?? 0).toDouble(),
    );
  }
}

class StatCard {
  final String title;
  final int value;

  StatCard({required this.title, required this.value});

  factory StatCard.fromJson(Map<String, dynamic> json) {
    return StatCard(title: json['title'] ?? '', value: json['value'] ?? 0);
  }
}

class FunnelData {
  final String label;
  final int count;
  final String color;

  FunnelData({required this.label, required this.count, required this.color});

  factory FunnelData.fromJson(Map<String, dynamic> json) {
    return FunnelData(
      label: json['label'] ?? '',
      count: json['count'] ?? 0,
      color: json['color'] ?? '#000000',
    );
  }

  Map<String, dynamic> toJson() {
    return {'label': label, 'count': count, 'color': color};
  }
}

class ProductChartData {
  final String month;
  final int productA;
  final int productB;

  ProductChartData({
    required this.month,
    required this.productA,
    required this.productB,
  });

  factory ProductChartData.fromJson(Map<String, dynamic> json) {
    return ProductChartData(
      month: json['month'] ?? '',
      productA: json['productA'] ?? 0,
      productB: json['productB'] ?? 0,
    );
  }
}

class RevenueSummary {
  final int totalRevenue;
  final int thisMonth;
  final int pendingPayments;
  final int closedDeals;

  RevenueSummary({
    required this.totalRevenue,
    required this.thisMonth,
    required this.pendingPayments,
    required this.closedDeals,
  });

  factory RevenueSummary.fromJson(Map<String, dynamic> json) {
    return RevenueSummary(
      totalRevenue: json['total_revenue'] ?? 0,
      thisMonth: json['this_month'] ?? 0,
      pendingPayments: json['pending_payments'] ?? 0,
      closedDeals: json['closed_deals'] ?? 0,
    );
  }
}
