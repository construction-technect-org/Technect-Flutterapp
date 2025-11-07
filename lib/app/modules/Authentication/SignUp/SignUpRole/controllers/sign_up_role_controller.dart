import 'package:construction_technect/app/core/utils/imports.dart';

class SignUpRoleController extends GetxController {
  RxInt selectedRole = (-1).obs;
  TextEditingController otherRoleController = TextEditingController();
  RxString otherRoleString = "".obs;
  RxString selectedRoleName = "".obs;

  RxString selectedFinalRole = "".obs;

  List roleName = [
    'Manufacturer',
    'House-Owner',
    'Architect',
    'Designer/ Engineer',
    'Contractor',
    'Other',
  ];

  List roleId = [1, 2, 3, 4, 5, 6];

  final roleImages = [
    Asset.role1,
    Asset.houseOwner,
    Asset.architect,
    Asset.design,
    Asset.contractor,
    Asset.other,
  ];

  void selectRole(int index) {
    selectedRole.value = index;
  }
}
