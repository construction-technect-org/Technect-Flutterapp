import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/model/vrm_lead_model.dart';
import 'package:construction_technect/app/modules/vrm/task/services/vrm_task_service.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/vrm_account_bills_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/vrm_account_collect_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/vrm_account_outstanding_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/vrm_followup_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/vrm_lead_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/vrm_prospect_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/vrm_qualified_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/vrm_sale_followup_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/vrm_sale_lead_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/vrm_sale_prospect_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/vrm_sale_qualified_screen.dart';

class VrmTaskController extends GetxController {
  final currentTab = 0.obs;
  final isLoading = false.obs;
  final leads = <VrmLead>[].obs;
  final VrmTaskService _service = VrmTaskService();
  final allLeads = <VrmLead>[].obs;
  final salesLeads = <VrmLead>[].obs;
  final accountLeads = <VrmLead>[].obs;

  // Marketing/Enquiry filters
  RxString activeFilter = 'Lead'.obs;
  RxString activeLeadStatusFilter = 'All'.obs;
  RxString activeFollowUpStatusFilter = 'Pending'.obs;
  RxString activeProspectStatusFilter = 'Fresh'.obs;
  RxString activeQualifiedStatusFilter = 'Pending'.obs;
  RxString selectedPriority = "High".obs;

  final items = ['Lead', 'Follow Up', 'Prospect', 'Qualified'];
  final leadStatus = <String>["All", "Inbound", "Outbound"];
  final List<String> statusItems = <String>["Pending", "Completed", "Missed"];
  final List<String> statusProspectItems = <String>["Fresh", "Reached Out", "Converted", "On Hold"];
  final List<String> qualifiedStatus = <String>["Pending", "Qualified", "Lost"];

  RxInt todaysTotal = 0.obs;
  RxInt salesTodaysTotal = 0.obs;
  RxInt accountTodaysTotal = 0.obs;

  // Accounts filters
  RxString activeAccountFilter = 'Bill'.obs;
  RxString activeBillsStatusFilter = 'Pending'.obs;
  RxString activeOutStandingStatusFilter = 'Pending'.obs;
  RxString activeCollectStatusFilter = 'Pending'.obs;

  final accountItems = ['Bill', 'Out Standing', 'Collect'];
  final List<String> billStatus = <String>["Pending", "Tax Bill", "Non Tax Bill"];
  final List<String> outStandingStatus = <String>["Pending", "Completed", "Missed"];
  final List<String> collectStatus = <String>["Pending", "Completed", "Missed"];

  RxList<VrmLead> accountAllBillList = <VrmLead>[].obs;
  RxList<VrmLead> accountAllOutStandingList = <VrmLead>[].obs;
  RxList<VrmLead> accountAllCollectList = <VrmLead>[].obs;

  // Sales/Purchase filters
  RxString activeSalesFilter = 'Lead'.obs;
  RxString activeSalesLeadStatusFilter = 'All'.obs;
  RxString activeSalesFollowUpStatusFilter = 'Pending'.obs;
  RxString activeSalesProspectStatusFilter = 'Sent'.obs;
  RxString activeSalesQualifiedStatusFilter = 'Pending'.obs;

  final salesItems = ['Lead', 'Follow Up', 'Quote Sent', 'Closing'];
  final salesLeadStatus = <String>["All", "Inbound", "Outbound"];
  final List<String> salesStatusItems = <String>["Pending", "Completed", "Missed"];
  final List<String> salesStatusProspectItems = <String>["Sent", "Accepted", "Negotiation"];
  final List<String> salesQualifiedStatus = <String>["Pending", "Won", "Lost"];

  RxList<VrmLead> salesAllLeadList = <VrmLead>[].obs;
  RxList<VrmLead> salesAllFollowUpList = <VrmLead>[].obs;
  RxList<VrmLead> salesAllProspectList = <VrmLead>[].obs;
  RxList<VrmLead> salesAllQualifiedList = <VrmLead>[].obs;

  // Lazy load filter screens to avoid circular dependencies
  Widget getFilterScreen(String filter) {
    switch (filter) {
      case 'Lead':
        return const VrmLeadScreen();
      case 'Follow Up':
        return const VrmFollowupScreen();
      case 'Prospect':
        return const VrmProspectScreen();
      case 'Qualified':
        return const VrmQualifiedScreen();
      default:
        return const VrmLeadScreen();
    }
  }

