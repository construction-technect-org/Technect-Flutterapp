import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';

class AddNewRequController extends GetxController {
  final isLoading = false.obs;

  // Form state
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Dropdown selections
  final RxnString selectedCustomerType = RxnString();
  final RxnString selectedSource = RxnString();

  // Text controllers
  final unitOfMeasureCtrl = TextEditingController();
  final customerNameCtrl = TextEditingController();
  final customerIdCtrl = TextEditingController();
  final productNameCtrl = TextEditingController();
  final productCodeCtrl = TextEditingController();
  final contactedPersonCtrl = TextEditingController();
  final referenceCtrl = TextEditingController();
  final referralPhoneCtrl = TextEditingController();
  final siteLocationCtrl = TextEditingController();
  final companyNameCtrl = TextEditingController();
  final gstNumberCtrl = TextEditingController();
  final companyAddressCtrl = TextEditingController();
  final contactPersonCtrl = TextEditingController();
  final companyPhoneCtrl = TextEditingController();
  // Phone number chips list
  final RxList<String> numList = <String>[].obs;

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
              Text(
                "Mobile Number",
                style: MyTexts.medium20.copyWith(color: Colors.black),
              ),
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

  // Handle submit action
  void onSubmit(BuildContext context) {
    if (formKey.currentState?.validate() != true) return;
    if (numList.isEmpty) {
      SnackBars.errorSnackBar(content: "Please enter Customer Phone no");
      return;
    }
    SnackBars.successSnackBar(content: 'Requirement added successfully');
    Navigator.pop(context);
  }
}
