import 'package:construction_technect/app/modules/UpdateYourCertifications/controllers/update_your_certifications_controller.dart';
import 'package:get/get.dart';

class UpdateYourCertificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateYourCertificationsController>(() => UpdateYourCertificationsController());
  }
}