  Widget getSalesFilterScreen(String filter) {
    switch (filter) {
      case 'Lead':
        return const VrmSaleLeadScreen();
      case 'Follow Up':
        return const VrmSaleFollowupScreen();
      case 'Quote Sent':
        return const VrmSaleProspectScreen();
      case 'Closing':
        return const VrmSaleQualifiedScreen();
      default:
        return const VrmSaleLeadScreen();
    }
  }

  Widget getAccountFilterScreen(String filter) {
    switch (filter) {
      case 'Bill':
        return const VrmAccountBillsScreen();
      case 'Out Standing':
        return const VrmAccountOutstandingScreen();
      case 'Collect':
        return const VrmAccountCollectScreen();
      default:
        return const VrmAccountBillsScreen();
    }
  }

  RxList<VrmLead> allLeadList = <VrmLead>[].obs;
  RxList<VrmLead> allFollowUpList = <VrmLead>[].obs;
  RxList<VrmLead> allProspectList = <VrmLead>[].obs;
  RxList<VrmLead> allQualifiedList = <VrmLead>[].obs;

  // Filtered getters
  List<VrmLead> get filteredLead {
    if (activeLeadStatusFilter.value.toLowerCase() == "inbound") {
      return allLeadList.where((e) => e.isAutoCreated == true).toList();
    }
    if (activeLeadStatusFilter.value.toLowerCase() == "outbound") {
      return allLeadList.where((e) => e.isAutoCreated == false).toList();
    }
    return allLeadList.toList();
  }

  List<VrmLead> get filteredFollowups {
    if (activeFollowUpStatusFilter.value.toLowerCase() == "pending") {
      return allFollowUpList.where((e) => (e.status ?? '').toLowerCase() == "pending").toList();
    }
    if (activeFollowUpStatusFilter.value.toLowerCase() == "completed") {
      return allFollowUpList.where((e) => (e.status ?? '').toLowerCase() == "fresh").toList();
    }
    if (activeFollowUpStatusFilter.value.toLowerCase() == "missed") {
      return allFollowUpList.where((e) => (e.status ?? '').toLowerCase() == "missed").toList();
    }
    return allFollowUpList.toList();
  }

  List<VrmLead> get filteredProspect {
    final status = activeProspectStatusFilter.value.toLowerCase();
    if (status == "fresh") {
      return allProspectList.where((e) => (e.status ?? '').toLowerCase() == "fresh").toList();
    }
    if (status == "reached out") {
      return allProspectList.where((e) => (e.status ?? '').toLowerCase() == "reached_out").toList();
    }
    if (status == "converted") {
      return allProspectList.where((e) {
        final stage = (e.leadStage ?? '').toLowerCase();
        final stat = (e.status ?? '').toLowerCase();
        return stage == "qualified" && stat == "pending";
      }).toList();
    }
    if (status == "on hold") {
      return allProspectList.where((e) => (e.status ?? '').toLowerCase() == "on_hold").toList();
    }
    return allProspectList.toList();
  }

  List<VrmLead> get filteredQualified {
    final status = activeQualifiedStatusFilter.value.toLowerCase();
    if (status == "pending") {
      return allQualifiedList.where((e) {
        final stage = (e.leadStage ?? '').toLowerCase();
        final stat = (e.status ?? '').toLowerCase();
        return stage == "qualified" && stat == "pending";
      }).toList();
    }
    if (status == "qualified") {
      return allQualifiedList.where((e) => (e.status ?? '').toLowerCase() == "qualified").toList();
    }
    if (status == "lost") {
      return allQualifiedList.where((e) => (e.status ?? '').toLowerCase() == "lost").toList();
    }
    return allQualifiedList.toList();
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((val) {
      fetchAllLeads(isLoad: true);
    });
  }

