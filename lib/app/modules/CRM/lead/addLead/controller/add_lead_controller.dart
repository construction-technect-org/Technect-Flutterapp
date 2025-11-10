import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';

class AddLeadController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Dropdowns
  RxString selectedCustomerType = ''.obs;
  RxString selectedSource = ''.obs;

  // Text controllers
  final unitOfMeasureCtrl = TextEditingController();
  final customerNameCtrl = TextEditingController();
  final customerIdCtrl = TextEditingController();
  final customerPhoneCtrl = TextEditingController();
  final productNameCtrl = TextEditingController();
  final productCodeCtrl = TextEditingController(text: "87DFF43");
  final contactedPersonCtrl = TextEditingController();
  final referenceCtrl = TextEditingController();
  final referralPhoneCtrl = TextEditingController();
  final siteLocationCtrl = TextEditingController();
  final companyNameCtrl = TextEditingController();
  final gstNumberCtrl = TextEditingController();
  final companyAddressCtrl = TextEditingController();
  final contactPersonCtrl = TextEditingController();
  final companyPhoneCtrl = TextEditingController();

  RxList numList = [].obs;

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      Get.snackbar(
        "Success",
        "Lead added successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  RxInt isValid = (-1).obs;
  RxString countryCode = "+91".obs;
  RxString numberError = "".obs;

  final mobileNumberController = TextEditingController();

  void openPhoneNumberBottomSheet() {
    mobileNumberController.clear();
    final formKey = GlobalKey<FormState>();
    isValid.value = -1;
    numberError.value = "";

    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(12),
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const Gap(24),
              Text("Mobile Number", style: MyTexts.medium20.copyWith(color: Colors.black)),
              const Gap(5),
              CommonPhoneField(
                controller: mobileNumberController,
                focusNode: FocusNode(),
                isValid: isValid,
                customErrorMessage: numberError,
                onCountryCodeChanged: (code) {
                  countryCode.value = code;
                },
              ),
              const Gap(15),
              RoundedButton(
                buttonName: "Continue",
                onTap: () async {
                  isValid.value = -1;
                  numberError.value = "";

                  if (!formKey.currentState!.validate()) return;

                  final mobileNumber = mobileNumberController.text.trim();
                  final mobileError = await Validate.validateMobileNumberAsync(
                    mobileNumber,
                    countryCode: countryCode.value,
                  );

                  if (mobileError != null && mobileError.isNotEmpty) {
                    numberError.value = mobileError;
                    isValid.value = 1;
                    return;
                  }

                  hideKeyboard();
                  numList.add(mobileNumber);
                  Get.back();
                },
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ).whenComplete(() {
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }
}
