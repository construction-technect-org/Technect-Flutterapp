import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/sales/controller/sales_controller.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/sales/widget/sale_lead_screen.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/sales/widget/sale_segment_filters_widget.dart';

class SalesScreen extends GetView<SalesController> {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(Asset.categoryBg), fit: BoxFit.cover),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAppBar(
                    backgroundColor: Colors.transparent,
                    isCenter: false,
                    title: const Text("Sales"),
                    leading: GestureDetector(
                      onTap: Get.back,
                      child: const Padding(
                        padding: EdgeInsets.zero,
                        child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 20),
                      ),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.find<CRMBottomController>().changeTab(2);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            border: Border.all(color: MyColors.custom('EAEAEA')),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            Asset.chat,
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(MyColors.black, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      const Gap(10),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.NEWS);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            border: Border.all(color: MyColors.custom('EAEAEA')),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            Asset.info,
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(MyColors.black, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      const Gap(10),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.NOTIFICATIONS);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            border: Border.all(color: MyColors.custom('EAEAEA')),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(Asset.notification, width: 24, height: 24),
                        ),
                      ),
                      const Gap(10),
                    ],
                  ),
                  // const TopBarHeader(),
                  const SaleSegmentFiltersWidget(),
                  Expanded(
                    child: RefreshIndicator(
                      backgroundColor: MyColors.primary,
                      color: Colors.white,
                      onRefresh: () async {
                        await controller.fetchAllLead(isLoad: true);
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                          child: Obx(() {
                            return controller.filterScreens[controller.activeFilter.value] ??
                                const SaleLeadScreen();
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
