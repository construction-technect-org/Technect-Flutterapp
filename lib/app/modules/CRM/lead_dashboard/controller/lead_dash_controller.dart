import 'package:construction_technect/app/core/utils/imports.dart';

class LeadDashController extends GetxController {
  final isLoading = false.obs;

  // Filter tabs
  final selectedFilterIndex = 0.obs;
  final filterTabs = [
    'Leads',
    'Contacted',
    'Qualified',
    'Requirement',
    'Quote sent',
    'Negotiation',
  ];

  // CRM/VRM toggle
  final isCRMSelected = true.obs;

  // Marketing / Sales / Accounts data
  final totalMarketing = true.obs;
  final totalSales = false.obs;
  final totalAccounts = false.obs;

  // Task data
  final rawLeads = 2.obs;
  final followUpLeads = 9.obs;
  final pendingLeads = 4.obs;

  // Pipeline data
  final pipelineData = [
    {'label': 'Leads', 'count': 45, 'color': const Color(0xFFFF6B6B)},
    {'label': 'Contacted', 'count': 23, 'color': const Color(0xFFFFD93D)},
    {'label': 'Qualified', 'count': 12, 'color': const Color(0xFF6BCF7F)},
    {'label': 'Quote Sent', 'count': 8, 'color': const Color(0xFF4ECDC4)},
  ].obs;

  // Analysis funnel data
  final funnelData = [
    {'label': 'Lead Generated', 'count': 45, 'color': const Color(0xFFFF6B6B)},
    {'label': 'Contacted', 'count': 30, 'color': const Color(0xFFFFA07A)},
    {'label': 'Requirement', 'count': 15, 'color': const Color(0xFFFFD93D)},
    {'label': 'Quote Sent', 'count': 23, 'color': const Color(0xFF90EE90)},
    {'label': 'Negotiation', 'count': 14, 'color': const Color(0xFF6BCF7F)},
    {'label': 'Follow up', 'count': 15, 'color': const Color(0xFF87CEEB)},
    {'label': 'Deal Won', 'count': 20, 'color': const Color(0xFF4ECDC4)},
    {'label': 'Deal Lost', 'count': 5, 'color': const Color(0xFF9370DB)},
  ].obs;

  // Lead conversations
  final leadConversations = [
    {'location': 'Rp nagar', 'product': 'Manufacture sand', 'id': '47'},
    {'location': 'Xp nagar', 'product': 'Manufacture sand', 'id': '48'},
    {'location': 'Jp nagar', 'product': 'Manufacture sand', 'id': '49'},
  ].obs;

  // Notification counts
  final chatNotificationCount = 2.obs;
  final alertNotificationCount = 2.obs;
  final bellNotificationCount = 2.obs;

  void onFilterTabChanged(int index) {
    selectedFilterIndex.value = index;

    if (filterTabs[index] == 'Requirement') {
      Get.toNamed(Routes.Add_New_Requ);
    }
  }

  void toggleCRMVRM(bool isCRM) {
    isCRMSelected.value = isCRM;
    // Load data based on selection
  }

  void toggleMarketingSalesAccounts(String type) {
    if (type == 'Marketing') {
      totalMarketing.value = true;
      totalSales.value = false;
      totalAccounts.value = false;
      Get.toNamed(Routes.Marketing);
    } else if (type == 'Sales') {
      totalMarketing.value = false;
      totalSales.value = true;
      totalAccounts.value = false;
    } else if (type == 'Accounts') {
      totalMarketing.value = false;
      totalSales.value = false;
      totalAccounts.value = true;
    }
  }

  //============ Additional methods to fetch/update data can be added here ============//
  // Months labels (fixed)
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
  ];

  // Products values as reactive lists (K = thousands). You can update these at runtime.
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
  ].obs;

  // Toggle visibility of series
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
