class VRMDashboardModel {
  final StageData? enquiry;
  final StageData? purchase;
  final StageData? accounts;
  final List<AnalysisItem> combinedAnalysis;

  VRMDashboardModel({this.enquiry, this.purchase, this.accounts, this.combinedAnalysis = const []});

  factory VRMDashboardModel.fromJson(Map<String, dynamic> json) => VRMDashboardModel(
    enquiry: json['enquiry'] == null ? null : StageData.fromJson(json['enquiry']),
    purchase: json['purchase'] == null ? null : StageData.fromJson(json['purchase']),
    accounts: json['accounts'] == null ? null : StageData.fromJson(json['accounts']),
    combinedAnalysis: json['combined_analysis'] == null
        ? const []
        : List<AnalysisItem>.from(json['combined_analysis'].map((e) => AnalysisItem.fromJson(e))),
  );
}

class StageData {
  final TotalCount? totalCount;
  final List<StatCard> statCards;
  final List<AnalysisItem> analysis;
  final int? orderedRatio;

  StageData({this.totalCount, required this.statCards, required this.analysis, this.orderedRatio});

  factory StageData.fromJson(Map<String, dynamic> json) => StageData(
    totalCount: json['total_count'] == null ? null : TotalCount.fromJson(json['total_count']),
    statCards: json['stat_cards'] == null
        ? []
        : List<StatCard>.from(json['stat_cards'].map((e) => StatCard.fromJson(e))),
    analysis: json['analysis'] == null
        ? []
        : List<AnalysisItem>.from(json['analysis'].map((e) => AnalysisItem.fromJson(e))),
    orderedRatio: json['ordered_ratio'],
  );
}

class TotalCount {
  final String? title;
  final int? count;
  final num? percentageChange;

  TotalCount({this.title, this.count, this.percentageChange});

  factory TotalCount.fromJson(Map<String, dynamic> json) => TotalCount(
    title: json['title'],
    count: json['count'],
    percentageChange: json['percentage_change'],
  );
}

class StatCard {
  final String? title;
  final int? value;

  StatCard({this.title, this.value});

  factory StatCard.fromJson(Map<String, dynamic> json) =>
      StatCard(title: json['title'], value: json['value']);
}

class AnalysisItem {
  final String? label;
  final int? count;
  final String? salesLeadsStage;
  final String? accountLeadsStage;

  AnalysisItem({this.label, this.count, this.salesLeadsStage, this.accountLeadsStage});

  factory AnalysisItem.fromJson(Map<String, dynamic> json) => AnalysisItem(
    label: json['label'],
    count: json['count'],
    salesLeadsStage: json['sales_leads_stage'],
    accountLeadsStage: json['account_leads_stage'],
  );
}
