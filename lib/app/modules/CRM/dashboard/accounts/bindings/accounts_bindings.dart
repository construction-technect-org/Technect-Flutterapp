import 'package:construction_technect/app/modules/CRM/dashboard/accounts/controller/accounts_controller.dart';
import 'package:get/get.dart';

class AccountsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountsController>(() => AccountsController());
  }
}
