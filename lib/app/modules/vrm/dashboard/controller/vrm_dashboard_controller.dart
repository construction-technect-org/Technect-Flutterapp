import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/dashboard/model/vrm_dashboard_model.dart';
import 'package:construction_technect/app/modules/vrm/dashboard/services/vrm_dashboard_service.dart';

class VRMDashboardController extends GetxController {
  final isLoading = false.obs;
  final selectedFilterIndex = 0.obs;
  final filterTabs = [
    'Leads',
    'Contacted',
    'Qualified',
    'Requirement',
    'Quote sent',
    'Negotiation',
  ];

  final isCRMSelected = true.obs;

  final totalMarketing = true.obs;
  final totalSales = false.obs;
  final totalAccounts = false.obs;

  final _service = VRMDashboardService();

  // UI reactive fields
  final rawLeads = 0.obs;
  final followUpLeads = 0.obs;
  final pendingLeads = 0.obs;
  final rawLeadsText = "Request".obs;
  final followUpLeadsText = "Follow up".obs;
  final pendingLeadsText = "Qualified".obs;

  final totalTitle = "Total Enquiry".obs;
  final totalCountValue = "0".obs;
  final totalPercent = "0%".obs;
  final conversionPercent = 0.0.obs;

  final funnelData = <Map<String, dynamic>>[].obs;

  StageData? _enquiryData;
  StageData? _purchaseData;
  StageData? _accountsData;
  List<AnalysisItem> _combinedAnalysis = const [];

  final leadConversations = [
    {'location': 'Rp nagar', 'product': 'Manufacture sand', 'id': '47'},
    {'location': 'Xp nagar', 'product': 'Manufacture sand', 'id': '48'},
    {'location': 'Jp nagar', 'product': 'Manufacture sand', 'id': '49'},
  ].obs;

  final chatNotificationCount = 2.obs;
  final alertNotificationCount = 2.obs;
  final bellNotificationCount = 2.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboard();
  }

  Future<void> fetchDashboard() async {
    try {
      isLoading.value = true;
      final resp = await _service.fetchDashboard();
      _enquiryData = resp?.enquiry;
      _purchaseData = resp?.purchase;
      _accountsData = resp?.accounts;
      _combinedAnalysis = resp?.combinedAnalysis ?? const [];
      leadSectionWidget();
    } finally {
      isLoading.value = false;
    }
  }

  void onFilterTabChanged(int index) {
    selectedFilterIndex.value = index;

    if (filterTabs[index] == 'Requirement') {
      Get.toNamed(Routes.Add_New_REQUIREMENT);
    }
  }

  void leadSectionWidget() {
    if (totalMarketing.value) {
      _applyStageData(_enquiryData);
    } else if (totalSales.value) {
      _applyStageData(_purchaseData);
    } else {
      _applyStageData(_accountsData);
    }
  }

  String totalCount(int num) {
    if (num == 1) return totalTitle.value;
    if (num == 2) return totalCountValue.value;
    return totalPercent.value;
  }

  void toggleCRMVRM(bool isCRM) {
    isCRMSelected.value = isCRM;
  }

  void toggleMarketingSalesAccounts(String type) {
    if (type == 'Marketing') {
      totalMarketing.value = true;
      totalSales.value = false;
      totalAccounts.value = false;
    } else if (type == 'Sales') {
      totalMarketing.value = false;
      totalSales.value = true;
      totalAccounts.value = false;
    } else if (type == 'Accounts') {
      totalMarketing.value = false;
      totalSales.value = false;
      totalAccounts.value = true;
    }
    leadSectionWidget();
  }

  void _applyStageData(StageData? data) {
    if (data == null) {
      rawLeads.value = 0;
      followUpLeads.value = 0;
      pendingLeads.value = 0;
      totalTitle.value = "";
      totalCountValue.value = "0";
      totalPercent.value = "0%";
      conversionPercent.value = 0;
      funnelData.assignAll([]);
      return;
    }

    totalTitle.value = data.totalCount?.title ?? "";
    totalCountValue.value = (data.totalCount?.count ?? 0).toString();
    final pct = data.totalCount?.percentageChange ?? 0;
    totalPercent.value = "${pct.toString()}%";
    conversionPercent.value = (data.orderedRatio ?? 0).toDouble();

    final cards = data.statCards;
    rawLeads.value = cards.isNotEmpty ? (cards[0].value ?? 0) : 0;
    followUpLeads.value = cards.length > 1 ? (cards[1].value ?? 0) : 0;
    pendingLeads.value = cards.length > 2 ? (cards[2].value ?? 0) : 0;
    rawLeadsText.value = cards.isNotEmpty
        ? (cards[0].title ?? rawLeadsText.value)
        : rawLeadsText.value;
    followUpLeadsText.value = cards.length > 1
        ? (cards[1].title ?? followUpLeadsText.value)
        : followUpLeadsText.value;
    pendingLeadsText.value = cards.length > 2
        ? (cards[2].title ?? pendingLeadsText.value)
        : pendingLeadsText.value;

    final analysisSource = _combinedAnalysis.isNotEmpty ? _combinedAnalysis : data.analysis;

    funnelData.assignAll(
      analysisSource.map((e) {
        final label = e.label ?? e.salesLeadsStage ?? e.accountLeadsStage ?? '';
        return {'label': label, 'count': e.count ?? 0, 'color': _colorForLabel(label)};
      }).toList(),
    );
  }

  Color _colorForLabel(String label) {
    final key = label.toLowerCase();
    if (key.contains('lead')) return const Color(0xFFEF4444);
    if (key.contains('reach')) return const Color(0xFFF97316);
    if (key.contains('hold')) return const Color(0xFF22C55E);
    if (key.contains('miss')) return const Color(0xFF3B82F6);
    if (key.contains('pending')) return const Color(0xFFEAB308);
    if (key.contains('follow')) return const Color(0xFF06B6D4);
    if (key.contains('qual')) return const Color(0xFF10B981);
    if (key.contains('unqual') || key.contains('lost')) return const Color(0xFF6366F1);
    if (key.contains('closing')) return const Color(0xFF6366F1); // reuse CRM purple
    if (key.contains('sales')) return const Color(0xFF3B82F6); // reuse CRM blue
    if (key.contains('bill')) return const Color(0xFFEAB308); // reuse CRM yellow
    return MyColors.primary;
  }
}
