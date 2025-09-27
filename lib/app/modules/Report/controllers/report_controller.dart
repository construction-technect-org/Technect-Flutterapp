import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ApprovalInbox/model/approval_inbox_model.dart';
import 'package:construction_technect/app/modules/ApprovalInbox/services/ApprovalInboxService.dart';

class  ReportController extends GetxController {
  final statusCards = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchInbox();
  }
  RxBool isLoading = false.obs;
  final ApprovalinboxService _service = ApprovalinboxService();
  final RxList<Notifications> approvalInboxList = <Notifications>[].obs;

  Future<void> fetchInbox() async {
    try {
      isLoading.value = true;
      final result = await _service.fetchAllNotification();
      if (result != null && result.success==true) {
        approvalInboxList.assignAll((result.data??Data()).notifications??[]);
      }
    } finally {
      isLoading.value = false;
    }
  }



}
