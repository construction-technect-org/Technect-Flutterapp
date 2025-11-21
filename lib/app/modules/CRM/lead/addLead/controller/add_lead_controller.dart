import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
import 'package:construction_technect/app/modules/CRM/lead/addLead/services/AddLeadService.dart';

class AddLeadController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  RxString selectedCustomerType = ''.obs;
  RxString selectedSource = ''.obs;
  final unitOfMeasureCtrl = TextEditingController();
  final customerNameCtrl = TextEditingController();
  final customerIdCtrl = TextEditingController();
  final customerPhoneCtrl = TextEditingController();
  final productNameCtrl = TextEditingController();
  final productCodeCtrl = TextEditingController();
  final productQtyCtrl = TextEditingController();
  final radiusCtrl = TextEditingController();
  final noteCtrl = TextEditingController();
  final eDateCtrl = TextEditingController();
  final contactedPersonCtrl = TextEditingController();
  final referenceCtrl = TextEditingController();
  final referralPhoneCtrl = TextEditingController();
  final siteLocationCtrl = TextEditingController();
  final companyNameCtrl = TextEditingController();
  final gstNumberCtrl = TextEditingController();
  final companyAddressCtrl = TextEditingController();
  final contactPersonCtrl = TextEditingController();
  final companyPhoneCtrl = TextEditingController();

  RxString customerPhone = "".obs;

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      createLead();
    }
  }

  RxInt isValid = (-1).obs;
  RxString countryCode = "+91".obs;
  RxString numberError = "".obs;

  final mobileNumberController = TextEditingController();

  void openPhoneNumberBottomSheet() {
    final formKey = GlobalKey<FormState>();
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
                  await fetchInfoByNumber();

                  hideKeyboard();
                  customerPhone.value = mobileNumber;
                  customerPhoneCtrl.text = customerPhone.value;

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

  RxBool isInfoLoad = false.obs;
  RxBool isCustomerIdVisible = false.obs;

  Future<void> fetchInfoByNumber({bool? isLoad}) async {
    try {
      isInfoLoad.value = isLoad ?? false;
      final result = await AddLeadServices().getIndoByNumber(
        number: mobileNumberController.text,
        countryCode: countryCode.value,
      );
      if (result.success == true) {
        if (result.data?.user != null) {
          if (kDebugMode) {
            customerNameCtrl.text =
                "${result.data?.user?.firstName} ${result.data?.user?.lastName}";
            customerIdCtrl.text = "${result.data?.user?.id}";
            isCustomerIdVisible.value = true;
            companyPhoneCtrl.text = result.data?.merchantProfile?.businessContactNumber ?? "";
            companyNameCtrl.text = result.data?.merchantProfile?.businessName ?? "";
            gstNumberCtrl.text = result.data?.user?.gstNumber ?? "";
            siteLocationCtrl.text =
                (result.data?.siteLocations ?? [])
                    .where((e) => e.isDefault == true)
                    .map((e) => e.fullAddress)
                    .firstOrNull ??
                "";
          }
        } else {
          if (kDebugMode) {}
        }
      }
      isInfoLoad.value = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isInfoLoad.value = false;
    }
  }

  Map<String, dynamic> buildLeadBody() {
    return {
      "customer_phone": customerPhone.value,
      "customer_name": customerNameCtrl.text,
      "customer_type": selectedCustomerType.value,
      "customer_id": customerIdCtrl.text,
      "product_name": productNameCtrl.text,
      "product_code": productCodeCtrl.text,
      "unit_of_measure": unitOfMeasureCtrl.text,
      "quantity": productQtyCtrl.text,
      "estimate_delivery_date": eDateCtrl.text,
      "radius": radiusCtrl.text,
      "company_phone": companyPhoneCtrl.text,
      "source": selectedSource.value,
      "reference": referenceCtrl.text,
      "referral_phone": referralPhoneCtrl.text,
      "site_location": siteLocationCtrl.text,
      "company_name": companyNameCtrl.text,
      "gst_number": gstNumberCtrl.text,
      "company_address": companyAddressCtrl.text,
      "status": "new",
      "notes": noteCtrl.text,
    };
  }

  Future<void> createLead() async {
    isLoading.value = true;

    try {
      final result = await AddLeadServices().addManualLead(data: buildLeadBody());

      if (result.success == true) {
        Get.back();
        SnackBars.successSnackBar(content: "Lead created successfully");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
