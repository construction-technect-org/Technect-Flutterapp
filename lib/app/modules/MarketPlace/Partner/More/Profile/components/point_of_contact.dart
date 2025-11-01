import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validation_utils.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:gap/gap.dart';

class PointOfContentScreen extends StatelessWidget {
  PointOfContentScreen({super.key});

  final eController = Get.put<PointOfContactController>(
    PointOfContactController(),
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
                                readOnly: true,
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
                  eController.updateProfile();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class PointOfContactController extends GetxController {
  final fNameController = TextEditingController();
  final emailController = TextEditingController();
  final designationController = TextEditingController();
  final numberController = TextEditingController();
  final alternativeNumberController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    if (myPref.getRole() == "partner") {
      final pController = Get.find<ProfileController>();
      fNameController.text = pController.userData?.firstName ?? "";
      emailController.text = pController.userData?.email ?? "";
    } else {
      final pController = Get.find<HomeController>();
      fNameController.text =
          pController.profileData.value.data?.user?.firstName ?? "";
      emailController.text =
          pController.profileData.value.data?.user?.email ?? "";
    }
  }

  ApiManager apiManager = ApiManager();
  RxBool isLoading = false.obs;

  Future<void> updateProfile() async {
    isLoading.value = true;

    try {
      // Fields to send
      final Map<String, dynamic> fields = {'first_name': fNameController.text};

      final _ = await apiManager.putMultipart(
        url: APIConstants.updateProfile,
        fields: fields,
      );
      await Get.find<HomeController>().fetchProfileData();

      Get.back();
      SnackBars.successSnackBar(content: "Profile updated successfully!");
    } catch (e) {
      SnackBars.errorSnackBar(content: "Update failed: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
