import 'dart:io';

import 'package:construction_technect/app/core/utils/CommonConstant.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
import 'package:construction_technect/app/modules/CRM/lead/addLead/services/AddLeadService.dart';
import 'package:image_picker/image_picker.dart';

class AddLeadController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  VoidCallback? onLeadCreate;

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

  final ImagePicker _picker = ImagePicker();

  void pickImageBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: MyColors.gray2E),
              title: Text(
                "Camera",
                style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
              ),
              onTap: () {
                Get.back();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo, color: MyColors.gray2E),
              title: Text(
                "Gallery",
                style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
              ),
              onTap: () {
                Get.back();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;
    final compressedFile = await CommonConstant().compressImage(
      File(pickedFile.path),
    );
    selectedImage.value = File(compressedFile.path);
  }

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
            companyPhoneCtrl.text =
                result.data?.merchantProfile?.businessContactNumber ?? "";
            companyNameCtrl.text =
                result.data?.merchantProfile?.businessName ?? "";
            gstNumberCtrl.text =
                result.data?.user?.gstNumber ??
                (result.data?.merchantProfile?.gstinNumber ?? "");
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
      "connector_phone": customerPhone.value,
      "connector_name": customerNameCtrl.text,
      "connector_type": selectedCustomerType.value,
      "connector_id": customerIdCtrl.text,
      "product_name": productNameCtrl.text,
      "product_code": "PC-${productCodeCtrl.text}".toUpperCase(),
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
      final result = await AddLeadServices().addManualLead(
        data: buildLeadBody(),
      );

      if (result.success == true) {
        onLeadCreate?.call();
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      onLeadCreate = Get.arguments["onLeadCreate"];
    }
  }
}
