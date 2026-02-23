import "dart:developer";


import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validation_utils.dart';
import 'package:construction_technect/app/data/CommonController.dart';

class ConnectorPointOfContactScreen extends StatelessWidget {
  ConnectorPointOfContactScreen({super.key});

  final eController = Get.put<ConnectorPointOfContactController>(
    ConnectorPointOfContactController(),
  );
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: eController.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Asset.moreIBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  CommonAppBar(
                    backgroundColor: Colors.transparent,
                    title: const Text('Point of contact'),
                    isCenter: false,
                    leading: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(16),
                              CommonTextField(
                                hintText: "Enter your first name",
                                headerText: "First Name",
                                controller: eController.fNameController,
                                autofillHints: const [AutofillHints.givenName],
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                  NameInputFormatter(),
                                ],
                                validator: (value) => validateName(
                                  value,
                                  fieldName: "first name",
                                ),
                              ),
                              Gap(2.h),
                              CommonTextField(
                                hintText: "Enter your designation",
                                headerText: "Designation",
                                controller: eController.designationController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                  NameInputFormatter(),
                                ],
                                validator: (value) => validateName(
                                  value,
                                  fieldName: "designation",
                                ),
                              ),
                              Gap(2.h),
                              CommonTextField(
                                hintText: "Enter your email address",
                                headerText: "Email",
                                controller: eController.emailController,
                              ),
                              Gap(2.h),
                              CommonTextField(
                                hintText: "9292929929",
                                headerText: "Business Contact Number",
                                controller: eController.numberController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                validator: ValidationUtils
                                    .validateBusinessContactNumber,
                              ),
                              Gap(2.h),
                              CommonTextField(
                                hintText: "9292929929",
                                headerText:
                                    "Alternative Contact Number (Optional)",
                                controller:
                                    eController.alternativeNumberController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                              ),
                              Gap(2.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24.0),
            child: RoundedButton(
              buttonName: "Save",
              onTap: () {
                if (formKey.currentState!.validate()) {
                  eController.updatePointOfContact();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ConnectorPointOfContactController extends GetxController {
  final fNameController = TextEditingController();
  final emailController = TextEditingController();
  final designationController = TextEditingController();
  final numberController = TextEditingController();
  final alternativeNumberController = TextEditingController();
  final CommonController homeController = Get.find<CommonController>();

  @override
  void onInit() {
    super.onInit();
    final pointOfContact =
        homeController.profileData.value.data?.connectorProfile?.pointOfContact;
    fNameController.text = pointOfContact?.name ?? "";
    emailController.text = pointOfContact?.email ?? "";
    designationController.text = pointOfContact?.relation ?? "";
    numberController.text = pointOfContact?.phoneNumber ?? "";
    alternativeNumberController.text =
        pointOfContact?.alternativePhoneNumber ?? "";
  }

  ApiManager apiManager = ApiManager();
  RxBool isLoading = false.obs;

  Future<void> updatePointOfContact() async {
    isLoading.value = true;

    try {
      final Map<String, dynamic> requestBody = {
        'name': fNameController.text.trim(),
        'relation': designationController.text.trim(),
        'phone_number': numberController.text.trim(),
        'alternative_phone_number': alternativeNumberController.text.trim(),
        'email': emailController.text.trim(),
      };

      await apiManager.postObject(
        url: APIConstants.pointOfContactConnector,
        body: requestBody,
      );

      await Get.find<CommonController>().fetchProfileData();

      Get.back();
    } catch (e) {
      // ignore: avoid_print
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fNameController.dispose();
    emailController.dispose();
    designationController.dispose();
    numberController.dispose();
    alternativeNumberController.dispose();
    super.onClose();
  }
}
