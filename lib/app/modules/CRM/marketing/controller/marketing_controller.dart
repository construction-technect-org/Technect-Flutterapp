import 'dart:developer';
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
    filterFollowupStatus();
    filterProspectStatus();
    super.onInit();
  }

  RxString selectedPriority = "High".obs;

  final isLoading = false.obs;

  final chatNotificationCount = 2.obs;
  final alertNotificationCount = 2.obs;
  final bellNotificationCount = 2.obs;

  RxString activeFilter = 'Lead'.obs;
  RxString activeStatusFilter = 'All'.obs;
  RxString activeProspectStatusFilter = 'Fresh'.obs;
  RxString category = 'Marketing'.obs;

  final items = ['Lead', 'Follow Up', 'Prospect', 'Qualified'];
  final filterScreens = {
    'Lead': const LeadScreen(),
    'Follow Up': const FollowupScreen(),
    'Prospect': const ProspectScreen(),
    'Qualified': const QualifiedScreen(),
  };

  int get todaysTotal => leads.length;

  RxList<LeadModel> leads = <LeadModel>[
    LeadModel(
      id: '#CTO1256',
      name: 'Anand',
      connector: 'Anand',
      product: 'M Sand',
      distanceKm: 2.8,
      status: Status.completed,
      dateTime: DateTime(2024, 11, 12, 10, 30),
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
    ),
    LeadModel(
      id: '#CTO1259',
      name: 'Shiva',
      connector: 'Shiva',
      product: 'M Sand',
      distanceKm: 2.8,
      status: Status.closed,
      dateTime: DateTime(2024, 11, 12, 10, 40),
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
    ),
    LeadModel(
      id: '#CTO1260',
      name: 'Rahul',
      connector: 'Mukesh',
      product: 'Cement',
      distanceKm: 5.4,
      status: Status.pending,
      dateTime: DateTime(2024, 11, 13, 11, 10),
      avatarUrl: 'https://i.pravatar.cc/150?img=8',
    ),
    LeadModel(
      id: '#CTO1261',
      name: 'Priya',
      connector: 'Anil',
      product: 'Bricks',
      distanceKm: 1.8,
      status: Status.completed,
      dateTime: DateTime(2024, 11, 13, 12, 5),
      avatarUrl: 'https://i.pravatar.cc/150?img=22',
    ),
    LeadModel(
      id: '#CTO1262',
      name: 'Vikas',
      connector: 'Kiran',
      product: 'Steel',
      distanceKm: 3.3,
      status: Status.pending,
      dateTime: DateTime(2024, 11, 14, 9, 20),
      avatarUrl: 'https://i.pravatar.cc/150?img=14',
    ),
    LeadModel(
      id: '#CTO1263',
      name: 'Meena',
      connector: 'Deepak',
      product: 'Concrete',
      distanceKm: 4.1,
      status: Status.missed,
      dateTime: DateTime(2024, 11, 14, 10, 45),
      avatarUrl: 'https://i.pravatar.cc/150?img=17',
    ),
    LeadModel(
      id: '#CTO1264',
      name: 'Karthik',
      connector: 'Suresh',
      product: 'M Sand',
      distanceKm: 2.0,
      status: Status.closed,
      dateTime: DateTime(2024, 11, 15, 13, 15),
      avatarUrl: 'https://i.pravatar.cc/150?img=28',
    ),
    LeadModel(
      id: '#CTO1265',
      name: 'Sangeeta',
      connector: 'Anand',
      product: 'Tiles',
      distanceKm: 6.2,
      status: Status.completed,
      dateTime: DateTime(2024, 11, 15, 16, 10),
      avatarUrl: 'https://i.pravatar.cc/150?img=32',
    ),
    LeadModel(
      id: '#CTO1266',
      name: 'Rohan',
      connector: 'Prakash',
      product: 'Blocks',
      distanceKm: 1.5,
      status: Status.pending,
      dateTime: DateTime(2024, 11, 16, 11, 45),
      avatarUrl: 'https://i.pravatar.cc/150?img=36',
    ),
    LeadModel(
      id: '#CTO1267',
      name: 'Divya',
      connector: 'Vivek',
      product: 'Cement',
      distanceKm: 3.9,
      status: Status.closed,
      dateTime: DateTime(2024, 11, 16, 14, 25),
      avatarUrl: 'https://i.pravatar.cc/150?img=41',
    ),
    LeadModel(
      id: '#CTO1268',
      name: 'Harshal',
      connector: 'Manish',
      product: 'TMT Steel',
      distanceKm: 4.7,
      status: Status.completed,
      dateTime: DateTime(2024, 11, 17, 10, 55),
      avatarUrl: 'https://i.pravatar.cc/150?img=45',
    ),
    LeadModel(
      id: '#CTO1269',
      name: 'Aarti',
      connector: 'Ganesh',
      product: 'Concrete',
      distanceKm: 5.1,
      status: Status.missed,
      dateTime: DateTime(2024, 11, 17, 12, 40),
      avatarUrl: 'https://i.pravatar.cc/150?img=50',
    ),
  ].obs;

  RxList<LeadModel> followups = <LeadModel>[].obs;

  void filterFollowupStatus() {
    if (activeStatusFilter.value == 'All') {
      followups.value = leads;
    } else {
      followups.value = leads
          .where((lead) => lead.status.name.toLowerCase() == activeStatusFilter.value.toLowerCase())
          .toList();
    }
  }

  RxList<LeadModel> prospectLeads = <LeadModel>[].obs;

  void filterProspectStatus() {
    if (activeProspectStatusFilter.value == 'Fresh') {
      prospectLeads.value = leads;
    } else {
      prospectLeads.value = leads.where((lead) {
        if (activeProspectStatusFilter.value.toLowerCase() == "Reached Out".toLowerCase()) {
          if (lead.status == Status.completed) {
            return true;
          } else {
            return false;
          }
        } else if (activeProspectStatusFilter.value.toLowerCase() == "On Hold".toLowerCase()) {
          if (lead.status == Status.pending) {
            return true;
          } else {
            return false;
          }
        } else if (activeProspectStatusFilter.value.toLowerCase() == "Converted".toLowerCase()) {
          if (lead.status == Status.closed) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      }).toList();
    }
  }

  final List<String> statusItems = <String>["All", "Pending", "Completed", "Missed"];

  final List<String> statusProspectItems = <String>["Fresh", "Reached Out", "On Hold", "Converted"];

  RxInt messagesCount = 2.obs;
  RxInt remindersCount = 2.obs;
  RxInt alertsCount = 2.obs;

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
      return "new";
    }
    if (activeFilter.value == "Qualified") {
      return "new";
    }
    return "new";
  }

  void setStatusFilter(String f) {
    activeStatusFilter.value = f;
    filterFollowupStatus();
  }

  void setStatusProspectFilter(String f) {
    activeProspectStatusFilter.value = f;
    log("setStatusProspectFilter: $f");
    filterProspectStatus();
  }

  void setCategory(String c) => category.value = c;

  void assignTo(String leadId, String user) {
    debugPrint('Assign $leadId to $user');
  }

  void setReminder(String leadId, DateTime when) {
    debugPrint('Reminder for $leadId at $when');
    Get.toNamed(Routes.SetReminder);
  }

  void chatNow(String leadId) {
    Get.toNamed(Routes.All_CHAT_LIST);
    debugPrint('Open chat for $leadId');
  }

  void filterLead() {
    if (getFilterStatusName() == "lead") {
      allLeadList.clear();
      allLeadList.addAll(
        (allLeadModel.value.data?.leads ?? []).where((e) => e.leadStage == "lead"),
      );
    } else if (getFilterStatusName() == "follow_up") {
      allFollowUpList.clear();
      allFollowUpList.addAll(
        (allLeadModel.value.data?.leads ?? []).where((e) => e.leadStage == "follow_up"),
      );
    }
  }

  Rx<AllLeadModel> allLeadModel = AllLeadModel().obs;
  RxList<Leads> allLeadList = <Leads>[].obs;
  RxList<Leads> allFollowUpList = <Leads>[].obs;

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
    required String remindAt,
    String? assignTo,
    String? note,
    String? priority,
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
        priority: priority
      );

      if (response.success == true) {
        if (onSuccess != null) onSuccess();
        SnackBars.successSnackBar(content: 'Lead moved to the follow up successfully');
        // await fetchConnections();
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
