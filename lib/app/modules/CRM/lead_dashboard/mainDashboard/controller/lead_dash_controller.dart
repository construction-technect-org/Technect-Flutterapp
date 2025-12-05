import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/mainDashboard/services/dashboard_service.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/mainDashboard/model/dashboard_model.dart';

class LeadDashController extends GetxController {
  final DashboardService _dashboardService = DashboardService();
  final isLoading = false.obs;

  // Dashboard data - stores all three dashboard types
  final allDashboardData = Rxn<AllDashboardData>();

  // Helper to get current dashboard data based on selected tab
  DashboardData? get currentDashboardData {
    if (allDashboardData.value == null) return null;
    if (totalMarketing.value) {
      return allDashboardData.value!.marketing;
    } else if (totalSales.value) {
      return allDashboardData.value!.sales;
    } else {
      return allDashboardData.value!.account;
    }
  }

  // Get conversion rate for marketing dashboard
  double get conversionRate {
    final data = allDashboardData.value?.marketing;
    return data?.conversionRate ?? 78.0;
  }

  // Get revenue summary for sales dashboard
  RevenueSummary? get revenueSummary {
    final data = allDashboardData.value?.sales;
    return data?.revenueSummary;
  }

  // Get total due for account dashboard
  TotalCount? get totalDue {
    final data = allDashboardData.value?.account;
    return data?.totalDue;
  }

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

  final rawLeads = 2.obs;
  final followUpLeads = 9.obs;
  final pendingLeads = 4.obs;
  final rawLeadsText = "Raw Leads".obs;
  final followUpLeadsText = "Follow up Leads".obs;
  final pendingLeadsText = "Pending Leads".obs;

  final funnelData = [
    {'label': 'Lead Generated', 'count': 45, 'color': const Color(0xFFEF4444)},
    {'label': 'Contacted', 'count': 30, 'color': const Color(0xFFF97316)},
    {'label': 'Requirement', 'count': 15, 'color': const Color(0xFF22C55E)},
    {'label': 'Quote Sent', 'count': 23, 'color': const Color(0xFF3B82F6)},
    {'label': 'Negotiation', 'count': 14, 'color': const Color(0xFFEAB308)},
    {'label': 'Follow up', 'count': 15, 'color': const Color(0xFF06B6D4)},
    {'label': 'Deal Won', 'count': 20, 'color': const Color(0xFF10B981)},
    {'label': 'Deal Lost', 'count': 5, 'color': const Color(0xFF6366F1)},
  ].obs;

  final leadConversations = [
    {'location': 'Rp nagar', 'product': 'Manufacture sand', 'id': '47'},
    {'location': 'Xp nagar', 'product': 'Manufacture sand', 'id': '48'},
    {'location': 'Jp nagar', 'product': 'Manufacture sand', 'id': '49'},
  ].obs;

  final chatNotificationCount = 2.obs;
  final alertNotificationCount = 2.obs;
  final bellNotificationCount = 2.obs;

  void onFilterTabChanged(int index) {
    selectedFilterIndex.value = index;

    if (filterTabs[index] == 'Requirement') {
      Get.toNamed(Routes.Add_New_REQUIREMENT);
    }
  }

  void leadSectionWidget() {
    final data = currentDashboardData;

    if (data != null && data.statCards.isNotEmpty) {
      // Use API data
      rawLeads.value = data.statCards[0].value;
      rawLeadsText.value = data.statCards[0].title;

      if (data.statCards.length > 1) {
        followUpLeads.value = data.statCards[1].value;
        followUpLeadsText.value = data.statCards[1].title;
      }

      if (data.statCards.length > 2) {
        pendingLeads.value = data.statCards[2].value;
        pendingLeadsText.value = data.statCards[2].title;
      }
    } else {
      // Fallback to hardcoded values
      if (totalMarketing.value) {
        rawLeads.value = 2;
        followUpLeads.value = 9;
        pendingLeads.value = 4;
        rawLeadsText.value = "Raw Leads";
        followUpLeadsText.value = "Follow up Leads";
        pendingLeadsText.value = "Pending Leads";
      } else if (totalSales.value) {
        rawLeads.value = 120;
        followUpLeads.value = 80;
        pendingLeads.value = 40;
        rawLeadsText.value = "New Sales";
        followUpLeadsText.value = "In- Progresss";
        pendingLeadsText.value = "Sales Won";
      } else {
        rawLeads.value = 100;
        followUpLeads.value = 80;
        pendingLeads.value = 120;
        rawLeadsText.value = "Pending";
        followUpLeadsText.value = "Follow up";
        pendingLeadsText.value = "Collected";
      }
    }
  }

