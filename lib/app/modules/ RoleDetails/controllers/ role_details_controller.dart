// lib/app/modules/RoleDetails/controller/role_details_controller.dart
import 'package:get/get.dart';

class RoleDetailsController extends GetxController {
  RxString roleTitle = "Admin".obs;
  RxList<String> roleDescription = [
    "Full system access",
    "Manage all members",
    "Configure settings",
    "View all analytics",
  ].obs;
  RxList<String> functionalities = ["Approvals"].obs;
  RxString roleStatus = "Active".obs;
}
