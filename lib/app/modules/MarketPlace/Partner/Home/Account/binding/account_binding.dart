import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/Account/controller/account_controller.dart';
import 'package:get/get.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
