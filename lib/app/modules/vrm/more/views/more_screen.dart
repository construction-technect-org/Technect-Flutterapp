import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/menu/menu_view.dart';
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
                icon: Asset.inbox,
                title: "Inbox",
                onTap: () {
                  Get.toNamed(Routes.CRM_INBOX);
                },
              ),

              const Gap(16),
              CommonContainer(
                icon: Asset.report,
                title: "Report",
                onTap: () {
                  // Get.toNamed(Routes.REPORT, arguments: {"isReport": true});
                },
              ),
              const Gap(16),
              CommonContainer(
                icon: Asset.analysis,
                title: "Analysis",
                onTap: () => Get.toNamed(Routes.CrmAnalysis),
              ),
              const Gap(16),
              CommonContainer(
                icon: Asset.setting,
                title: "Setting",
                onTap: () => Get.toNamed(Routes.SETTING),
              ),
              const Gap(16),
              CommonContainer(
                icon: Asset.team,
                title: "Team",
                onTap: () => Get.toNamed(Routes.ROLE_MANAGEMENT),
              ),
              const Gap(16),
              CommonContainer(icon: Asset.news, title: "Task", onTap: () {}), //todo
              const Gap(16),
              CommonContainer(
                icon: Asset.news,
                title: "News",
                onTap: () => Get.toNamed(Routes.NEWS),
              ),
              const Gap(16),
              CommonContainer(
                icon: Asset.refer,
                title: "Refer & Earn",
                onTap: () => Get.toNamed(Routes.REFER_EARN),
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
