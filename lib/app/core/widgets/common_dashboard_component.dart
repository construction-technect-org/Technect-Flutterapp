import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/bottom/controllers/bottom_controller.dart';

class CommonDashboard extends StatelessWidget {
  CommonDashboard({super.key});
  final CommonDashboardController controller = Get.put(CommonDashboardController());
  final CommonController commonController = Get.find<CommonController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Features", style: MyTexts.extraBold18.copyWith(color: MyColors.black)),
            const Gap(16),
            LayoutBuilder(
              builder: (context, constraints) {
                final double itemWidth = (constraints.maxWidth - (2 * 10)) / 3;
                final double itemHeight = itemWidth + 10;
                return GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.features.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 17,
                    childAspectRatio: itemWidth / itemHeight,
                  ),
                  itemBuilder: (context, index) {
                    final item = controller.features[index];
                    return Obx(() {
                      final isSelected = controller.selectedIndex.value == index;
                      return BuildFeatureCard(
                        isSelected: isSelected,
                        item: item,
                        itemWidth: itemWidth,
                        onTap: () {
                          if (item["available"] == true) {
                            final index = controller.features.indexOf(item);
                            if (controller.selectedIndex.value != index) {
                              controller.selectedIndex.value = index;
                              myPref.dashboard.val = item["value"].toString();
                              controller.onFeatureTap(item["value"].toString());
                              const Duration(seconds: 1);
                            }

                            controller.onSecondScreenTap(item["value"].toString());
                          }
                        },
                      );
                    });
                  },
                );
              },
            ),
            SizedBox(height: 1.h),
            SizedBox(height: 1.h),
            Text("Statics", style: MyTexts.bold18.copyWith(color: MyColors.black)),
            SizedBox(height: 1.h),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Merchant",
                    commonController
                            .profileData
                            .value
                            .data
                            ?.statistics
                            ?.totalMerchantProfilesCreated
                            ?.toString() ??
                        "0",
                    Asset.role1,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    "Connectors",
                    commonController
                            .profileData
                            .value
                            .data
                            ?.statistics
                            ?.totalConnectorProfilesCreated
                            ?.toString() ??
                        "0",
                    Asset.contractor,
                  ),
                ),
              ],
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFFFDEA)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Image.asset(icon, height: 31, width: 31),
                const Gap(7),
                Text(title, style: MyTexts.medium14.copyWith(color: MyColors.fontBlack)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDEA),
              border: Border.all(color: const Color(0xFFFFFDEA)),
              borderRadius: BorderRadius.circular(43),
            ),
            child: Text(value, style: MyTexts.bold18.copyWith(color: MyColors.primary)),
          ),
        ],
      ),
    );
  }
}

class CommonDashboardController extends GetxController {
  final features = [
    {"title": "Marketplace", "icon": Asset.role1, "available": true, "value": "marketplace"},
    {"title": "CRM", "icon": Asset.crm, "available": true, "value": "crm"},
    {"title": "ERP", "icon": Asset.erp, "available": false, "value": "erp"},
    {
      "title": "Project Management",
      "icon": Asset.project,
      "available": false,
      "value": "project_management",
    },
    {"title": "HRMS", "icon": Asset.hrms, "available": false, "value": "hrms"},
    {
      "title": "Portfolio Management",
      "icon": Asset.portfolio,
      "available": false,
      "value": "portfolio_management",
    },
    {"title": "OVP", "icon": Asset.ovp, "available": false, "value": "ovp"},
    {
      "title": "Construction Taxi",
      "icon": Asset.taxi,
      "available": false,
      "value": "construction_taxi",
    },
  ];
  final RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final savedValue = myPref.dashboard.val;

    final index = features.indexWhere((feature) => feature['value'] == savedValue);

    if (index != -1) {
      selectedIndex.value = index;
    } else {
      selectedIndex.value = 0;
    }
  }

  void onFeatureTap(String value) {
    switch (value) {
      case "marketplace":
        Get.offAllNamed(Routes.MAIN);
      case "crm":
        Get.offAllNamed(Routes.CRM_MAIN);
      default:
        Get.snackbar("Coming Soon", "This feature is not yet available");
    }
  }

  void onSecondScreenTap(String value) {
    switch (value) {
      case "marketplace":
        Get.lazyPut(() => BottomController());
        Get.find<BottomController>().currentIndex.value = 1;
      case "crm":
        Get.find<CommonController>().switchToCrmMain();
      default:
        Get.snackbar("Coming Soon", "This feature is not yet available");
    }
  }
}

class BuildFeatureCard extends StatelessWidget {
  const BuildFeatureCard({
    required this.isSelected,
    required this.item,
    required this.itemWidth,
    required this.onTap,
  });

  final bool isSelected;
  final Map<String, Object> item;
  final double itemWidth;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: AlignmentGeometry.topRight,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: isSelected ? null : BoxBorder.all(width: 2, color: MyColors.grayEA),
              gradient: isSelected
                  ? LinearGradient(
                      begin: AlignmentGeometry.topCenter,
                      end: AlignmentGeometry.bottomCenter,
                      colors: [
                        const Color(0xFFE9EBF8).withValues(alpha: 0),
                        const Color(0xFFE9EBF8),
                      ],
                    )
                  : null,
            ),
            child: Column(
              children: [
                if (item["available"] == false)
                  Align(
                    alignment: AlignmentGeometry.topRight,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                      decoration: const BoxDecoration(
                        color: MyColors.grayEA,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        "Coming Soon",
                        style: MyTexts.medium13.copyWith(color: MyColors.gray2E),
                      ),
                    ),
                  ),
                const Spacer(),
                Image.asset(item['icon'].toString(), height: itemWidth * 0.50),
                const SizedBox(height: 6),
                Text(
                  item["title"].toString(),
                  textAlign: TextAlign.center,
                  style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                ),
                const Spacer(),
              ],
            ),
          ),
          if (isSelected) const Icon(Icons.check_circle_rounded, color: MyColors.primary, size: 20),
        ],
      ),
    );
  }
}
