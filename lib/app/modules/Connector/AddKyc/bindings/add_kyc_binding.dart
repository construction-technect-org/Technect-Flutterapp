import 'package:construction_technect/app/modules/Connector/AddKyc/controllers/add_kyc_controller.dart';
import 'package:get/get.dart';

class AddKycBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddKycController>(() => AddKycController());
  }
}
