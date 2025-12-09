import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/menu/menu_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/views/customer_support_view.dart';
import 'package:construction_technect/app/modules/vrm/more/controller/more_controller.dart';

class VrmMoreScreen extends GetView<VrmMoreController> {
  const VrmMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: const CommonAppBar(
        isCenter: false,
        leading: SizedBox(),
        leadingWidth: 0,
        title: Text("More"),
      ),
      body: SingleChildScrollView(
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
                  Get.toNamed(Routes.PROFILE);
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
                icon: Asset.notification,
                title: "Notification",
                onTap: () {
                  Get.toNamed(Routes.VRM_NOTIFICATION);
                },
              ),
              const Gap(16),
              CommonContainer(
                icon: Asset.location,
                title: "Delivery location",
                onTap: () {
                  Get.toNamed(Routes.DELIVERY_LOCATION);
                },
              ),
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
                icon: Asset.privacy,
                title: "Privacy Policy",
                onTap: () => openUrl(url: Constants.privacyPolicy),
              ),
              const Gap(16),
              CommonContainer(
                icon: Asset.tc,
                title: "Terms & conditions",
                onTap: () => openUrl(url: Constants.termsCondition),
              ),
              const Gap(16),
              CommonContainer(
                icon: Asset.message,
                title: "Feedback",
                onTap: () {
                  Get.toNamed(Routes.FEEDBACK_VIEW);
                },
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
