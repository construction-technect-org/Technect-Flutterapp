import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/bottom/controllers/bottom_controller.dart';

class CommonDashboard extends StatelessWidget {
  CommonDashboard({super.key});
  final CommonDashboardController controller = Get.put(
    CommonDashboardController(),
  );
  final CommonController commonController = Get.find<CommonController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Features",
              style: MyTexts.extraBold18.copyWith(color: MyColors.black),
            ),
            const Gap(12),
            LayoutBuilder(
              builder: (context, constraints) {
                final isTablet = constraints.maxWidth >= 550;
                print("Con ${constraints.maxWidth}, $isTablet");
                const crossAxisCount = 3;
                const spacing = 8.0;

                // 1️⃣ Total spacing
                const totalSpacing = spacing * (crossAxisCount - 1);

                // 2️⃣ Item width
                final itemWidth =
                    (constraints.maxWidth - totalSpacing) / crossAxisCount;

                // 3️⃣ Responsive height (based on width)
                final itemHeight = itemWidth * 1.3; // 👈 tweak ratio here

                // 4️⃣ Aspect ratio
                final childAspectRatio = itemWidth / itemHeight;
                //final double itemWidth = (constraints.maxWidth - (2 * 10)) / 3;
                //final double itemHeight = itemWidth + 10;
                return GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.features.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: isTablet ? 16 : 16,
                    mainAxisSpacing: isTablet ? 4 : 16,
                    childAspectRatio: isTablet ? .99 : .88,
                  ),
                  itemBuilder: (context, index) {
                    final item = controller.features[index];
                    return Obx(() {
                      final isSelected =
                          controller.selectedIndex.value == index;
                      return BuildFeatureCard(
                        isSelected: isSelected,
                        item: item,
                        //itemWidth: itemWidth,
                        onTap: () {
                          if (item["available"] == true) {
                            final index = controller.features.indexOf(item);
                            if (controller.selectedIndex.value != index) {
                              controller.selectedIndex.value = index;
                              myPref.dashboard.val = item["value"].toString();
                              controller.onFeatureTap(item["value"].toString());
                              const Duration(seconds: 1);
                            }

                            controller.onSecondScreenTap(
                              item["value"].toString(),
                            );
                          }
                        },
                      );
                    });
                  },
                );
              },
            ),

            //SizedBox(height: 1.h),
            /*Text(
              "Statics",
              style: MyTexts.bold18.copyWith(color: MyColors.black),
            ), */
            SizedBox(height: 2.h),
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
                    "Verified",
                    Asset.mer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    "Connector",
                    commonController
                            .profileData
                            .value
                            .data
                            ?.statistics
                            ?.totalConnectorProfilesCreated
                            ?.toString() ??
                        "0",
                    "Active",
                    Asset.conn,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String type, String icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCCCCCC), width: 1.0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                //Image.asset(icon, height: 31, width: 31),
                const Gap(7),
                Text(
                  title,
                  style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                ),
                Text(
                  type,
                  style: MyTexts.regular12.copyWith(
                    color: const Color(0xFF058200),
                    fontSize: 10,
                  ),
                ),
                const Gap(16),
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0x00FFED29),
                        const Color(0xFFFFED29),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "32",
                      style: MyTexts.medium14.copyWith(
                        color: const Color(0xFF2E2E2E),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 100,
            width: 60,
            child: Image.asset(icon, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}

class CommonDashboardController extends GetxController {
  final features = [
    {
      "title": "Marketplace",
      "icon": Asset.role1,
      "available": true,
      "value": "marketplace",
    },
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
    {"title": "VDC", "icon": Asset.vdc, "available": false, "value": "vdc"},
  ];
  final RxInt selectedIndex = 20.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onFeatureTap(String value) {
    final savedValue = myPref.dashboard.val;

    final index = features.indexWhere(
      (feature) => feature['value'] == savedValue,
    );
    if (index != -1) {
      selectedIndex.value = index;
    } else {
      selectedIndex.value = 0;
    }
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
    final savedValue = myPref.dashboard.val;

    final index = features.indexWhere(
      (feature) => feature['value'] == savedValue,
    );
    if (index != -1) {
      selectedIndex.value = index;
    } else {
      selectedIndex.value = 0;
    }
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
    //required this.itemWidth,
    required this.onTap,
  });

  final bool isSelected;
  final Map<String, Object> item;
  //final double itemWidth;
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
              border: isSelected
                  ? BoxBorder.all(width: 1, color: MyColors.primary)
                  : null,
              gradient: const LinearGradient(
                begin: AlignmentGeometry.topCenter,
                end: AlignmentGeometry.bottomCenter,
                colors: [Color(0xFFFFFCDF), Color(0xFFFFFFFF)],
              ),
            ),
            child: Column(
              children: [
                /* if (item["available"] == false)
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
                        style: MyTexts.medium13.copyWith(
                          color: MyColors.gray2E,
                        ),
                      ),
                    ),
                  ), */
                const Spacer(),
                Image.asset(item['icon'].toString(), height: 6.h),
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
          /* if (isSelected)
            const Icon(
              Icons.check_circle_rounded,
              color: MyColors.primary,
              size: 20,
            ), */
        ],
      ),
    );
  }
}
