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
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: MyColors.tertiary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  _buildRoleBanner(context).paddingSymmetric(horizontal: 32),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Features", style: MyTexts.extraBold18.copyWith(color: MyColors.black)),
                  const Gap(12),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final double itemWidth = (constraints.maxWidth - (2 * 10)) / 3;
                      final double itemHeight = itemWidth + 5; // Increased to prevent text overflow

                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.features.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 20,
                          childAspectRatio: itemWidth / itemHeight,
                        ),
                        itemBuilder: (context, index) {
                          final item = controller.features[index];
                          return Obx(() {
                            final isSelected = controller.selectedIndex.value == index;
                            return BuildFeatureCard(
                              isSelected: isSelected,
                              item: item,
                              onTap: () {
                                if (item["available"] == true) {
                                  final index = controller.features.indexOf(item);
                                  if (controller.selectedIndex.value != index) {
                                    controller.selectedIndex.value = index;
                                    myPref.dashboard.val = item["value"].toString();
                                    controller.onFeatureTap(item["value"].toString());
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
                  /* SizedBox(height: 2.h),
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
                  ), */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleBanner(BuildContext context) {
    final role = myPref.getRole();
    final isConnector = role == "connector";
    final title = isConnector ? "Connectors" : "Merchants";
    final illustration = isConnector ? Asset.conn : Asset.mer;

    return Container(
      width: double.infinity,
      height: 100, // Slightly increased for comfort
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3466D1), MyColors.primary],
        ),
        image: DecorationImage(image: AssetImage(Asset.maps), fit: BoxFit.cover, opacity: 0.15),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: MyTexts.bold20.copyWith(color: MyColors.white)),
                Text(
                  "Connect. Collaborate. Succeed",
                  style: MyTexts.medium14.copyWith(color: MyColors.white.withAlpha(180)),
                ),
                // const Spacer(),
                SizedBox(height: 0.7.h),
                Text(
                  "100+",
                  style: MyTexts.bold24.copyWith(
                    color: const Color.fromARGB(255, 250, 240, 143),
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 24,
            bottom: 32,
            top: 16,
            child: Image.asset(illustration, fit: BoxFit.contain),
          ),
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 4,
                  decoration: BoxDecoration(
                    color: MyColors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 20,
                  height: 4,
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* Widget _buildStatCard(String title, String value, String type, String icon) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = MediaQuery.of(context).size.width;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, // responsive padding
            vertical: screenWidth * 0.03,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFCCCCCC)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// LEFT SIDE
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenWidth * 0.015),

                    /// TITLE
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                    ),

                    /// TYPE
                    Text(
                      type,
                      style: MyTexts.regular12.copyWith(
                        color: const Color(0xFF058200),
                        fontSize: screenWidth * 0.025, // responsive font
                      ),
                    ),

                    SizedBox(height: screenWidth * 0.04),

                    /// CIRCLE VALUE
                    Container(
                      width: screenWidth * 0.09,
                      height: screenWidth * 0.1,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x00FFED29), Color(0xFFFFED29)],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "32", // now dynamic
                          style: MyTexts.medium14.copyWith(
                            color: const Color(0xFF2E2E2E),
                            fontSize: screenWidth * 0.03,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: screenWidth * 0.03),

              /// RIGHT IMAGE
              Flexible(
                flex: 2,
                child: AspectRatio(
                  aspectRatio: 0.6, // keeps image proportion stable
                  child: Image.asset(icon, fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        );
      },
    );
  } */
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
      "title": "Construction \n Taxi",
      "icon": Asset.taxi,
      "available": false,
      "value": "construction_taxi",
    },
    {"title": "VDC", "icon": Asset.vdc, "available": false, "value": "vdc"},
  ];
  final RxInt selectedIndex = 20.obs;

  void onFeatureTap(String value) {
    final savedValue = myPref.dashboard.val;

    final index = features.indexWhere((feature) => feature['value'] == savedValue);
    if (index != -1) {
      selectedIndex.value = index;
    } else {
      selectedIndex.value = 0;
    }
    switch (value) {
      case "marketplace":
        Get.offAllNamed(Routes.MAIN);
        break;
      case "crm":
        Get.offAllNamed(Routes.CRM_MAIN);
        break;
      default:
        Get.snackbar("Coming Soon", "This feature is not yet available");
        break;
    }
  }

  void onSecondScreenTap(String value) {
    final savedValue = myPref.dashboard.val;

    final index = features.indexWhere((feature) => feature['value'] == savedValue);
    if (index != -1) {
      selectedIndex.value = index;
    } else {
      selectedIndex.value = 0;
    }
    switch (value) {
      case "marketplace":
        Get.lazyPut(() => BottomController());
        Get.find<BottomController>().currentIndex.value = 1;
        break;
      case "crm":
        Get.find<CommonController>().switchToCrmMain();
        break;
      default:
        Get.snackbar("Coming Soon", "This feature is not yet available");
        break;
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
              borderRadius: BorderRadius.circular(16),
              border: isSelected ? Border.all(color: MyColors.primary) : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [MyColors.tertiary, MyColors.tertiary],
                // colors: [MyColors.tertiary, Color(0xFFFFFFFF)],
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
                Image.asset(item['icon'].toString(), height: 5.h),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    item["title"].toString(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                  ),
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
