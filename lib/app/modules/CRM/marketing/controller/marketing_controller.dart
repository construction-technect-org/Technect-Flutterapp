import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/model/lead_model.dart';
import 'package:construction_technect/app/modules/CRM/marketing/services/MarketingService.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/followup_screen.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/lead_screen.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/prospect_screen.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/qualified_screen.dart';

class MarketingController extends GetxController {
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((val) {
      fetchAllLead(isLoad: true);
    });
    super.onInit();
  }

  final isLoading = false.obs;

  final chatNotificationCount = 2.obs;
  final alertNotificationCount = 2.obs;
  final bellNotificationCount = 2.obs;

  RxString activeFilter = 'Lead'.obs;
  RxString activeLeadStatusFilter = 'All'.obs;
  RxString activeFollowUpStatusFilter = 'Pending'.obs;
  RxString activeProspectStatusFilter = 'Fresh'.obs;
  RxString activeQualifiedStatusFilter = 'Qualified'.obs;
  RxString selectedPriority = "High".obs;

  final items = ['Lead', 'Follow Up', 'Prospect', 'Qualified'];
  final filterScreens = {
    'Lead': const LeadScreen(),
    'Follow Up': const FollowupScreen(),
    'Prospect': const ProspectScreen(),
    'Qualified': const QualifiedScreen(),
  };

  RxInt todaysTotal = 0.obs;

  final List<String> statusItems = <String>["Pending", "Completed", "Missed"];

  List<Leads> get filteredFollowups {
    if (activeFollowUpStatusFilter.value.toLowerCase() == "pending") {
      return allFollowUpList.where((e) => e.status == "pending").toList();
    }
    if (activeFollowUpStatusFilter.value.toLowerCase() == "completed") {
      return allFollowUpList.where((e) => e.status == "fresh").toList();
    }
    if (activeFollowUpStatusFilter.value.toLowerCase() == "missed") {
      return allFollowUpList.where((e) => e.status == "missed").toList();
    }
    return allFollowUpList;
  }

  final List<String> statusProspectItems = <String>["Fresh", "Reached Out", "Converted", "On Hold"];

  List<Leads> get filteredProspect {
    if (activeProspectStatusFilter.value.toLowerCase() == "fresh") {
      return allProspectList.where((e) => e.status == "fresh").toList();
    }
    if (activeProspectStatusFilter.value.toLowerCase() == "reached out") {
      return allProspectList.where((e) => e.status == "reached_out").toList();
    }
    if (activeProspectStatusFilter.value.toLowerCase() == "converted") {
      return allProspectList.where((e) => e.leadStage == "qualified").toList();
    }
    if (activeProspectStatusFilter.value.toLowerCase() == "on hold") {
      return allProspectList.where((e) => e.status == "on_hold").toList();
    }
    return allProspectList;
  }

  final List<String> qualifiedStatus = <String>["Qualified", "Lost"];

  List<Leads> get filteredQualified {
    if (activeFollowUpStatusFilter.value.toLowerCase() == "qualified") {
      return allQualifiedList.where((e) => e.status == "qualified").toList();
    }
    if (activeFollowUpStatusFilter.value.toLowerCase() == "lost") {
      return allQualifiedList.where((e) => e.status == "lost").toList();
    }
    return allQualifiedList;
  }

  final List<String> leadStatus = <String>["All", "Inbound", "Outbound"];

  List<Leads> get filteredLead {
    if (activeLeadStatusFilter.value.toLowerCase() == "inbound") {
      return allLeadList.where((e) => e.isAutoCreated == true).toList();
    }
    if (activeLeadStatusFilter.value.toLowerCase() == "outbound") {
      return allLeadList.where((e) => e.isAutoCreated == false).toList();
    }
    return allLeadList;
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

    final List<Leads> all = allLeadModel.value.data?.leads ?? [];

    final List<Leads> todaysLeads = all.where((e) {
      if (e.createdAt == null) return false;

      final DateTime d = DateTime.parse(e.createdAt!);
      final String dateStr =
          "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
      return dateStr == todayStr;
    }).toList();

    if (getFilterStatusName() == "lead") {
      allLeadList
        ..clear()
        ..addAll(todaysLeads.where((e) => e.leadStage == "lead"));

      todaysTotal.value = allLeadList.length;
    } else if (getFilterStatusName() == "follow_up") {
      allFollowUpList
        ..clear()
        ..addAll(todaysLeads.where((e) => e.leadStage == "follow_up" || e.leadStage == "prospect"));

      todaysTotal.value = allFollowUpList.length;
    } else if (getFilterStatusName() == "prospect") {
      allProspectList
        ..clear()
        ..addAll(todaysLeads.where((e) => e.leadStage == "prospect" || e.leadStage == "qualified"));

      todaysTotal.value = allProspectList.length;
    } else if (getFilterStatusName() == "qualified") {
      allQualifiedList
        ..clear()
        ..addAll(todaysLeads.where((e) => e.leadStage == "qualified"));

      todaysTotal.value = allQualifiedList.length;
    }
  }

  Rx<AllLeadModel> allLeadModel = AllLeadModel().obs;
  RxList<Leads> allLeadList = <Leads>[].obs;
  RxList<Leads> allFollowUpList = <Leads>[].obs;
  RxList<Leads> allProspectList = <Leads>[].obs;
  RxList<Leads> allQualifiedList = <Leads>[].obs;

  Future<void> fetchAllLead({bool? isLoad}) async {
    try {
      isLoading.value = isLoad ?? false;
      allLeadModel.value = await MarketingServices().getAllLead();
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
    required String leadID,
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
      final response = await MarketingServices().updateLeadStatus(
        remindAt: remindAt,
        leadID: leadID,
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
