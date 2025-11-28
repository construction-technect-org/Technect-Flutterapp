import 'package:construction_technect/app/core/utils/imports.dart';

class LeadDashController extends GetxController {
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
      Get.toNamed(Routes.Add_New_Requ);
    }
  }

  void leadSectionWidget() {
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

  String totalCount(int num) {
    if (num == 1) {
      if (totalMarketing.value) {
        return "Total Leads";
      } else if (totalSales.value) {
        return "Total Sales";
      } else if (totalAccounts.value) {
        return "Total Accounts";
      }
    } else if (num == 2) {
      if (totalMarketing.value) {
        return "98";
      } else if (totalSales.value) {
        return "₹ 2,45,000";
      } else if (totalAccounts.value) {
        return "₹ 2,45,000";
      }
    } else {
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

  void toggleCRMVRM(bool isCRM) {
    isCRMSelected.value = isCRM;
  }

  void toggleMarketingSalesAccounts(String type) {
    if (type == 'Marketing') {
      totalMarketing.value = true;
      totalSales.value = false;
      totalAccounts.value = false;
      // Get.toNamed(Routes.Marketing, arguments: {"isMarketing": true});
    } else if (type == 'Sales') {
      totalMarketing.value = false;
      totalSales.value = true;
      totalAccounts.value = false;
      // Get.toNamed(Routes.Marketing, arguments: {"isMarketing": false});
    } else if (type == 'Accounts') {
      totalMarketing.value = false;
      totalSales.value = false;
      totalAccounts.value = true;
    }
    leadSectionWidget();
  }

  void navigtionInLead() {
    if (totalMarketing.value) {
      Get.toNamed(Routes.Marketing, arguments: {"isMarketing": true});
    } else if (totalSales.value) {
      Get.toNamed(Routes.Marketing, arguments: {"isMarketing": false});
    } else {}
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
