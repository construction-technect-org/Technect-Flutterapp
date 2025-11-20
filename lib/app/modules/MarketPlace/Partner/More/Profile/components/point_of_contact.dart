import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/core/utils/validation_utils.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';

class PointOfContentScreen extends StatelessWidget {
  final PointOfContactController eController = Get.put(
    PointOfContactController(),
  );

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
                          key: eController.formKey,
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
                              Focus(
                                onFocusChange: (hasFocus) {
                                  if (!hasFocus) {
                                    final email =
                                        eController.emailController.text;
                                    // Only validate availability if format is valid
                                    final formatError = Validate.validateEmail(
                                      email,
                                    );
                                    if (formatError == null) {
                                      eController.validateEmailAvailability(
                                        email,
                                      );
                                    } else {
                                      // Format error - clear API error, validator will show format error
                                      eController.emailError.value = "";
                                    }
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonTextField(
                                      hintText: "Enter your email address",
                                      headerText: "Email",
                                      controller: eController.emailController,
                                      validator: (value) =>
                                          Validate.validateEmail(value),
                                      autofillHints: const [
                                        AutofillHints.email,
                                      ],
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(254),
                                        EmailInputFormatter(),
                                      ],

                                      onChange: (value) {
                                        eController.emailError.value = "";
                                      },
                                      onFieldSubmitted: (value) {
                                        if (value != null) {
                                          // Only validate availability if format is valid
                                          final formatError =
                                              Validate.validateEmail(value);
                                          if (formatError == null) {
                                            eController
                                                .validateEmailAvailability(
                                                  value,
                                                );
                                          } else {
                                            // Format error - clear API error, validator will show format error
                                            eController.emailError.value = "";
                                          }
                                        }
                                      },
                                    ),
                                    Obx(() {
                                      if (eController
                                          .emailError
                                          .value
                                          .isNotEmpty) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8.0,
                                          ),
                                          child: Text(
                                            eController.emailError.value,
                                            style: MyTexts.medium13.copyWith(
                                              color: MyColors.red33,
                                            ),
                                          ),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    }),
                                  ],
                                ),
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
              onTap: () async {
                if (!eController.formKey.currentState!.validate()) return;

                await eController.validateEmailAvailability(
                  eController.emailController.text,
                );
                if (eController.emailError.value.isNotEmpty) {
                  SnackBars.errorSnackBar(
                    content: eController.emailError.value,
                  );
                  return;
                }

                eController.updatePointOfContact();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class PointOfContactController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final fNameController = TextEditingController();
  final emailController = TextEditingController();
  final designationController = TextEditingController();
  final numberController = TextEditingController();
  final alternativeNumberController = TextEditingController();
  final HomeController homeController = Get.find<HomeController>();

  // Email validation state
  RxString emailError = "".obs;
  RxBool isEmailValidating = false.obs;

  @override
  void onInit() {
    super.onInit();
    final pointOfContact =
        homeController.profileData.value.data?.merchantProfile?.pointOfContact;
    fNameController.text = pointOfContact?.name ?? "";
    emailController.text = pointOfContact?.email ?? "";
    designationController.text = pointOfContact?.relation ?? "";
    numberController.text = pointOfContact?.phoneNumber ?? "";
    alternativeNumberController.text =
        pointOfContact?.alternativePhoneNumber ?? "";
  }

  ApiManager apiManager = ApiManager();
  RxBool isLoading = false.obs;
  Future<void> validateEmailAvailability(String email) async {
    final formatError = Validate.validateEmail(email);
    if (formatError != null) {
      emailError.value = "";
      isEmailValidating.value = false;
      return;
    }
    isEmailValidating.value = true;
    final apiError = await Validate.validateEmailAsync(email);
    emailError.value = apiError ?? "";
    isEmailValidating.value = false;
  }

  Future<void> updatePointOfContact() async {
    isLoading.value = true;

    try {
      final Map<String, dynamic> requestBody = {
        'name': fNameController.text.trim(),
        'relation': designationController.text.trim(),
        'phone_number': numberController.text.trim(),
        if (alternativeNumberController.text.isNotEmpty)
          'alternative_phone_number': alternativeNumberController.text.trim(),
        'email': emailController.text.trim(),
      };

      await apiManager.postObject(
        url: APIConstants.pointOfContactMerchant,
        body: requestBody,
      );

      await Get.find<HomeController>().fetchProfileData();

      Get.back();
    } catch (e) {
      // ignore: avoid_print
    } finally {
      isLoading.value = false;
    }
  }
}