  String totalCount(int num) {
    final data = currentDashboardData;

    if (num == 1) {
      // Return title
      return data?.totalCount.title ??
          (totalMarketing.value
              ? "Total Leads"
              : totalSales.value
              ? "Total Sales"
              : "Total Accounts");
    } else if (num == 2) {
      // Return count (formatted)
      if (data?.totalCount != null) {
        final count = data!.totalCount.count;
        if (totalMarketing.value) {
          return count.toString();
        } else {
          // Format as currency for sales and account
          return "₹ ${_formatCurrency(count)}";
        }
      }
      // Fallback to hardcoded values
      if (totalMarketing.value) {
        return "98";
      } else if (totalSales.value) {
        return "₹ 2,45,000";
      } else if (totalAccounts.value) {
        return "₹ 2,45,000";
      }
    } else {
      // Return percentage change
      if (data?.totalCount != null) {
        final change = data!.totalCount.percentageChange;
        final sign = change >= 0 ? "+" : "";
        return "$sign${change.toStringAsFixed(1)}%";
      }
      // Fallback to hardcoded values
      if (totalMarketing.value) {
        return "+5.3%";
      } else if (totalSales.value) {
        return "+6.8%";
      } else if (totalAccounts.value) {
        return "+7.3%";
      }
    }
    return "";
  }

  String _formatCurrency(int amount) {
    if (amount >= 100000) {
      return "${(amount / 100000).toStringAsFixed(2)}L";
    } else if (amount >= 1000) {
      return "${(amount / 1000).toStringAsFixed(0)}K";
    }
    return amount.toString();
  }

  // Expose formatCurrency for use in views
  String formatCurrency(int amount) => _formatCurrency(amount);

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
    // Update UI with cached data (no API call needed)
    updateDashboardUI();
    leadSectionWidget();
  }

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;

      // Fetch all three dashboard types in one API call
      final response = await _dashboardService.getDashboard();
      allDashboardData.value = response.data;

      // Update UI with current tab's data
      updateDashboardUI();
    } catch (e) {
      debugPrint('Error fetching dashboard: $e');
      // Keep existing hardcoded values on error
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh dashboard data (for pull-to-refresh)
  Future<void> refreshDashboard() async {
    await fetchDashboardData();
  }

  void updateDashboardUI() {
    final data = currentDashboardData;
    if (data == null) return;
    // Update total count
    if (data.totalCount != null) {
      // The totalCount method will use dashboardData
    }

    // Update stat cards
    if (data.statCards.isNotEmpty) {
      rawLeads.value = data.statCards[0].value;
      rawLeadsText.value = data.statCards[0].title;

      if (data.statCards.length > 1) {
        followUpLeads.value = data.statCards[1].value;
        followUpLeadsText.value = data.statCards[1].title;
      }

      if (data.statCards.length > 2) {
        pendingLeads.value = data.statCards[2].value;
        pendingLeadsText.value = data.statCards[2].title;
      }
    }

    // Update funnel data
    if (data.funnelData.isNotEmpty) {
      funnelData.value = data.funnelData
          .map(
            (f) => {
              'label': f.label,
              'count': f.count,
              'color': _parseColor(f.color),
            },
          )
          .toList();
    }

    // Update product chart
    if (data.productChart.isNotEmpty) {
      productA.value = data.productChart
          .map((p) => p.productA.toDouble())
          .toList();
      productB.value = data.productChart
          .map((p) => p.productB.toDouble())
          .toList();
    }
  }

  Color _parseColor(String colorString) {
    // Remove # if present
    final hex = colorString.replaceAll('#', '');
    // Parse hex to Color
    return Color(int.parse('FF$hex', radix: 16));
  }

  void navigtionInLead() {
    if (totalMarketing.value) {
      Get.toNamed(Routes.Marketing, arguments: {"isMarketing": true});
    } else if (totalSales.value) {
      Get.toNamed(Routes.SALES, arguments: {"isMarketing": true});
    } else {
      Get.toNamed(Routes.ACCOUNT_LEAD, arguments: {"isMarketing": true});
    }
  }

  final months = <String>[
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];

  final productA = <double>[
    500,
    850,
    850,
    480,
    580,
    720,
    1100,
    1020,
    950,
    980,
    1100,
    1050,
  ].obs;
  final productB = <double>[
    200,
    480,
    700,
    780,
    720,
    640,
    660,
    700,
    850,
    1150,
    1200,
    1100,
  ].obs;
  final showA = true.obs;
  final showB = true.obs;

  void updateProductA(List<double> newValues) {
    productA.assignAll(newValues);
    update();
  }

  void updateProductB(List<double> newValues) {
    productB.assignAll(newValues);
    update();
  }

  void toggleA() => showA.toggle();
  void toggleB() => showB.toggle();
}
