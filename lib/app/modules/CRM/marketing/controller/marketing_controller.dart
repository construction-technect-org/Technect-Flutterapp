import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/model/lead_model.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/followup_screen.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/lead_screen.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/prospect_screen.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/qualified_screen.dart';

class MarketingController extends GetxController {
  final isLoading = false.obs;
  // Notification counts
  final chatNotificationCount = 2.obs;
  final alertNotificationCount = 2.obs;
  final bellNotificationCount = 2.obs;

  // filters
  RxString activeFilter =
      'Lead'.obs; // LeadModel, Follow Up, Prospect, Qualified...
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
      dateTime: DateTime(2024, 11, 12, 10, 30),
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
    ),
    LeadModel(
      id: '#CTO1259',
      name: 'Shiva',
      connector: 'Shiva',
      product: 'M sand',
      distanceKm: 2.8,
      dateTime: DateTime(2024, 11, 12, 10, 40),
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
    ),
  ].obs;

  // Notifications counts
  RxInt messagesCount = 2.obs;
  RxInt remindersCount = 2.obs;
  RxInt alertsCount = 2.obs;

  // Actions
  void setFilter(String f) => activeFilter.value = f;
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
    // Example: open dialog to add a LeadModel
    // final c = controller;
    final now = DateTime.now();
    addLead(
      LeadModel(
        id: '#CTO${1000 + leads.length + 1}',
        name: 'New LeadModel ${leads.length + 1}',
        connector: 'Connector X',
        product: 'Concrete',
        distanceKm: 1.2,
        dateTime: now,
        avatarUrl: 'https://i.pravatar.cc/150?img=${20 + leads.length}',
      ),
    );
  }
}
