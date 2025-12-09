import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/accounts/controller/accounts_controller.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/accounts/model/accounts_model.dart';

class AccountLeadDetailController extends GetxController {
  RxString selectedCustomerType = "".obs;
  TextEditingController quoteController = TextEditingController(text: "Send a Quote");

  AccountLeads lead = AccountLeads();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      lead = Get.arguments["lead"];
      selectedCustomerType.value = Get.find<AccountsController>().activeFilter.value;
    }
  }
}
