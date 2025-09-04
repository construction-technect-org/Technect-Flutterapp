import 'package:construction_technect/app/core/utils/imports.dart';

class SignUpRoleController extends GetxController {
  RxInt selectedRole = (-1).obs;

  List roleName = [
    'Merchant',
    'Civil Engineer',
    'Architect',
    'Designer',
    'House-Owner',
    'Other',
  ];

  List roleId = [1, 2, 3, 4, 5, 6];

  final roleImages = [
    Asset.merchantIcon,
    Asset.civilIcon,
    Asset.architectIcon,
    Asset.designerIcon,
    Asset.houseIcon,
    Asset.otherIcon,
  ];

  void selectRole(int index) {
    selectedRole.value = index;
  }
}
