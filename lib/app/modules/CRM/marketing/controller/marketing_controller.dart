import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/model/lead_model.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/followup_screen.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/lead_screen.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/prospect_screen.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/qualified_screen.dart';

class MarketingController extends GetxController {
  @override
  void onInit() {
    filterFollowupStatus();
    filterProspectStatus();
    super.onInit();
  }

  final isLoading = false.obs;
  // Notification counts
  final chatNotificationCount = 2.obs;
  final alertNotificationCount = 2.obs;
  final bellNotificationCount = 2.obs;

  // filters
  RxString activeFilter = 'Lead'.obs;
  RxString activeStatusFilter = 'All'.obs;
  RxString activeProspectStatusFilter = 'Fresh'.obs;
  RxString category = 'Marketing'.obs;

  // sample months for chart (kept from previous widget if needed)
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
  final items = ['Lead', 'Follow Up', 'Prospect', 'Qualified'];
  final filterScreens = {
    'Lead': const LeadScreen(),
    'Follow Up': const FollowupScreen(),
    'Prospect': const ProspectScreen(),
    'Qualified': const QualifiedScreen(),
  };

  // Today total
  int get todaysTotal => leads.length;

  // list of leads
  RxList<LeadModel> leads = <LeadModel>[
    LeadModel(
      id: '#CTO1256',
      name: 'Anand',
      connector: 'Anand',
      product: 'M sand',
      distanceKm: 2.8,
      status: Status.completed,
      dateTime: DateTime(2024, 11, 12, 10, 30),
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
    ),
    LeadModel(
      id: '#CTO1259',
      name: 'Shiva',
      connector: 'Shiva',
      product: 'M sand',
      distanceKm: 2.8,
      status: Status.closed,
      dateTime: DateTime(2024, 11, 12, 10, 40),
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
    ),
  ].obs;

  RxList<LeadModel> followups = <LeadModel>[].obs;
  void filterFollowupStatus() {
    if (activeStatusFilter.value == 'All') {
      followups.value = leads;
    } else {
      followups.value = leads
          .where(
            (lead) =>
                lead.status.name.toLowerCase() ==
                activeStatusFilter.value.toLowerCase(),
          )
          .toList();
    }
  }

  RxList<LeadModel> prospectLeads = <LeadModel>[].obs;
  void filterProspectStatus() {
    if (activeProspectStatusFilter.value == 'Fresh') {
      prospectLeads.value = leads;
    } else {
      prospectLeads.value = leads.where((lead) {
        if (activeProspectStatusFilter.value.toLowerCase() ==
            "Reached Out".toLowerCase()) {
          if (lead.status == Status.completed) {
            return true;
          } else {
            return false;
          }
        } else if (activeProspectStatusFilter.value.toLowerCase() ==
            "On Hold".toLowerCase()) {
          if (lead.status == Status.pending) {
            return true;
          } else {
            return false;
          }
        } else if (activeProspectStatusFilter.value.toLowerCase() ==
            "Converted".toLowerCase()) {
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

    // prospectLeads.value = leads
    //     .where(
    //       (lead) =>
    //           lead.status.name.toLowerCase() ==
    //           activeProspectStatusFilter.value.toLowerCase(),
    //     )
    //     .toList();
  }

  final List<String> statusItems = <String>[
    "All",
    "Pending",
    "Completed",
    "Closed",
    "Missed",
  ];

  final List<String> statusProspectItems = <String>[
    "Fresh",
    "Reached Out",
    "On Hold",
    "Converted",
  ];

  // Notifications counts
  RxInt messagesCount = 2.obs;
  RxInt remindersCount = 2.obs;
  RxInt alertsCount = 2.obs;

  // Actions
  void setFilter(String f) => activeFilter.value = f;
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

  void addLead(LeadModel l) {
    leads.insert(0, l);
    update();
  }

  void assignTo(String leadId, String user) {
    // Implement assignment logic, for now just print
    debugPrint('Assign $leadId to $user');
  }

  void setReminder(String leadId, DateTime when) {
    debugPrint('Reminder for $leadId at $when');
    Get.toNamed(Routes.SetReminder);
  }

  void chatNow(String leadId) {
    debugPrint('Open chat for $leadId');
  }

  void onAdd(BuildContext ctx) {
    final now = DateTime.now();
    addLead(
      LeadModel(
        id: '#CTO${1000 + leads.length + 1}',
        name: 'New LeadModel ${leads.length + 1}',
        connector: 'Connector X',
        product: 'Concrete',
        distanceKm: 1.2,
        dateTime: now,
        status: Status.values[leads.length % Status.values.length],
        avatarUrl: 'https://i.pravatar.cc/150?img=${20 + leads.length}',
      ),
    );
  }
}
