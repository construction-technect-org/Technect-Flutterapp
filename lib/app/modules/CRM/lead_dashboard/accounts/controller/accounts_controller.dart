import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/model/accounts_model.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/services/AccountsService.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/widget/account_followup_screen.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/widget/account_lead_screen.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/widget/account_prospect_screen.dart';

class AccountsController extends GetxController {
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((val) {
      fetchAllLead(isLoad: true);
    });
    super.onInit();
  }

  final isLoading = false.obs;
  RxString activeFilter = 'Bill'.obs;
  RxString activeLeadStatusFilter = 'All'.obs;
  RxString activeFollowUpStatusFilter = 'Pending'.obs;
  RxString activeProspectStatusFilter = 'Sent'.obs;
  RxString activeQualifiedStatusFilter = 'Pending'.obs;
  RxString selectedPriority = "High".obs;

  final items = ['Bill', 'Out Standing', 'Collect'];
  final filterScreens = {
    'Bill': const AccountLeadScreen(),
    'Out Standing': const AccountFollowupScreen(),
    'Collect': const AccountProspectScreen(),
  };

  RxInt todaysTotal = 0.obs;

  final List<String> leadStatus = <String>["All", "Tax Bill", "Non Tax Bill"];

  List<AccountLeads> get filteredbills {
    if (activeLeadStatusFilter.value.toLowerCase() == "Tax Bill") {
      return allbillsList.where((e) => e.isAutoCreated == true).toList();
    }
    if (activeLeadStatusFilter.value.toLowerCase() == "Non Tax Bill") {
      return allbillsList.where((e) => e.isAutoCreated == false).toList();
    }
    return allbillsList;
  }

  final List<String> statusItems = <String>["Pending", "Completed", "Missed"];

  List<AccountLeads> get filteredFollowups {
    print(activeFollowUpStatusFilter.value.toLowerCase());
    if (activeFollowUpStatusFilter.value.toLowerCase() == "pending") {
      return allFollowUpList.where((e) => e.status == "pending").toList();
    }
    if (activeFollowUpStatusFilter.value.toLowerCase() == "completed") {
      return allFollowUpList.where((e) => e.status == "sent").toList();
    }
    if (activeFollowUpStatusFilter.value.toLowerCase() == "missed") {
      return allFollowUpList.where((e) => e.status == "missed").toList();
    }
    return allFollowUpList;
  }

  final List<String> statusProspectItems = <String>["Sent", "Accepted", "Negotiation"];

  List<AccountLeads> get filteredProspect {
    if (activeProspectStatusFilter.value.toLowerCase() == "sent") {
      return allProspectList.where((e) => e.status == "sent").toList();
    }
    if (activeProspectStatusFilter.value.toLowerCase() == "accepted") {
      return allProspectList
          .where((e) => e.salesLeadsStage == "closing" && e.status == "won")
          .toList();
    }
    if (activeProspectStatusFilter.value.toLowerCase() == "negotiation") {
      return allProspectList.where((e) => e.status == "negotiation").toList();
    }
    return allProspectList;
  }

  final List<String> qualifiedStatus = <String>["Pending", "Won", "Lost"];

  List<AccountLeads> get filteredQualified {
    if (activeQualifiedStatusFilter.value.toLowerCase() == "pending") {
      return allQualifiedList.where((e) => e.status == "pending").toList();
    }
    if (activeQualifiedStatusFilter.value.toLowerCase() == "won") {
      return allQualifiedList.where((e) => e.status == "won").toList();
    }
    if (activeQualifiedStatusFilter.value.toLowerCase() == "lost") {
      return allQualifiedList.where((e) => e.status == "lost").toList();
    }
    return allQualifiedList;
  }

  void setFilter(String f) {
    activeFilter.value = f;
    filterLead();
  }

  String getFilterStatusName() {
    if (activeFilter.value == "Bill") {
      return "lead";
    }
    if (activeFilter.value == "Out Standing") {
      return "follow_up";
    }
    if (activeFilter.value == "Collect") {
      return "quote_sent";
    }
    return "lead";
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

    final List<AccountLeads> all = allLeadModel.value.data?.leads ?? [];

    final List<AccountLeads> todaysLeads = all.where((e) {
      if (e.createdAt == null) return false;

      final DateTime d = DateTime.parse(e.createdAt!);
      final String dateStr =
          "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
      return dateStr == todayStr;
    }).toList();

    if (getFilterStatusName() == "lead") {
      allbillsList
        ..clear()
        ..addAll(todaysLeads.where((e) => e.salesLeadsStage == "sales"));

      todaysTotal.value = allbillsList.length;
    } else if (getFilterStatusName() == "follow_up") {
      allFollowUpList
        ..clear()
        ..addAll(
          todaysLeads.where(
            (e) =>
                e.salesLeadsStage == "follow_up" ||
                (e.salesLeadsStage == "quote_sent" && e.status == "sent"),
          ),
        );

      todaysTotal.value = allFollowUpList.length;
    } else if (getFilterStatusName() == "quote_sent") {
      allProspectList
        ..clear()
        ..addAll(
          todaysLeads.where(
            (e) =>
                e.salesLeadsStage == "quote_sent" ||
                (e.status == "pending" && e.salesLeadsStage == "closing"),
          ),
        );

      todaysTotal.value = allProspectList.length;
    } else if (getFilterStatusName() == "closing") {
      allQualifiedList
        ..clear()
        ..addAll(todaysLeads.where((e) => e.salesLeadsStage == "closing"));

      todaysTotal.value = allQualifiedList.length;
    }
  }

  Rx<AllAccountsModel> allLeadModel = AllAccountsModel().obs;
  RxList<AccountLeads> allbillsList = <AccountLeads>[].obs;
  RxList<AccountLeads> allFollowUpList = <AccountLeads>[].obs;
  RxList<AccountLeads> allProspectList = <AccountLeads>[].obs;
  RxList<AccountLeads> allQualifiedList = <AccountLeads>[].obs;

  Future<void> fetchAllLead({bool? isLoad}) async {
    try {
      isLoading.value = isLoad ?? false;
      allLeadModel.value = await AccountsServices().getAllLead();
      filterLead();
      isLoading.value = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateStatusLeadToFollowUp({
    required String saleLeadID,
    String? remindAt,
    String? assignTo,
    String? note,
    String? priority,
    String? status,
    String? lastConversation,
    String? nextConversation,
    bool? assignToMySelf = false,
    VoidCallback? onSuccess,
  }) async {
    try {
      isLoading.value = true;
      final response = await AccountsServices().updateAccountLeadStatus(
        remindAt: remindAt,
        saleLeadID: saleLeadID,
        assignTo: assignTo,
        assignToMySelf: assignToMySelf,
        note: note,
        priority: priority,
        status: status,
        lastConversation: lastConversation,
        nextConversation: nextConversation,
      );

      if (response.success == true) {
        if (onSuccess != null) onSuccess();
        await fetchAllLead(isLoad: true);
      } else {
        SnackBars.errorSnackBar(content: response.message ?? 'Failed to accept connection');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
