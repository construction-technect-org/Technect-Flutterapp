import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/validate.dart';

class SignUpRoleController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final aadhaarController = TextEditingController();
  final gstController = TextEditingController();
  RxInt selectedRole = (-1).obs;
  TextEditingController otherRoleController = TextEditingController();
  RxString otherRoleString = "".obs;
  RxString selectedRoleName = "".obs;
  RxBool isVerified = false.obs;

  Future<void> validateGSTAvailability() async {
    final value = gstController.text.trim();
    isVerified.value = await Validate.validateGSTAvailability(value);
  }

  @override
  void onReady() {
    super.onReady();
  }

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