  Future<void> fetchAllLeads({bool? isLoad}) async {
    isLoading.value = isLoad ?? false;
    try {
      final response = await _service.fetchAllLeads();
      final list = response.data?.leads ?? [];
      allLeads.assignAll(list);

      // Filter by main_stage and also include leads with relevant stage/status fields
      leads.assignAll(
        list.where((e) {
          final mainStage = e.mainStage ?? '';
          final hasSalesData = e.salesLeadsStage != null || e.salesLeadStatus != null;
          final hasAccountData = e.accountLeadsStage != null || e.accountLeadStatus != null;
          // Include if main_stage is Enquiry, or has lead_stage/status but no sales/account data
          return mainStage == 'Enquiry' ||
              (mainStage != 'Purchase' &&
                  mainStage != 'Account' &&
                  !hasSalesData &&
                  !hasAccountData);
        }).toList(),
      );
      salesLeads.assignAll(
        list.where((e) {
          final mainStage = e.mainStage ?? '';
          final hasSalesData = e.salesLeadsStage != null || e.salesLeadStatus != null;
          // Include if main_stage is Purchase OR has sales data
          return mainStage == 'Purchase' || hasSalesData;
        }).toList(),
      );
      accountLeads.assignAll(
        list.where((e) {
          final mainStage = e.mainStage ?? '';
          final hasAccountData = e.accountLeadsStage != null || e.accountLeadStatus != null;
          // Include if main_stage is Account OR has account data
          return mainStage == 'Account' || hasAccountData;
        }).toList(),
      );

      // Apply filters
      filterLead();
      filterSalesLead();
      filterAccountLead();
    } catch (e) {
      if (kDebugMode) debugPrint('VRM fetchAllLeads error: $e');
      allLeads.clear();
      leads.clear();
      salesLeads.clear();
      accountLeads.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void setTab(int index) {
    currentTab.value = index;
    // Ensure Enquiry tab always starts on Lead view
    if (index == 0) {
      activeFilter.value = 'Lead';
    }
    // Ensure Purchase tab always starts on Lead view
    if (index == 1) {
      activeSalesFilter.value = 'Lead';
    }
    // Ensure Accounts tab always starts on Bill view
    if (index == 2) {
      activeAccountFilter.value = 'Bill';
    }
  }

  void setFilter(String f) {
    activeFilter.value = f;
    filterLead();
  }

  String getFilterStatusName() {
    if (activeFilter.value == "Lead") {
      return "lead";
    }
    if (activeFilter.value == "Follow Up") {
      return "follow_up";
    }
    if (activeFilter.value == "Prospect") {
      return "prospect";
    }
    if (activeFilter.value == "Qualified") {
      return "qualified";
    }
    return "new";
  }

  void setStatusFilter(String f) {
    activeFollowUpStatusFilter.value = f;
  }

  void setStatusProspectFilter(String f) {
    activeProspectStatusFilter.value = f;
  }

  void setStatusQualifiedFilter(String f) {
    activeQualifiedStatusFilter.value = f;
  }

  void setStatusLeadFilter(String f) {
    activeLeadStatusFilter.value = f;
  }

  void filterLead() {
    final DateTime today = DateTime.now();
    final String todayStr =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    final List<VrmLead> all = leads.toList();

    final List<VrmLead> todaysLeads = all.where((e) {
      if (e.createdAt == null) return false;
      try {
        final DateTime d = DateTime.parse(e.createdAt!);
        final String dateStr =
            "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
        return dateStr == todayStr;
      } catch (e) {
        return false;
      }
    }).toList();

    if (getFilterStatusName() == "lead") {
      allLeadList
        ..clear()
        ..addAll(
          all.where((e) {
            final stage = (e.leadStage ?? '').toLowerCase();
            final stat = (e.status ?? '').toLowerCase();
            return stage == "lead" || stat == "lead";
          }),
        );

      todaysTotal.value = todaysLeads.where((e) {
        final stage = (e.leadStage ?? '').toLowerCase();
        final stat = (e.status ?? '').toLowerCase();
        return stage == "lead" || stat == "lead";
      }).length;
    } else if (getFilterStatusName() == "follow_up") {
      allFollowUpList
        ..clear()
        ..addAll(
          all.where((e) {
            final stage = (e.leadStage ?? '').toLowerCase();
            final stat = (e.status ?? '').toLowerCase();
            return stage == "follow_up" || (stage == "prospect" && stat == "fresh");
          }),
        );

      todaysTotal.value = todaysLeads.where((e) {
        final stage = (e.leadStage ?? '').toLowerCase();
        final stat = (e.status ?? '').toLowerCase();
        return stage == "follow_up" || (stage == "prospect" && stat == "fresh");
      }).length;
    } else if (getFilterStatusName() == "prospect") {
      allProspectList
        ..clear()
        ..addAll(
          all.where((e) {
            final stage = (e.leadStage ?? '').toLowerCase();
            final stat = (e.status ?? '').toLowerCase();
            return stage == "prospect" || (stat == "pending" && stage == "qualified");
          }),
        );

      todaysTotal.value = todaysLeads.where((e) {
        final stage = (e.leadStage ?? '').toLowerCase();
        final stat = (e.status ?? '').toLowerCase();
        return stage == "prospect" || (stat == "pending" && stage == "qualified");
      }).length;
    } else if (getFilterStatusName() == "qualified") {
      allQualifiedList
        ..clear()
        ..addAll(
          all.where((e) {
            final stage = (e.leadStage ?? '').toLowerCase();
            final stat = (e.status ?? '').toLowerCase();
            return stage == "qualified" || stat == "qualified";
          }),
        );

      todaysTotal.value = todaysLeads.where((e) {
        final stage = (e.leadStage ?? '').toLowerCase();
        final stat = (e.status ?? '').toLowerCase();
        return stage == "qualified" || stat == "qualified";
      }).length;
    }
  }

  // Sales filtered getters
  List<VrmLead> get filteredSalesLead {
    if (activeSalesLeadStatusFilter.value.toLowerCase() == "inbound") {
      return salesAllLeadList.where((e) => e.isAutoCreated == true).toList();
    }
    if (activeSalesLeadStatusFilter.value.toLowerCase() == "outbound") {
      return salesAllLeadList.where((e) => e.isAutoCreated == false).toList();
    }
    return salesAllLeadList.toList();
  }

  List<VrmLead> get filteredSalesFollowups {
    if (activeSalesFollowUpStatusFilter.value.toLowerCase() == "pending") {
      return salesAllFollowUpList
          .where((e) => (e.salesLeadStatus ?? '').toLowerCase() == "pending")
          .toList();
    }
    if (activeSalesFollowUpStatusFilter.value.toLowerCase() == "completed") {
      return salesAllFollowUpList
          .where((e) => (e.salesLeadStatus ?? '').toLowerCase() == "sent")
          .toList();
    }
    if (activeSalesFollowUpStatusFilter.value.toLowerCase() == "missed") {
      return salesAllFollowUpList
          .where((e) => (e.salesLeadStatus ?? '').toLowerCase() == "missed")
          .toList();
    }
    return salesAllFollowUpList.toList();
  }

  List<VrmLead> get filteredSalesProspect {
    final status = activeSalesProspectStatusFilter.value.toLowerCase();
    if (status == "sent") {
      return salesAllProspectList
          .where((e) => (e.salesLeadStatus ?? '').toLowerCase() == "sent")
          .toList();
    }
    if (status == "accepted") {
      return salesAllProspectList.where((e) {
        final stage = (e.salesLeadsStage ?? '').toLowerCase();
        final stat = (e.salesLeadStatus ?? '').toLowerCase();
        return stage == "closing" && stat == "won";
      }).toList();
    }
    if (status == "negotiation") {
      return salesAllProspectList
          .where((e) => (e.salesLeadStatus ?? '').toLowerCase() == "negotiation")
          .toList();
    }
    return salesAllProspectList.toList();
  }

  List<VrmLead> get filteredSalesQualified {
    final status = activeSalesQualifiedStatusFilter.value.toLowerCase();
    if (status == "pending") {
      return salesAllQualifiedList
          .where((e) => (e.salesLeadStatus ?? '').toLowerCase() == "pending")
          .toList();
    }
    if (status == "won") {
      return salesAllQualifiedList
          .where((e) => (e.salesLeadStatus ?? '').toLowerCase() == "won")
          .toList();
    }
    if (status == "lost") {
      return salesAllQualifiedList
          .where((e) => (e.salesLeadStatus ?? '').toLowerCase() == "lost")
          .toList();
    }
    return salesAllQualifiedList.toList();
  }

  void setSalesFilter(String f) {
    activeSalesFilter.value = f;
    filterSalesLead();
  }

  String getSalesFilterStatusName() {
    if (activeSalesFilter.value == "Lead") {
      return "sales";
    }
    if (activeSalesFilter.value == "Follow Up") {
      return "follow_up";
    }
    if (activeSalesFilter.value == "Quote Sent") {
      return "quote_sent";
    }
    if (activeSalesFilter.value == "Closing") {
      return "closing";
    }
    return "sales";
  }

  void setSalesStatusFilter(String f) {
    activeSalesFollowUpStatusFilter.value = f;
  }

  void setSalesStatusProspectFilter(String f) {
    activeSalesProspectStatusFilter.value = f;
  }

  void setSalesStatusQualifiedFilter(String f) {
    activeSalesQualifiedStatusFilter.value = f;
  }

  void setSalesStatusLeadFilter(String f) {
    activeSalesLeadStatusFilter.value = f;
  }

  void filterSalesLead() {
    final DateTime today = DateTime.now();
    final String todayStr =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    final List<VrmLead> all = salesLeads.toList();

    final List<VrmLead> todaysLeads = all.where((e) {
      if (e.createdAt == null) return false;
      try {
        final DateTime d = DateTime.parse(e.createdAt!);
        final String dateStr2 =
            "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
        return dateStr2 == todayStr;
      } catch (e) {
        return false;
      }
    }).toList();

    if (getSalesFilterStatusName() == "sales") {
      salesAllLeadList
        ..clear()
        ..addAll(
          all.where(
            (e) =>
                (e.salesLeadStatus ?? '').toLowerCase() == "new" ||
                (e.salesLeadsStage ?? '').toLowerCase() == "sales",
          ),
        );

      salesTodaysTotal.value = todaysLeads
          .where(
            (e) =>
                (e.salesLeadStatus ?? '').toLowerCase() == "new" ||
                (e.salesLeadsStage ?? '').toLowerCase() == "sales",
          )
          .length;
    } else if (getSalesFilterStatusName() == "follow_up") {
      salesAllFollowUpList
        ..clear()
        ..addAll(
          all.where((e) {
            final stage = (e.salesLeadsStage ?? '').toLowerCase();
            final stat = (e.salesLeadStatus ?? '').toLowerCase();
            return stage == "follow_up" || (stage == "quote_sent" && stat == "sent");
          }),
        );

      salesTodaysTotal.value = todaysLeads.where((e) {
        final stage = (e.salesLeadsStage ?? '').toLowerCase();
        final stat = (e.salesLeadStatus ?? '').toLowerCase();
        return stage == "follow_up" || (stage == "quote_sent" && stat == "sent");
      }).length;
    } else if (getSalesFilterStatusName() == "quote_sent") {
      salesAllProspectList
        ..clear()
        ..addAll(
          all.where((e) {
            final stage = (e.salesLeadsStage ?? '').toLowerCase();
            final stat = (e.salesLeadStatus ?? '').toLowerCase();
            return stage == "quote_sent" || (stat == "pending" && stage == "closing");
          }),
        );

      salesTodaysTotal.value = todaysLeads.where((e) {
        final stage = (e.salesLeadsStage ?? '').toLowerCase();
        final stat = (e.salesLeadStatus ?? '').toLowerCase();
        return stage == "quote_sent" || (stat == "pending" && stage == "closing");
      }).length;
    } else if (getSalesFilterStatusName() == "closing") {
      salesAllQualifiedList
        ..clear()
        ..addAll(all.where((e) => (e.salesLeadsStage ?? '').toLowerCase() == "closing"));

      salesTodaysTotal.value = todaysLeads
          .where((e) => (e.salesLeadsStage ?? '').toLowerCase() == "closing")
          .length;
    }
  }

  Future<void> fetchLeads({bool? isLoad}) async {
    await fetchAllLeads(isLoad: isLoad);
  }

  Future<void> fetchSalesLeads({bool? isLoad}) async {
    await fetchAllLeads(isLoad: isLoad);
  }

  // Account filtered getters
  List<VrmLead> get filteredAccountBills {
    if (activeBillsStatusFilter.value.toLowerCase() == "pending") {
      return accountAllBillList
          .where((e) => (e.accountLeadStatus ?? '').toLowerCase() == "pending")
          .toList();
    }
    if (activeBillsStatusFilter.value.toLowerCase() == "tax bill") {
      return accountAllBillList.where((e) => e.isAutoCreated == true).toList();
    }
    if (activeBillsStatusFilter.value.toLowerCase() == "non tax bill") {
      return accountAllBillList.where((e) => e.isAutoCreated == false).toList();
    }
    return accountAllBillList.toList();
  }

  List<VrmLead> get filteredAccountOutStanding {
    if (activeOutStandingStatusFilter.value.toLowerCase() == "pending") {
      return accountAllOutStandingList
          .where((e) => (e.accountLeadStatus ?? '').toLowerCase() == "pending")
          .toList();
    }
    if (activeOutStandingStatusFilter.value.toLowerCase() == "completed") {
      return accountAllOutStandingList
          .where((e) => (e.accountLeadStatus ?? '').toLowerCase() == "completed")
          .toList();
    }
    if (activeOutStandingStatusFilter.value.toLowerCase() == "missed") {
      return accountAllOutStandingList
          .where((e) => (e.accountLeadStatus ?? '').toLowerCase() == "missed")
          .toList();
    }
    return accountAllOutStandingList.toList();
  }

  List<VrmLead> get filteredAccountCollect {
    if (activeCollectStatusFilter.value.toLowerCase() == "pending") {
      return accountAllCollectList
          .where((e) => (e.accountLeadStatus ?? '').toLowerCase() == "pending")
          .toList();
    }
    if (activeCollectStatusFilter.value.toLowerCase() == "completed") {
      return accountAllCollectList
          .where((e) => (e.accountLeadStatus ?? '').toLowerCase() == "completed")
          .toList();
    }
    if (activeCollectStatusFilter.value.toLowerCase() == "missed") {
      return accountAllCollectList
          .where((e) => (e.accountLeadStatus ?? '').toLowerCase() == "missed")
          .toList();
    }
    return accountAllCollectList.toList();
  }

  void setAccountFilter(String f) {
    activeAccountFilter.value = f;
    filterAccountLead();
  }

  String getAccountFilterStatusName() {
    if (activeAccountFilter.value == "Bill") {
      return "bill";
    }
    if (activeAccountFilter.value == "Out Standing") {
      return "outstanding";
    }
    if (activeAccountFilter.value == "Collect") {
      return "collect";
    }
    return "bill";
  }

  void setAccountStatusBillsFilter(String f) {
    activeBillsStatusFilter.value = f;
  }

  void setAccountStatusOutStandingFilter(String f) {
    activeOutStandingStatusFilter.value = f;
  }

  void setAccountStatusCollectFilter(String f) {
    activeCollectStatusFilter.value = f;
  }

  void filterAccountLead() {
    final DateTime today = DateTime.now();
    final String todayStr =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    final List<VrmLead> all = accountLeads.toList();

    final List<VrmLead> todaysLeads = all.where((e) {
      if (e.createdAt == null) return false;
      try {
        final DateTime d = DateTime.parse(e.createdAt!);
        final String dateStr2 =
            "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
        return dateStr2 == todayStr;
      } catch (e) {
        return false;
      }
    }).toList();

    if (getAccountFilterStatusName() == "bill") {
      accountAllBillList
        ..clear()
        ..addAll(all.where((e) => (e.accountLeadsStage ?? '').toLowerCase() == "bill"));

      accountTodaysTotal.value = todaysLeads
          .where((e) => (e.accountLeadsStage ?? '').toLowerCase() == "bill")
          .length;
    } else if (getAccountFilterStatusName() == "outstanding") {
      accountAllOutStandingList
        ..clear()
        ..addAll(all.where((e) => (e.accountLeadsStage ?? '').toLowerCase() == "outstanding"));

      accountTodaysTotal.value = todaysLeads
          .where((e) => (e.accountLeadsStage ?? '').toLowerCase() == "outstanding")
          .length;
    } else if (getAccountFilterStatusName() == "collect") {
      accountAllCollectList
        ..clear()
        ..addAll(all.where((e) => (e.accountLeadsStage ?? '').toLowerCase() == "collect"));

      accountTodaysTotal.value = todaysLeads
          .where((e) => (e.accountLeadsStage ?? '').toLowerCase() == "collect")
          .length;
    }
  }

  Future<void> fetchAccountLeads({bool? isLoad}) async {
    await fetchAllLeads(isLoad: isLoad);
  }
}
