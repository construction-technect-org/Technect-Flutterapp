import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/ApprovalInbox/model/approval_inbox_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/ApprovalInbox/services/ApprovalInboxService.dart';

enum ApprovalFilter { all, approved, rejected }

class ApprovalInboxController extends GetxController {
  final statusCards = <Map<String, dynamic>>[].obs;
  Rx<ApprovalInboxModel> approvalInboxList = ApprovalInboxModel().obs;

  RxBool isLoading = false.obs;
  final ApprovalInboxService _service = ApprovalInboxService();

  // ✅ filter state
  Rx<ApprovalFilter> selectedFilter = ApprovalFilter.all.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInbox();
  }

  Future<void> fetchInbox() async {
    try {
      isLoading.value = true;
      approvalInboxList.value = await _service.fetchApprovalInbox();
    } finally {
      isLoading.value = false;
    }
  }

  List<ApprovalInbox> get filteredInbox {
    final allItems = approvalInboxList.value.data?.approvalInbox ?? [];
    switch (selectedFilter.value) {
      case ApprovalFilter.approved:
        return allItems.where((e) => e.status?.toLowerCase() == "approved").toList();
      case ApprovalFilter.rejected:
        return allItems.where((e) => e.status?.toLowerCase() == "rejected").toList();
      default:
        return allItems;
    }
  }
}
