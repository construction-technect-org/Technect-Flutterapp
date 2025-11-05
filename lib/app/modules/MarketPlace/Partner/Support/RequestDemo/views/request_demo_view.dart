import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/RequestDemo/controllers/request_demo_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RequestDemoView extends StatelessWidget {
  final RequestDemoController controller = Get.put(RequestDemoController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        backgroundColor: MyColors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    controller.selectedMainCategory.value = "";
                    controller.emilaController.text = "";
                    controller.phoneNumberController.text = "";
                    formKey.currentState?.reset();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    controller.isValid.value = -1;
                    if (controller.phoneNumberController.text.isEmpty) {
                      controller.isValid.value = 0;
                    }
                    if (formKey.currentState!.validate()) {
                      if (controller.phoneNumberController.text.isEmpty) {
                        controller.isValid.value = 0;
                      } else {
                        controller.addRequestDemo();
                      }
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: MyColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            const CommonBgImage(),
            Column(
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text("Request Demo"),
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
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.h),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: YoutubePlayer(
                                controller: controller.youtubeController,
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: MyColors.primary,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            CommonDropdown<String>(
                              headerText: 'Request Demo for',
                              borderColor: MyColors.primary,
                              hintText: "Select from here",
                              items: controller.mainCategories,
                              selectedValue: controller.selectedMainCategory,
                              // pass Rx directly
                              itemLabel: (item) => item,
                              onChanged: controller.isEdit
                                  ? null
                                  : (value) {
                                      controller.onMainCategorySelected(value);
                                    },
                              validator: (val) {
                                if (val == null) {
                                  return 'Please select demo category';
                                }
                                return null;
                              },
                              enabled: !controller.isEdit,
                            ),
                            SizedBox(height: 2.h),
                            CommonPhoneField(
                              headerText: 'Phone Number',
                              controller: controller.phoneNumberController,
                              focusNode: FocusNode(),
                              isValid: controller.isValid,
                              onCountryCodeChanged: (code) =>
                                  controller.countryCode.value = code,
                            ),
                            SizedBox(height: 2.h),
                            CommonTextField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                                EmailInputFormatter(),
                              ],
                              validator: (value) =>
                                  Validate.validateEmail(value),
                              controller: controller.emilaController,
                              headerText: 'Email',
                              hintText: "Enter your email address",
                            ),
                            SizedBox(height: 4.h),
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
      ),
    );
  }
}
