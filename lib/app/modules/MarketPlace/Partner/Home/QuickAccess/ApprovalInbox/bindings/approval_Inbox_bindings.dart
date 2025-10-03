import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/ApprovalInbox/controllers/approval_Inbox_controller.dart';
import 'package:get/get.dart';

class ApprovalInboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApprovalInboxController>(() => ApprovalInboxController());
  }
}
