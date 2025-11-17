import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/model/lead_model.dart';

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

  // Today total
  int get todaysTotal => 98; //leads.length;

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
  }

  void chatNow(String leadId) {
    debugPrint('Open chat for $leadId');
  }
}
