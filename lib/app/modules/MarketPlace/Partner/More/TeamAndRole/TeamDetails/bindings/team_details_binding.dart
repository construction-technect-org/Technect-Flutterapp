// lib/app/modules/RoleDetails/bindings/role_details_binding.dart
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/TeamDetails/controllers/team_details_controller.dart';
import 'package:get/get.dart';

class TeamDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeamDetailsController>(() => TeamDetailsController());
  }
}
