import 'package:construction_technect/app/modules/AddTeam/controllers/add_team_controller.dart';
import 'package:get/get.dart';

class AddTeamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTeamController>(() => AddTeamController());
  }
}
