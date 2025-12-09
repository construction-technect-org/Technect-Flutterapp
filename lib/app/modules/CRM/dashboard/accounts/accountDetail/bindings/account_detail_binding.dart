import 'package:construction_technect/app/modules/CRM/dashboard/accounts/accountDetail/controller/account_lead_detail_controller.dart';
import 'package:get/get.dart';

class AccountLeadDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountLeadDetailController>(() => AccountLeadDetailController());
  }
}
