import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/sales/controller/sales_controller.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/sales/model/sales_model.dart';

class SaleLeadDetailController extends GetxController {
  RxString selectedCustomerType = "".obs;
  TextEditingController quoteController = TextEditingController(text: "Send a Quote");

  SaleLeads lead = SaleLeads();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      lead = Get.arguments["lead"];
      selectedCustomerType.value = Get.find<SalesController>().activeFilter.value;
    }
  }
}
