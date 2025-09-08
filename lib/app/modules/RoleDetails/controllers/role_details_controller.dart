import 'package:construction_technect/app/core/utils/custom_snackbar.dart';
import 'package:construction_technect/app/modules/RoleDetails/Service/role_detail_service.dart';
import 'package:construction_technect/app/modules/RoleDetails/models/role_details_model.dart';
import 'package:get/get.dart';

class RoleDetailsController extends GetxController {
  RoleDetailsModel? roleDetailsModel;
  RxString roleTitle = "Admin".obs;
  RxString roleId = "".obs;
  RxString roleDescription = "".obs;
  RxString functionalities = "".obs;
 /* RxList<String> roleDescription = [
    "Full system access",
    "Manage all members",
    "Configure settings",
    "View all analytics",
  ].obs;*/
  //RxList<String> functionalities = ["Approvals"].obs;
  RxString roleStatus = "Active".obs;
  RxBool isLoading = false.obs;
  RoleDetailService roleDetailService = RoleDetailService();

  @override
  void onInit() {
    super.onInit();
    handlePassedData();
  }

  void handlePassedData() {
    final arguments = Get.arguments;
    roleId.value = arguments?['role_ID']?.toString() ?? "";

    if (roleId.value.isNotEmpty) {
      roleDetail();
    } else {
      SnackBars.errorSnackBar(content: "No role ID provided");
    }
  }

  Future<void> roleDetail() async {
    isLoading.value = true;
    try {
      final roleDetails = await roleDetailService.roleDetail(roleId.value);

      if (roleDetails.success == true) {
        roleDetailsModel = roleDetails;

        // Update UI variables with API data
        roleTitle.value = roleDetailsModel?.data?.roleTitle ?? "Admin";
        roleStatus.value = roleDetailsModel?.data?.isActive==true?  "Active":"InActive";
        roleDescription.value = roleDetailsModel?.data?.roleDescription ?? '';
        functionalities.value = roleDetailsModel?.data?.functionalities ?? '';
      } else {
        SnackBars.errorSnackBar(
          content: roleDetails.message ?? 'Failed to load role details',
        );
      }
    } catch (e) {
      SnackBars.errorSnackBar(
        content: 'Failed to fetch role details: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }
}