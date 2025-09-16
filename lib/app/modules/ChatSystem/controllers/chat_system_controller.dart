import 'package:construction_technect/app/core/utils/imports.dart';

class ChatSystemController extends GetxController {
  RxString selectedRole = "".obs;

  final TextEditingController textController = TextEditingController();

  // Expandable states
  RxBool profileUpdation = false.obs;
  RxBool profileApproval = false.obs;
  RxBool profileDeletion = false.obs;

  // Selected chip
  RxString selectedChip = "".obs;

  void toggleTile(RxBool tile) {
    tile.value = !tile.value;
  }

  void selectChip(String label) {
    selectedChip.value = label;
  }

  void selectRole(String role) {
    selectedRole.value = role;
  }
}
