import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:gap/gap.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Asset.categoryBg),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonAppBar(
                backgroundColor: Colors.transparent,
                title: const Text('Subscription'),
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(8),
                        Text(
                          "Available now",
                          style: MyTexts.bold18.copyWith(color: MyColors.black),
                        ),
                        const Gap(16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(Asset.exploreBg),
                              fit: BoxFit.fitHeight,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: MyColors.grayEA),
                          ),
                          child: Column(
                            children: [
                              buildRow(
                                image: Asset.role1,
                                title: "Marketplace",
                                description:
                                    "Connect, browse, and manage construction materials and vendors in one place.",
                              ),
                              const Gap(24),
                              buildRow(
                                image: Asset.crm,
                                title: "CRM",
                                description:
                                    "Manage your client relationships, leads, and communications effortlessly.",
                              ),
                              const Gap(32),
                              RoundedButton(
                                buttonName: "Buy now",
                                onTap: () {
                                  showModalBottomSheet(
                                    context: Get.context!,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return Container(
                                        width: 150,
                                        height: 316,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        child: Center(
                                          child: Image.asset(
                                            Asset.comingSoon,
                                            height: 316,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const Gap(16),
                        Text(
                          "Coming soon",
                          style: MyTexts.bold18.copyWith(
                            color: MyColors.grayA5,
                          ),
                        ),
                        const Gap(16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(Asset.exploreBg),
                              fit: BoxFit.cover,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: MyColors.grayEA),
                          ),
                          child: Column(
                            children: [
                              buildRow(
                                image: Asset.erp,
                                title: "ERP",
                                description:
                                    "Integrated tools for inventory, billing, and operations — all in one system.",
                              ),
                              const Gap(24),
                              buildRow(
                                image: Asset.project,
                                title: "Project Management",
                                description:
                                    "Plan, track, and manage construction projects with real-time collaboration.",
                              ),
                              const Gap(24),
                              buildRow(
                                image: Asset.hrms,
                                title: "HRMS",
                                description:
                                    "Simplify workforce management, payroll, and employee onboarding.",
                              ),
                              const Gap(24),
                              buildRow(
                                image: Asset.portfolio,
                                title: "Portfolio Management",
                                description:
                                    "Centralize and showcase your completed projects, vendor work, and credentials to build trust.",
                              ),
                              const Gap(24),
                              buildRow(
                                image: Asset.ovp,
                                title: "OVP",
                                description:
                                    "Organize and showcase vendor portfolios for better visibility and trust.",
                              ),
                              const Gap(24),
                              buildRow(
                                image: Asset.taxi,
                                title: "Construction Taxi",
                                description:
                                    "Organize and showcase vendor portfolios for better visibility and trust.",
                              ),
                              const Gap(32),
                              RoundedButton(
                                buttonName: "Coming Soon",
                                onTap: () {},
                                color: MyColors.grayCD,
                                fontColor: MyColors.gra54,
                              ),
                            ],
                          ),
                        ),
                        const Gap(32),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildRow({
    required String image,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Image.asset(image, height: 100, width: 100, fit: BoxFit.cover),
        const Gap(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,

                style: MyTexts.bold18.copyWith(color: MyColors.gray2E),
              ),
              const Gap(8),
              Text(
                description,

                style: MyTexts.medium14.copyWith(color: MyColors.gray2E),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
