import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/model/accounts_model.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/services/AccountsService.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/widget/account_bills_screen.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/widget/account_collect_sreen.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/widget/account_outstanding_screen.dart';

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
  RxString activeBillsStatusFilter = 'All'.obs;
  RxString activeOutStandingStatusFilter = 'All'.obs;
  RxString activeCollectStatusFilter = 'Sent'.obs;
  RxString selectedPriority = "High".obs;

  final items = ['Bill', 'Out Standing', 'Collect'];
  final filterScreens = {
    'Bill': const AccountBillsScreen(),
    'Out Standing': const AccountOutstandingScreen(),
    'Collect': const AccountCollectScreen(),
  };

  RxInt todaysTotal = 0.obs;

  final List<String> billStatus = <String>["All", "Tax Bill", "Non Tax Bill"];

  List<AccountLeads> get filteredbills {
    if (activeBillsStatusFilter.value.toLowerCase() == "Tax Bill") {
      return allbillsList.where((e) => e.isAutoCreated == true).toList();
    }
    if (activeBillsStatusFilter.value.toLowerCase() == "Non Tax Bill") {
      return allbillsList.where((e) => e.isAutoCreated == false).toList();
    }
    return allbillsList;
  }

  List<AccountLeads> get filteredOutStanding {
    print(activeOutStandingStatusFilter.value.toLowerCase());
    if (activeOutStandingStatusFilter.value.toLowerCase() == "pending") {
      return allFollowUpList.where((e) => e.status == "pending").toList();
    }
    if (activeOutStandingStatusFilter.value.toLowerCase() == "completed") {
      return allFollowUpList.where((e) => e.status == "sent").toList();
    }
    if (activeOutStandingStatusFilter.value.toLowerCase() == "missed") {
      return allFollowUpList.where((e) => e.status == "missed").toList();
    }
    return allFollowUpList;
  }

  List<AccountLeads> get filteredProspect {
    return allProspectList.where((e) => e.status == "All").toList();
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
    activeOutStandingStatusFilter.value = f;
  }

  void setStatusLeadFilter(String f) {
    activeBillsStatusFilter.value = f;
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
