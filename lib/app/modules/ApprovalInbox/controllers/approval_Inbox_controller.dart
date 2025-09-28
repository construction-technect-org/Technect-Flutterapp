import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ApprovalInbox/model/approval_inbox_model.dart';
import 'package:construction_technect/app/modules/ApprovalInbox/services/ApprovalInboxService.dart';

class ApprovalInboxController extends GetxController {
  final statusCards = <Map<String, dynamic>>[].obs;
  Rx<ApprovalInboxModel> approvalInboxList = ApprovalInboxModel().obs;

  @override
  void onInit() {
    super.onInit();
    isInbox.value = Get.arguments["isInbox"] ?? false;
    if (isInbox.value) {
      fetchInbox();
    }
  }

  RxBool isLoading = false.obs;
  RxBool isInbox = false.obs;
  final ApprovalInboxService _service = ApprovalInboxService();

  Future<void> fetchInbox() async {
    try {
      isLoading.value = true;
      approvalInboxList.value = await _service.fetchApprovalInbox();
    } finally {
      isLoading.value = false;
    }
  }
}
