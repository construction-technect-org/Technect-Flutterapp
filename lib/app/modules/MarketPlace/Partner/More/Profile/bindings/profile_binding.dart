import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Keep ProfileController alive across routes to preserve reactive state
    Get.put<ProfileController>(ProfileController(), permanent: true);
  }
}
