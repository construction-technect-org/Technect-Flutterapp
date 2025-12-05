import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/vrm/marketing/widget/lead_screen.dart';
import 'package:construction_technect/app/modules/vrm/marketing/widget/segment_filters_widget.dart';

class MarketingScreen extends GetView<MarketingController> {
  const MarketingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MarketingController c = controller;
    return LoaderWrapper(
      isLoading: c.isLoading,
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
                    title: Text(c.isMarketing.value ? "Marketing" : "Sales"),
                    leading: GestureDetector(
                      onTap: Get.back,
                      child: const Padding(
                        padding: EdgeInsets.zero,
                        child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 20),
                      ),
                    ),
                  ),
                  // const TopBarHeader(),
                  const SegmentFiltersWidget(),
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
                            return c.filterScreens[c.activeFilter.value] ?? const LeadScreen();
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
