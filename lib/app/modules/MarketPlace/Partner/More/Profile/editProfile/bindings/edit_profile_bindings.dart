import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/editProfile/controller/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Recreate EditProfileController when needed without leaking
    Get.lazyPut<EditProfileController>(() => EditProfileController(), fenix: true);
  }
}
