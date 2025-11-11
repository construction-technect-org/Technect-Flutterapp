import 'package:construction_technect/app/core/utils/imports.dart';

class LeadDashController extends GetxController {
  final isLoading = false.obs;

  // Filter tabs
  final selectedFilterIndex = 0.obs;
  final filterTabs = [
    'Leads',
    'Contacted',
    'Qualified',
    'Requirement',
    'Quote sent',
    'Negotiation',
  ];

  // CRM/VRM toggle
  final isCRMSelected = true.obs;

  // Leads data
  final totalLeads = 6.obs;
  final inboundLeads = 6.obs;
  final outboundLeads = 6.obs;

  // Task data
  final totalTasks = 6.obs;
  final completedTasks = 6.obs;
  final upcomingTasks = 6.obs;

  // Pipeline data
  final pipelineData = [
    {'label': 'Leads', 'count': 45, 'color': const Color(0xFFFF6B6B)},
    {'label': 'Contacted', 'count': 23, 'color': const Color(0xFFFFD93D)},
    {'label': 'Qualified', 'count': 12, 'color': const Color(0xFF6BCF7F)},
    {'label': 'Quote Sent', 'count': 8, 'color': const Color(0xFF4ECDC4)},
  ].obs;

  // Analysis funnel data
  final funnelData = [
    {'label': 'Lead Generated', 'count': 45, 'color': const Color(0xFFFF6B6B)},
    {'label': 'Contacted', 'count': 30, 'color': const Color(0xFFFFA07A)},
    {'label': 'Requirement', 'count': 15, 'color': const Color(0xFFFFD93D)},
    {'label': 'Quote Sent', 'count': 23, 'color': const Color(0xFF90EE90)},
    {'label': 'Negotiation', 'count': 14, 'color': const Color(0xFF6BCF7F)},
    {'label': 'Follow up', 'count': 15, 'color': const Color(0xFF87CEEB)},
    {'label': 'Deal Won', 'count': 20, 'color': const Color(0xFF4ECDC4)},
    {'label': 'Deal Lost', 'count': 5, 'color': const Color(0xFF9370DB)},
  ].obs;

  // Lead conversations
  final leadConversations = [
    {
      'location': 'Location Jp nagar',
      'product': 'Product Manufacture sand',
      'id': '48',
    },
    {
      'location': 'Location Jp nagar',
      'product': 'Product Manufacture sand',
      'id': '48',
    },
  ].obs;

  // Notification counts
  final chatNotificationCount = 2.obs;
  final alertNotificationCount = 2.obs;
  final bellNotificationCount = 2.obs;

  void onFilterTabChanged(int index) {
    selectedFilterIndex.value = index;
    // Load data based on filter
  }

  void toggleCRMVRM(bool isCRM) {
    isCRMSelected.value = isCRM;
    // Load data based on selection
  }
}
