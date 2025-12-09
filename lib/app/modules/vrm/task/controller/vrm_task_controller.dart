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
  RxString activeFilter = 'Request'.obs;
  RxString activeLeadStatusFilter = 'All'.obs;
  RxString activeFollowUpStatusFilter = 'Pending'.obs;
  RxString activeProspectStatusFilter = 'Fresh'.obs;
  RxString activeQualifiedStatusFilter = 'Pending'.obs;
  RxString selectedPriority = "High".obs;

  final items = ['Request', 'Follow Up', 'Prospect', 'Qualified'];
  final leadStatus = <String>["All", "Inbound", "Outbound"];
  final List<String> statusItems = <String>["Pending", "Completed", "Missed"];
  final List<String> statusProspectItems = <String>["Fresh", "Reached Out", "Converted", "On Hold"];
  final List<String> qualifiedStatus = <String>["Pending", "Qualified", "Lost"];

  RxInt todaysTotal = 0.obs;
  RxInt salesTodaysTotal = 0.obs;
  RxInt accountTodaysTotal = 0.obs;

  // Total counts for all Enquiry, Purchase, and Account leads
  RxInt totalEnquiry = 0.obs;
  RxInt totalPurchase = 0.obs;
  RxInt totalAccount = 0.obs;

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
  RxString activeSalesFilter = 'Requirement'.obs;
  RxString activeSalesLeadStatusFilter = 'All'.obs;
  RxString activeSalesFollowUpStatusFilter = 'Pending'.obs;
  RxString activeSalesProspectStatusFilter = 'Sent'.obs;
  RxString activeSalesQualifiedStatusFilter = 'Pending'.obs;

  final salesItems = ['Requirement', 'Follow Up', 'Quote', 'Closed'];
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
      case 'Request':
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
      case 'Requirement':
        return const VrmSaleLeadScreen();
      case 'Follow Up':
        return const VrmSaleFollowupScreen();
      case 'Quote':
        return const VrmSaleProspectScreen();
      case 'Closed':
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
      return allFollowUpList
          .where((e) => (e.currentStatus ?? '').toLowerCase() == "pending")
          .toList();
    }
    if (activeFollowUpStatusFilter.value.toLowerCase() == "completed") {
      return allFollowUpList
          .where((e) => (e.currentStatus ?? '').toLowerCase() == "fresh")
          .toList();
    }
    if (activeFollowUpStatusFilter.value.toLowerCase() == "missed") {
      return allFollowUpList
          .where((e) => (e.currentStatus ?? '').toLowerCase() == "missed")
          .toList();
    }
    return allFollowUpList.toList();
  }

  List<VrmLead> get filteredProspect {
    final status = activeProspectStatusFilter.value.toLowerCase();
    if (status == "fresh") {
      return allProspectList.where((e) {
        final stat = (e.currentStatus ?? '').toLowerCase();
        return stat == "fresh";
      }).toList();
    }
    if (status == "reached out") {
      return allProspectList.where((e) {
        final stat = (e.currentStatus ?? '').toLowerCase();
        return stat == "reached_out";
      }).toList();
    }
    if (status == "converted") {
      return allProspectList.where((e) {
        final stage = (e.currentStage ?? '').toLowerCase();
        final stat = (e.currentStatus ?? '').toLowerCase();
        return stage == "qualified" && stat == "pending";
      }).toList();
    }
    if (status == "on hold") {
      return allProspectList.where((e) {
        final stat = (e.currentStatus ?? '').toLowerCase();
        return stat == "on_hold";
      }).toList();
    }
    return allProspectList.toList();
  }

  List<VrmLead> get filteredQualified {
    final status = activeQualifiedStatusFilter.value.toLowerCase();
    if (status == "pending") {
      return allQualifiedList.where((e) {
        final stage = (e.currentStage ?? '').toLowerCase();
        final stat = (e.currentStatus ?? '').toLowerCase();
        return stage == "qualified" && stat == "pending";
      }).toList();
    }
    if (status == "qualified") {
      return allQualifiedList.where((e) {
        final mainStage = (e.mainStage ?? '').toLowerCase();
        final currentStage = (e.currentStage ?? '').toLowerCase();
        final currentStatus = (e.currentStatus ?? '').toLowerCase();
        // Include qualified status OR Purchase leads with sales/new
        return currentStatus == "qualified" ||
            (mainStage == "purchase" && currentStage == "sales" && currentStatus == "new");
      }).toList();
    }
    if (status == "lost") {
      return allQualifiedList
          .where((e) => (e.currentStatus ?? '').toLowerCase() == "lost")
          .toList();
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
          final currentStage = (e.currentStage ?? '').toLowerCase();
          final currentStatus = (e.currentStatus ?? '').toLowerCase();
          final hasSalesData =
              e.salesLeadId != null || e.salesId != null || mainStage == 'Purchase';
          final hasAccountData =
              e.accountLeadId != null ||
              e.accountId != null ||
              (mainStage == 'Account' && (e.currentStage != null || e.currentStatus != null));
          // Include if main_stage is Enquiry, or has lead_stage/status but no sales/account data
          // Also include Purchase leads with current_stage: "sales" and current_status: "new" in Enquiry
          return mainStage == 'Enquiry' ||
              (mainStage == 'Purchase' && currentStage == 'sales' && currentStatus == 'new') ||
              (mainStage != 'Purchase' &&
                  mainStage != 'Account' &&
                  !hasSalesData &&
                  !hasAccountData);
        }).toList(),
      );
      salesLeads.assignAll(
        list.where((e) {
          final mainStage = e.mainStage ?? '';
          final currentStage = (e.currentStage ?? '').toLowerCase();
          final currentStatus = (e.currentStatus ?? '').toLowerCase();
          final hasSalesData =
              e.salesLeadId != null || e.salesId != null || mainStage == 'Purchase';
          // Include if main_stage is Purchase OR has sales data
          // Also include Account leads with bill/pending for Closed > Won
          return mainStage == 'Purchase' ||
              hasSalesData ||
              (mainStage == 'Account' && currentStage == 'bill' && currentStatus == 'pending');
        }).toList(),
      );
      accountLeads.assignAll(
        list.where((e) {
          final mainStage = e.mainStage ?? '';
          final hasAccountData =
              e.accountLeadId != null ||
              e.accountId != null ||
              (mainStage == 'Account' && (e.currentStage != null || e.currentStatus != null));
          // Include if main_stage is Account OR has account data
          return mainStage == 'Account' || hasAccountData;
        }).toList(),
      );

      // Calculate total counts for Enquiry, Purchase, and Account
      totalEnquiry.value = leads.length;
      totalPurchase.value = salesLeads.length;
      totalAccount.value = accountLeads.length;

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
    // Ensure Enquiry tab always starts on Request view
    if (index == 0) {
      activeFilter.value = 'Request';
    }
    // Ensure Purchase tab always starts on Requirement view
    if (index == 1) {
      activeSalesFilter.value = 'Requirement';
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
    if (activeFilter.value == "Request") {
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
    final List<VrmLead> all = leads.toList();

    if (getFilterStatusName() == "lead") {
      allLeadList
        ..clear()
        ..addAll(
          all.where((e) {
            // For Enquiry, use current_stage and current_status (same as CRM lead_stage and status)
            final stage = (e.currentStage ?? '').toLowerCase();
            return stage == "lead";
          }),
        );

      // Count all leads matching the current status filter
      todaysTotal.value = allLeadList.where((e) {
        final filterStatus = activeLeadStatusFilter.value.toLowerCase();
        if (filterStatus == "inbound") return e.isAutoCreated == true;
        if (filterStatus == "outbound") return e.isAutoCreated == false;
        return true;
      }).length;
    } else if (getFilterStatusName() == "follow_up") {
      allFollowUpList
        ..clear()
        ..addAll(
          all.where((e) {
            // For Enquiry, use current_stage and current_status
            final stage = (e.currentStage ?? '').toLowerCase();
            final stat = (e.currentStatus ?? '').toLowerCase();
            return stage == "follow_up" || (stage == "prospect" && stat == "fresh");
          }),
        );

      // Count all leads matching the current status filter
      todaysTotal.value = allFollowUpList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        final filterStatus = activeFollowUpStatusFilter.value.toLowerCase();
        if (filterStatus == "pending") return status == "pending";
        if (filterStatus == "completed") return status == "completed";
        if (filterStatus == "missed") return status == "missed";
        return true;
      }).length;
    } else if (getFilterStatusName() == "prospect") {
      allProspectList
        ..clear()
        ..addAll(
          all.where((e) {
            // For Enquiry, use current_stage and current_status
            final stage = (e.currentStage ?? '').toLowerCase();
            final stat = (e.currentStatus ?? '').toLowerCase();
            return stage == "prospect" || (stat == "pending" && stage == "qualified");
          }),
        );

      // Count all leads matching the current status filter
      todaysTotal.value = allProspectList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        final filterStatus = activeProspectStatusFilter.value.toLowerCase();
        if (filterStatus == "fresh") return status == "fresh";
        if (filterStatus == "reached out") return status == "reached_out";
        if (filterStatus == "converted") return status == "converted";
        if (filterStatus == "on hold") return status == "on_hold";
        return true;
      }).length;
    } else if (getFilterStatusName() == "qualified") {
      allQualifiedList
        ..clear()
        ..addAll(
          all.where((e) {
            // For Enquiry, use current_stage and current_status
            final stage = (e.currentStage ?? '').toLowerCase();
            final mainStage = (e.mainStage ?? '').toLowerCase();
            // Include qualified stage OR Purchase leads with sales stage and new status
            return stage == "qualified" ||
                (mainStage == "purchase" &&
                    stage == "sales" &&
                    (e.currentStatus ?? '').toLowerCase() == "new");
          }),
        );

      // Count all leads matching the current status filter
      todaysTotal.value = allQualifiedList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        final filterStatus = activeQualifiedStatusFilter.value.toLowerCase();
        final mainStage = (e.mainStage ?? '').toLowerCase();
        final stage = (e.currentStage ?? '').toLowerCase();
        // For Purchase leads with sales/new, treat as "qualified" status
        if (mainStage == "purchase" && stage == "sales" && status == "new") {
          return filterStatus == "qualified";
        }
        if (filterStatus == "pending") return status == "pending";
        if (filterStatus == "qualified") return status == "qualified";
        if (filterStatus == "lost") return status == "lost";
        return true;
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
      return salesAllFollowUpList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        return status == "pending";
      }).toList();
    }
    if (activeSalesFollowUpStatusFilter.value.toLowerCase() == "completed") {
      return salesAllFollowUpList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        final stage = (e.currentStage ?? '').toLowerCase();
        // Include completed status OR quote_sent stage with sent status
        return status == "completed" || (stage == "quote_sent" && status == "sent");
      }).toList();
    }
    if (activeSalesFollowUpStatusFilter.value.toLowerCase() == "missed") {
      return salesAllFollowUpList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        return status == "missed";
      }).toList();
    }
    return salesAllFollowUpList.toList();
  }

  List<VrmLead> get filteredSalesProspect {
    final status = activeSalesProspectStatusFilter.value.toLowerCase();
    if (status == "sent") {
      return salesAllProspectList.where((e) {
        final stat = (e.currentStatus ?? '').toLowerCase();
        return stat == "sent";
      }).toList();
    }
    if (status == "accepted") {
      return salesAllProspectList.where((e) {
        final stage = (e.currentStage ?? '').toLowerCase();
        final stat = (e.currentStatus ?? '').toLowerCase();
        // Include closing stage with won status OR closing stage with pending status
        return (stage == "closing" && stat == "won") || (stage == "closing" && stat == "pending");
      }).toList();
    }
    if (status == "negotiation") {
      return salesAllProspectList.where((e) {
        final stat = (e.currentStatus ?? '').toLowerCase();
        return stat == "negotiation";
      }).toList();
    }
    return salesAllProspectList.toList();
  }

  List<VrmLead> get filteredSalesQualified {
    final status = activeSalesQualifiedStatusFilter.value.toLowerCase();
    if (status == "pending") {
      return salesAllQualifiedList.where((e) {
        final stat = (e.currentStatus ?? '').toLowerCase();
        return stat == "pending";
      }).toList();
    }
    if (status == "won") {
      return salesAllQualifiedList.where((e) {
        final stat = (e.currentStatus ?? '').toLowerCase();
        final stage = (e.currentStage ?? '').toLowerCase();
        final mainStage = (e.mainStage ?? '').toLowerCase();
        // Include won status OR Account leads with bill/pending
        return stat == "won" || (mainStage == "account" && stage == "bill" && stat == "pending");
      }).toList();
    }
    if (status == "lost") {
      return salesAllQualifiedList.where((e) {
        final stat = (e.currentStatus ?? '').toLowerCase();
        return stat == "lost";
      }).toList();
    }
    return salesAllQualifiedList.toList();
  }

  void setSalesFilter(String f) {
    activeSalesFilter.value = f;
    filterSalesLead();
  }

  String getSalesFilterStatusName() {
    if (activeSalesFilter.value == "Requirement") {
      return "sales";
    }
    if (activeSalesFilter.value == "Follow Up") {
      return "follow_up";
    }
    if (activeSalesFilter.value == "Quote") {
      return "quote_sent";
    }
    if (activeSalesFilter.value == "Closed") {
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
    final List<VrmLead> all = salesLeads.toList();

    if (getSalesFilterStatusName() == "sales") {
      salesAllLeadList
        ..clear()
        ..addAll(
          all.where((e) {
            final status = (e.currentStatus ?? '').toLowerCase();
            final stage = (e.currentStage ?? '').toLowerCase();
            return status == "new" || stage == "sales";
          }),
        );

      // Count all leads matching the current status filter
      salesTodaysTotal.value = salesAllLeadList.where((e) {
        final filterStatus = activeSalesLeadStatusFilter.value.toLowerCase();
        if (filterStatus == "inbound") return e.isAutoCreated == true;
        if (filterStatus == "outbound") return e.isAutoCreated == false;
        return true;
      }).length;
    } else if (getSalesFilterStatusName() == "follow_up") {
      salesAllFollowUpList
        ..clear()
        ..addAll(
          all.where((e) {
            final stage = (e.currentStage ?? '').toLowerCase();
            final stat = (e.currentStatus ?? '').toLowerCase();
            return stage == "follow_up" || (stage == "quote_sent" && stat == "sent");
          }),
        );

      // Count all leads matching the current status filter
      salesTodaysTotal.value = salesAllFollowUpList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        final stage = (e.currentStage ?? '').toLowerCase();
        final filterStatus = activeSalesFollowUpStatusFilter.value.toLowerCase();
        if (filterStatus == "pending") return status == "pending";
        if (filterStatus == "completed") {
          // Include completed status OR quote_sent stage with sent status
          return status == "completed" || (stage == "quote_sent" && status == "sent");
        }
        if (filterStatus == "missed") return status == "missed";
        return true;
      }).length;
    } else if (getSalesFilterStatusName() == "quote_sent") {
      salesAllProspectList
        ..clear()
        ..addAll(
          all.where((e) {
            final stage = (e.currentStage ?? '').toLowerCase();
            final stat = (e.currentStatus ?? '').toLowerCase();
            return stage == "quote_sent" || (stat == "pending" && stage == "closing");
          }),
        );

      // Count all leads matching the current status filter
      salesTodaysTotal.value = salesAllProspectList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        final stage = (e.currentStage ?? '').toLowerCase();
        final filterStatus = activeSalesProspectStatusFilter.value.toLowerCase();
        if (filterStatus == "sent") return status == "sent";
        if (filterStatus == "accepted") {
          // Include closing stage with won status OR closing stage with pending status
          return (stage == "closing" && status == "won") ||
              (stage == "closing" && status == "pending");
        }
        if (filterStatus == "negotiation") return status == "negotiation";
        return true;
      }).length;
    } else if (getSalesFilterStatusName() == "closing") {
      salesAllQualifiedList
        ..clear()
        ..addAll(
          all.where((e) {
            final stage = (e.currentStage ?? '').toLowerCase();
            final mainStage = (e.mainStage ?? '').toLowerCase();
            final status = (e.currentStatus ?? '').toLowerCase();
            // Include closing stage OR Account leads with bill/pending
            return stage == "closing" ||
                (mainStage == "account" && stage == "bill" && status == "pending");
          }),
        );

      // Count all leads matching the current status filter
      salesTodaysTotal.value = salesAllQualifiedList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        final stage = (e.currentStage ?? '').toLowerCase();
        final mainStage = (e.mainStage ?? '').toLowerCase();
        final filterStatus = activeSalesQualifiedStatusFilter.value.toLowerCase();
        if (filterStatus == "pending") return status == "pending";
        if (filterStatus == "won") {
          // Include won status OR Account leads with bill/pending
          return status == "won" ||
              (mainStage == "account" && stage == "bill" && status == "pending");
        }
        if (filterStatus == "lost") return status == "lost";
        return true;
      }).length;
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
      return accountAllBillList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        return status == "pending";
      }).toList();
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
      return accountAllOutStandingList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        return status == "pending";
      }).toList();
    }
    if (activeOutStandingStatusFilter.value.toLowerCase() == "completed") {
      return accountAllOutStandingList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        return status == "completed";
      }).toList();
    }
    if (activeOutStandingStatusFilter.value.toLowerCase() == "missed") {
      return accountAllOutStandingList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        return status == "missed";
      }).toList();
    }
    return accountAllOutStandingList.toList();
  }

  List<VrmLead> get filteredAccountCollect {
    if (activeCollectStatusFilter.value.toLowerCase() == "pending") {
      return accountAllCollectList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        return status == "pending";
      }).toList();
    }
    if (activeCollectStatusFilter.value.toLowerCase() == "completed") {
      return accountAllCollectList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        return status == "completed";
      }).toList();
    }
    if (activeCollectStatusFilter.value.toLowerCase() == "missed") {
      return accountAllCollectList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        return status == "missed";
      }).toList();
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
    final List<VrmLead> all = accountLeads.toList();

    if (getAccountFilterStatusName() == "bill") {
      accountAllBillList
        ..clear()
        ..addAll(
          all.where((e) {
            final stage = (e.currentStage ?? '').toLowerCase();
            return stage == "bill";
          }),
        );

      // Count all leads matching the current status filter
      accountTodaysTotal.value = accountAllBillList.where((e) {
        if (activeBillsStatusFilter.value.toLowerCase() == "pending") {
          final status = (e.currentStatus ?? '').toLowerCase();
          return status == "pending";
        }
        if (activeBillsStatusFilter.value.toLowerCase() == "tax bill") {
          return e.isAutoCreated == true;
        }
        if (activeBillsStatusFilter.value.toLowerCase() == "non tax bill") {
          return e.isAutoCreated == false;
        }
        return true;
      }).length;
    } else if (getAccountFilterStatusName() == "outstanding") {
      accountAllOutStandingList
        ..clear()
        ..addAll(
          all.where((e) {
            final stage = (e.currentStage ?? '').toLowerCase();
            return stage == "outstanding";
          }),
        );

      // Count all leads matching the current status filter
      accountTodaysTotal.value = accountAllOutStandingList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        final filterStatus = activeOutStandingStatusFilter.value.toLowerCase();
        if (filterStatus == "pending") return status == "pending";
        if (filterStatus == "completed") return status == "completed";
        if (filterStatus == "missed") return status == "missed";
        return true;
      }).length;
    } else if (getAccountFilterStatusName() == "collect") {
      accountAllCollectList
        ..clear()
        ..addAll(
          all.where((e) {
            final stage = (e.currentStage ?? '').toLowerCase();
            return stage == "collect";
          }),
        );

      // Count all leads matching the current status filter
      accountTodaysTotal.value = accountAllCollectList.where((e) {
        final status = (e.currentStatus ?? '').toLowerCase();
        final filterStatus = activeCollectStatusFilter.value.toLowerCase();
        if (filterStatus == "pending") return status == "pending";
        if (filterStatus == "completed") return status == "completed";
        if (filterStatus == "missed") return status == "missed";
        return true;
      }).length;
    }
  }

  Future<void> fetchAccountLeads({bool? isLoad}) async {
    await fetchAllLeads(isLoad: isLoad);
  }
}
