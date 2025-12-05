import 'package:construction_technect/app/modules/CRM/inbox/controllers/crm_inbox_controller.dart';
import 'package:get/get.dart';

class CrmInboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrmInboxController>(() => CrmInboxController());
  }
}
