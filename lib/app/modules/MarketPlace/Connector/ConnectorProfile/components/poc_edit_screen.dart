import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/controllers/connector_profile_controller.dart';

class EditPocProfile extends StatelessWidget {
  final EditPocProfileController eController = Get.put(
    EditPocProfileController(),
  );

  @override
  Widget build(BuildContext context) {
    final bool type = Get.arguments;
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
                    title: const Text('Edit Poc profile information'),
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
                              Gap(3.h),
                              CommonTextField(
                                hintText: "Enter your first name",
                                headerText: "Name",
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
                                autofillHints: const [AutofillHints.familyName],
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
                                readOnly: !type,
                                hintText: "Enter your Mobile Number",
                                headerText: "Mobile Number",
                                controller: eController.numberController,
                                // validator: (value) =>
                                //     Validate.validateMobileNumber(value),
                              ),
                              Gap(2.h),
                              CommonTextField(
                                readOnly: !type,
                                hintText:
                                    "Enter your Alternative Mobile Number",
                                headerText: "Alternative Mobile Number",
                                controller:
                                    eController.alternativeNumberController,
                                // validator: (value) =>
                                //     Validate.validateMobileNumber(value),
                              ),
                              Gap(2.h),
                              CommonTextField(
                                readOnly: !type,
                                hintText: "Enter your email address",
                                headerText: "Email ID",
                                controller: eController.emailController,
                                validator: (value) =>
                                    Validate.validateEmail(value),
                              ),
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
              buttonName: "Update",
              onTap: () async {
                if (eController.formKey.currentState!.validate()) {
                  await eController.updateProfile().then((value) async {
                    Get.back();
                    SnackBars.successSnackBar(content: "$value");
                    await Get.find<ConnectorProfileController>()
                        .pointOfContact();
                  });
                } else {
                  SnackBars.successSnackBar(
                    content: "not validate Poc Profile updated successfully!",
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class EditPocProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final fNameController = TextEditingController();
  final designationController = TextEditingController();
  final numberController = TextEditingController();
  final alternativeNumberController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // if (myPref.getRole() == "partner") {
    final connectorProfileController = Get.find<ConnectorProfileController>();
    final poc =
        connectorProfileController.profileDatas.value?.connector?.pocDetails;
    designationController.text = poc?.pocDesignation ?? "";
    fNameController.text = poc?.pocName ?? "";
    numberController.text = poc?.pocPhone ?? "";
    alternativeNumberController.text = poc?.pocAlternatePhone ?? "";
    emailController.text = poc?.pocEmail ?? "";
    // } else {
    //   final pController = Get.find<CommonController>();
    //   designationController.text =
    //       pController.profileData.value.data?.user?.lastName ?? "";
    //   fNameController.text =
    //       pController.profileData.value.data?.user?.firstName ?? "";
    //   numberController.text =
    //       pController.profileData.value.data?.user?.firstName ?? "";
    //   alternativeNumberController.text =
    //       pController.profileData.value.data?.user?.firstName ?? "";
    //   emailController.text =
    //       pController.profileData.value.data?.user?.email ?? "";
    // }
  }

  ApiManager apiManager = ApiManager();
  RxBool isLoading = false.obs;

  Future<dynamic> updateProfile() async {
    isLoading.value = true;

    try {
      // Fields to send
      final Map<String, dynamic> fields = {
        "pocName": fNameController.text.trim(),
        "pocDesignation": designationController.text.trim(),
        "pocPhone": numberController.text.trim(),
        "pocAlternatePhone": alternativeNumberController.text.trim(),
        "pocEmail": emailController.text.trim(),
      };

      final update = await apiManager.patchObject(
        url:
            '/${APIConstants.updateConnectorPocDetails}/${myPref.profileId.val}',
        body: fields,
      );
      if (update['success'] == true) {
        // Get.back();
        SnackBars.successSnackBar(
          content: "${update['message']}Profile updated successfully!",
        );
        return update['message'];
      }
      return;
    } catch (e) {
      SnackBars.errorSnackBar(content: "Update failed: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
