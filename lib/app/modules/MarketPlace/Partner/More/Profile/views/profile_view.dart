import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/certifications_component.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/info_metrics_component.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:gap/gap.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Stack(
        children: [
          const CommonBgImage(),
          Column(
            children: [
              CommonAppBar(
                backgroundColor: Colors.transparent,
                title: const Text('Profile summary view'),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // _buildProfileBanner(),
                    SizedBox(height: 1.h),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: MyColors.grayF7,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      child: Obx(() {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                controller.selectedTabIndex.value = 0,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(
                                      alpha:
                                      controller.selectedTabIndex.value == 0
                                          ? 1
                                          : 0,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 16,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Info & Metrics",
                                        style: MyTexts.medium15.copyWith(
                                          color: MyColors.gray2E,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(10),
                              GestureDetector(
                                onTap: () =>
                                controller.selectedTabIndex.value = 1,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(
                                      alpha:
                                      controller.selectedTabIndex.value == 1
                                          ? 1
                                          : 0,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 16,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Certification",
                                        style: MyTexts.medium15.copyWith(
                                          color: MyColors.gray2E,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // const Gap(10),
                              // Obx(() {
                              //   return controller.profileCompletionPercentage >
                              //           90
                              //       ? GestureDetector(
                              //           onTap: () =>
                              //               controller.selectedTabIndex.value =
                              //                   2,
                              //           child: AnimatedContainer(
                              //             duration: const Duration(
                              //               milliseconds: 250,
                              //             ),
                              //             curve: Curves.easeInOut,
                              //             decoration: BoxDecoration(
                              //               color: Colors.white.withValues(
                              //                 alpha:
                              //                     controller
                              //                             .selectedTabIndex
                              //                             .value ==
                              //                         2
                              //                     ? 1
                              //                     : 0,
                              //               ),
                              //               borderRadius: BorderRadius.circular(
                              //                 24,
                              //               ),
                              //             ),
                              //             child: Padding(
                              //               padding: const EdgeInsets.symmetric(
                              //                 vertical: 4,
                              //                 horizontal: 16,
                              //               ),
                              //               child: Center(
                              //                 child: Text(
                              //                   "Marketplace Performance",
                              //                   style: MyTexts.medium15
                              //                       .copyWith(
                              //                         color: MyColors.gray2E,
                              //                       ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         )
                              //       : const SizedBox();
                              // }),
                            ],
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 1.h),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _buildTabContent(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Obx(() {
          return RoundedButton(
            buttonName: controller.selectedTabIndex.value == 0
                ? "Continue"
                : "Save",
            onTap: () {
              if (controller.selectedTabIndex.value == 0) {
                if ((controller.businessModel.value.businessEmail ?? "")
                    .isEmpty) {
                  SnackBars.errorSnackBar(
                    content: "Please fill business metrics",
                  );
                } else if (controller.businessHoursData.isEmpty) {
                  SnackBars.errorSnackBar(
                      content: "Please fill business hours");
                } else {
                  controller.selectedTabIndex.value = 1;
                }
              } else {
                for (final cert in controller.certificates) {
                  if (cert.isDefault &&
                      (cert.filePath == null || cert.filePath!.isEmpty)) {
                    SnackBars.errorSnackBar(
                      content: "Please upload all relevant certificates",
                    );
                    return;
                  }
                }
                controller.handleMerchantData();
              }
            },
          );
        }),
      ),
    );
  }

  Widget _buildTabContent() {
    return Obx(() {
      final index = controller.selectedTabIndex.value;
      // final hasMarketplaceTab = controller.profileCompletionPercentage > 90;
      Widget content;

      if (index == 0) {
        content = const InfoMetricsComponent();
      } else if (index == 1) {
        content = const CertificationsComponent(isDelete: true);
      }
      // else if (index == 2 && hasMarketplaceTab) {
      //   content = const MarketplacePerformanceComponent();
      // }
      else {
        content = const InfoMetricsComponent();
      }

      return SingleChildScrollView(child: content);
    });
  }
}
