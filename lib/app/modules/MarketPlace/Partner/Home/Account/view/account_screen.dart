import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/Account/controller/account_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/menu/menu_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/views/customer_support_view.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({super.key});

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
                title: const Text('Profile'),
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
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(1.h),
                      CommonContainer(
                        icon: Asset.person,
                        title: "My Account",
                        onTap: () {

                          if (myPref.getIsTeamLogin() == false){
                            if (myPref.role.val == "connector".toLowerCase()) {
                              Get.toNamed(Routes.CONNECTOR_PROFILE);
                            } else {
                              Get.toNamed(Routes.PROFILE);
                            }
                          }
                          else{
                            Get.toNamed(Routes.TEAM_EDIT);
                          }
                        },
                      ),
                      const Gap(16),
                      CommonContainer(
                        icon: Asset.cs,
                        title: "Customer support",
                        onTap: () {
                          Get.to(() => CustomerSupportView());
                        },
                      ),
                      const Gap(16),
                      CommonContainer(
                        icon: Asset.tutorial,
                        title: "Tutorials",
                        onTap: () {
                          openUrl(
                            url: Constants.tutorial,
                          );
                        },
                      ),
                      const Gap(16),
                      CommonContainer(
                        icon: Asset.notification,
                        title: "Notification",
                        onTap: () {
                          Get.toNamed(Routes.NOTIFICATIONS);
                        },
                      ),
                      if (myPref.getIsTeamLogin() == false)...[
                        const Gap(16),
                        CommonContainer(
                          icon: Asset.location,
                          title: myPref.role.val == "connector"
                              ? "Delivery location"
                              : "Manufacturer Address",
                          onTap: () {
                            if (myPref.role.val == "partner") {
                              Get.toNamed(Routes.MANUFACTURER_ADDRESS);
                            } else {
                              Get.toNamed(Routes.DELIVERY_LOCATION);
                            }
                          },
                        ),
                      ],

                      const Gap(16),
                      CommonContainer(
                        icon: Asset.faq,
                        title: "F.A.Q’S",
                        onTap: () {
                          Get.toNamed(Routes.FAQ);
                        },
                      ),
                      const Gap(16),
                      CommonContainer(
                        icon: Asset.feedback,
                        title: "Feedback",
                        onTap: () {
                          Get.toNamed(Routes.FEEDBACK_VIEW);
                        },
                      ),
                      const Gap(16),
                      CommonContainer(
                        icon: Asset.privacy,
                        title: "Privacy Policy",
                        onTap: () {
                          openUrl(url: Constants.privacyPolicy);
                        },
                      ),
                      const Gap(16),
                      CommonContainer(
                        icon: Asset.tc,
                        title: "Terms & conditions",
                        onTap: () {
                          openUrl(url: Constants.termsCondition);
                        },
                      ),
                      const Gap(16),
                      CommonContainer(
                        icon: Asset.info,
                        title: "About Us",
                        onTap: () {
                          openUrl(url: Constants.aboutUS);
                        },
                      ),
                      const Gap(16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
