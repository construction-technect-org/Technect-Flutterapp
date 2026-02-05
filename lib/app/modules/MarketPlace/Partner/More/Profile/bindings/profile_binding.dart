import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/poc_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileController>(ProfileController());
    Get.put<PointOfContactController>(PointOfContactController());
  }
}
