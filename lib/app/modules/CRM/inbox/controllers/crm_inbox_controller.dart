import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/inbox/model/crm_inbox_model.dart';
import 'package:construction_technect/app/modules/CRM/inbox/services/CrmInboxService.dart';

enum CrmInboxFilter { all, high, low }

class CrmInboxController extends GetxController {
  final statusCards = <Map<String, dynamic>>[].obs;
  Rx<CrmInboxModel> crmInboxList = CrmInboxModel().obs;

  RxBool isLoading = false.obs;
  final CrmInboxService _service = CrmInboxService();

  // ✅ filter state
  Rx<CrmInboxFilter> selectedFilter = CrmInboxFilter.all.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInbox();
  }

  Future<void> fetchInbox() async {
    try {
      isLoading.value = true;
      crmInboxList.value = await _service.fetchCrmInbox();
    } finally {
      isLoading.value = false;
    }
  }

  List<CrmInbox> get filteredInbox {
    final allItems = crmInboxList.value.data?.notifications ?? [];
    switch (selectedFilter.value) {
      case CrmInboxFilter.high:
        return allItems.where((e) => e.priority?.toLowerCase() == "high").toList();
      case CrmInboxFilter.low:
        return allItems.where((e) => e.priority?.toLowerCase() == "low").toList();
      default:
        return allItems;
    }
  }
}
