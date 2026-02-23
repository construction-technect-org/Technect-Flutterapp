import "dart:developer";


import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/SignUpService/sign_up_service.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/aadhar_details_model.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/gst_details_model.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/views/aadhar_verification_view.dart';
import 'package:timer_count_down/timer_controller.dart';

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
  RxBool isGSTValid = false.obs;
  RxBool isGSTLoading = false.obs;
  Rx<DetailsGST> detailsGST = DetailsGST().obs;
  Rx<AadharDetailsModel> detailsAadhar = AadharDetailsModel().obs;
  RxBool isAadharVerified = false.obs;
  String? currentRoute;
  final otpController = TextEditingController();
  final otpSend = false.obs;
  final otpVerify = false.obs;
  RxBool isResendVisible = false.obs;
  final countdownController = CountdownController(autoStart: true);

  final MainSignUpService _signUpService = Get.find<MainSignUpService>();

  void startTimer() {
    isResendVisible.value = false;
    countdownController.restart();
  }

  void onCountdownFinish() {
    isResendVisible.value = true;
  }

  Future<bool> sendOTPAadhar() async {
    try {
      final otpResponse = await _signUpService.sendAadharOTP(
        aadharNumber: aadhaarController.text.trim(),
      );
      if (otpResponse.success == true) {
        SnackBars.successSnackBar(
          content: 'OTP sent successfully to your Aadhar Mobile Number',
        );
        otpSend.value = true;
        return true;
      } else {
        SnackBars.errorSnackBar(
          content: otpResponse.message ?? 'Failed to send OTP',
        );
        otpSend.value = false;
        return false;
      }
    } catch (e) {
      //SnackBars.errorSnackBar(content: 'Error sending OTP: $e');
      otpSend.value = false;
      return false;
    }
  }

  Future<void> verifyAadharOTP() async {
    try {
      if (otpSend.value == true) {
        final response = await _signUpService.veriAadharOTP(
          otp: otpController.text.trim(),
        );
        if (response.success == true) {
          //SnackBars.successSnackBar(content: 'Aadhar Verified Successfully');
          log('Aadhar Verified Successfully');

          detailsAadhar.value = response;
          isGSTValid.value = true;
        } else {
          isGSTValid.value = false;
        }
      }
    } catch (e) {
      //SnackBars.errorSnackBar(content: 'Error verifying OTP: $e');
      isGSTValid.value = false;
    } finally {
      if (Get.isBottomSheetOpen == true) {
        currentRoute = Get.currentRoute;
        log("Route $currentRoute");
        Get.focusScope?.unfocus();
        log("geb back");
        Get.back();
        log("Ture Adhaar ${isGSTValid.value}");
        log("Not working");
      }
    }
  }

  void showBottomSheet() {
    Get.bottomSheet(
      const AadharOtpVerificationView(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  Future<void> validateGSTAvailability() async {
    final value = gstController.text.trim();
    isVerified.value = await Validate.validateGSTAvailability(value);
  }

  @override
  void onReady() {
    super.onReady();
    firstNameController.text = "";
    lastNameController.text = "";
  }

  RxString selectedFinalRole = "".obs;

  Future<void> verifyGSTDetails() async {
    final response = await _signUpService.verifyGST(
      gstNumber: gstController.text.trim(),
    );
    if (response.success == true) {
      SnackBars.successSnackBar(content: 'GST verified successfully!');
      isGSTValid.value = true;

      myPref.setKYC(true);
      detailsGST.value = response;
    }
  }

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
