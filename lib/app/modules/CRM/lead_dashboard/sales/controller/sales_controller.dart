import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/sales/model/sales_model.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/sales/services/SalesService.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/sales/widget/sale_prospect_screen.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/sales/widget/sale_qualified_screen.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/sales/widget/sale_followup_screen.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/sales/widget/sale_lead_screen.dart';

class SalesController extends GetxController {
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((val) {
      fetchAllLead(isLoad: true);
    });
    super.onInit();
  }

  final isLoading = false.obs;
  RxString activeFilter = 'Lead'.obs;
  RxString activeLeadStatusFilter = 'All'.obs;
  RxString activeFollowUpStatusFilter = 'Pending'.obs;
  RxString activeProspectStatusFilter = 'Sent'.obs;
  RxString activeQualifiedStatusFilter = 'Pending'.obs;
  RxString selectedPriority = "High".obs;

  final items = ['Lead', 'Follow Up', 'Quote Sent', 'Closing'];
  final filterScreens = {
    'Lead': const SaleLeadScreen(),
    'Follow Up': const SaleFollowupScreen(),
    'Quote Sent': const SaleProspectScreen(),
    'Closing': const SaleQualifiedScreen(),
  };

  RxInt todaysTotal = 0.obs;

  final List<String> leadStatus = <String>["All", "Inbound", "Outbound"];

  List<SaleLeads> get filteredLead {
    if (activeLeadStatusFilter.value.toLowerCase() == "inbound") {
      return allLeadList.where((e) => e.isAutoCreated == true).toList();
    }
    if (activeLeadStatusFilter.value.toLowerCase() == "outbound") {
      return allLeadList.where((e) => e.isAutoCreated == false).toList();
    }
    return allLeadList;
  }

  final List<String> statusItems = <String>["Pending", "Completed", "Missed"];

  List<SaleLeads> get filteredFollowups {
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

  List<SaleLeads> get filteredProspect {
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

  List<SaleLeads> get filteredQualified {
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
    if (activeFilter.value == "Lead") {
      return "lead";
    }
    if (activeFilter.value == "Follow Up") {
      return "follow_up";
    }
    if (activeFilter.value == "Quote Sent") {
      return "quote_sent";
    }
    if (activeFilter.value == "Closing") {
      return "closing";
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

    final List<SaleLeads> all = allLeadModel.value.data?.leads ?? [];

    final List<SaleLeads> todaysLeads = all.where((e) {
      if (e.createdAt == null) return false;

      final DateTime d = DateTime.parse(e.createdAt!);
      final String dateStr =
          "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
      return dateStr == todayStr;
    }).toList();

    if (getFilterStatusName() == "lead") {
      allLeadList
        ..clear()
        ..addAll(all.where((e) => e.salesLeadsStage == "sales"));

      todaysTotal.value = todaysLeads.where((e) => e.salesLeadsStage == "sales").length;
    } else if (getFilterStatusName() == "follow_up") {
      allFollowUpList
        ..clear()
        ..addAll(
          all.where(
            (e) =>
                e.salesLeadsStage == "follow_up" ||
                (e.salesLeadsStage == "quote_sent" && e.status == "sent"),
          ),
        );

      todaysTotal.value = todaysLeads
          .where(
            (e) =>
                e.salesLeadsStage == "follow_up" ||
                (e.salesLeadsStage == "quote_sent" && e.status == "sent"),
          )
          .length;
    } else if (getFilterStatusName() == "quote_sent") {
      allProspectList
        ..clear()
        ..addAll(
          all.where(
            (e) =>
                e.salesLeadsStage == "quote_sent" ||
                (e.status == "pending" && e.salesLeadsStage == "closing"),
          ),
        );

      todaysTotal.value = todaysLeads
          .where(
            (e) =>
                e.salesLeadsStage == "quote_sent" ||
                (e.status == "pending" && e.salesLeadsStage == "closing"),
          )
          .length;
    } else if (getFilterStatusName() == "closing") {
      allQualifiedList
        ..clear()
        ..addAll(all.where((e) => e.salesLeadsStage == "closing"));

      todaysTotal.value = todaysLeads.where((e) => e.salesLeadsStage == "closing").length;
    }
  }

  Rx<AllSalesModel> allLeadModel = AllSalesModel().obs;
  RxList<SaleLeads> allLeadList = <SaleLeads>[].obs;
  RxList<SaleLeads> allFollowUpList = <SaleLeads>[].obs;
  RxList<SaleLeads> allProspectList = <SaleLeads>[].obs;
  RxList<SaleLeads> allQualifiedList = <SaleLeads>[].obs;

  Future<void> fetchAllLead({bool? isLoad}) async {
    try {
      isLoading.value = isLoad ?? false;
      allLeadModel.value = await SalesServices().getAllLead();
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
      final response = await SalesServices().updateSaleLeadStatus(
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
