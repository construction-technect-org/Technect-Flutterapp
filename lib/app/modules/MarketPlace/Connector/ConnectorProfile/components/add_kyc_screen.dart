import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/controllers/connector_profile_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';

class AddKycScreen extends StatelessWidget {
  AddKycScreen({super.key});

  final controller = Get.find<ConnectorProfileController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: RoundedButton(
            buttonName: 'Update',
            onTap: () {
              if (controller.isVerified.value) {
                controller.proceedKyc();
              }
            },
          ),
        ),
        body: Stack(
          children: [
            const CommonBgImage(),
            Column(
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text('KYC Detail'),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(20),
                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.grayEA.withValues(alpha: 0.32),
                              blurRadius: 4,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: MyColors.grayEA.withValues(alpha: 0.32),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 13,
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextField(
                              headerText: "KYC",
                              hintText: "Enter your Aadhaar card",
                              controller: controller.aadhaarController,
                              suffixPadding: 0,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  final value = controller
                                      .aadhaarController
                                      .text
                                      .trim();
                                  if (value.isEmpty) {
                                    SnackBars.errorSnackBar(
                                      content: "Please enter Aadhaar number",
                                    );
                                    controller.isVerified.value = false;
                                    return;
                                  } else if (value.length != 12) {
                                    SnackBars.errorSnackBar(
                                      content:
                                          "Aadhaar number must be exactly 12 digits",
                                    );
                                    controller.isVerified.value = false;
                                    return;
                                  }
                                  controller.isVerified.value = true;
                                  SnackBars.successSnackBar(
                                    content: "Aadhaar verified successfully!",
                                  );
                                },
                                child: Container(
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    color: MyColors.primary,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Verify",
                                      style: MyTexts.medium16.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter Aadhaar number";
                                }
                                if (value.trim().length != 12) {
                                  return "Aadhaar number must be exactly 12 digits";
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(12),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Obx(() {
                              if (!controller.isVerified.value) {
                                return const SizedBox.shrink();
                              }
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: MyColors.grayE6),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: MyColors.grayE6,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          topLeft: Radius.circular(12),
                                        ),
                                      ),
                                      child: Align(
                                        alignment: AlignmentGeometry.topLeft,
                                        child: Text(
                                          "Aadhaar card details",
                                          style: MyTexts.medium13.copyWith(
                                            color: MyColors.gray2E,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Aadhaar number ",
                                            style: MyTexts.medium13.copyWith(
                                              color: MyColors.dustyGray,
                                            ),
                                          ),
                                          const Gap(4),
                                          Text(
                                            controller.aadhaarController.text,
                                            style: MyTexts.medium16.copyWith(
                                              color: MyColors.black,
                                            ),
                                          ),

                                          const Gap(12),
                                          Text(
                                            "Address",
                                            style: MyTexts.medium13.copyWith(
                                              color: MyColors.dustyGray,
                                            ),
                                          ),
                                          const Gap(4),
                                          Text(
                                            "Flat No. 305, Block B, Prestige Lakeview Apartments",
                                            style: MyTexts.medium16.copyWith(
                                              color: MyColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            SizedBox(height: 2.h),
                          ],
                        ),
                      ),
                    ],
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
