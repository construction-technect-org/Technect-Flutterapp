import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/model/lead_model.dart';

class LeadDetailController extends GetxController {
  RxString selectedCustomerType = 'Follow Up'.obs;
  TextEditingController quoteController = TextEditingController(text: "Send a Quote");

  Leads lead = Leads();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      lead = Get.arguments["lead"];
    }
  }
}
