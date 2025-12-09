import 'package:construction_technect/app/modules/CRM/dashboard/sales/saleDetail/controller/sale_lead_detail_controller.dart';
import 'package:get/get.dart';

class SaleLeadDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaleLeadDetailController>(() => SaleLeadDetailController());
  }
}
