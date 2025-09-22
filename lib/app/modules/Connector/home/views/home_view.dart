import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/Connector/home/components/home_components.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:gap/gap.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final CommonController commonController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(
          leadingWidth: 165,
          leading: Container(
            padding: const EdgeInsets.all(7),
            height: 49,
            margin: const EdgeInsets.only(left: 13, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: MyColors.yellow,
              border: Border.all(color: MyColors.black),
            ),
            child: GestureDetector(
              onTap: () {
                // Get.toNamed(Routes.CONNECTOR_ADD_LOCATION);
              },
              child: Row(
                children: [
                  SvgPicture.asset(Asset.connectorSvg, width: 24, height: 24),
                  const Gap(8),
                  Text(
                    "Join As Partner",
                    style: MyTexts.regular14.copyWith(
                      color: Colors.black,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
                  child: Row(
                    children: [
                      Image.asset(Asset.profil, height: 40, width: 40),
                      SizedBox(width: 1.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Vaishnavi!',
                            style: MyTexts.medium16.copyWith(
                              color: MyColors.fontBlack,
                              fontFamily: MyTexts.Roboto,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.MAIN);

                              // // Condition check
                              // if (controller.getCurrentAddress().isNotEmpty) {
                              //   // Navigate to SavedAddressesView
                              //   Get.to(() => const SavedAddressesView());
                              // } else {
                              //   // No address → stay on same screen or show info
                              //   Get.snackbar(
                              //     "No Address",
                              //     "Please add an address first",
                              //     snackPosition: SnackPosition.BOTTOM,
                              //   );
                              // }
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(Asset.location, width: 9, height: 12.22),
                                SizedBox(width: 0.4.h),
                                Text(
                                  "",
                                  style: MyTexts.medium14.copyWith(
                                    color: MyColors.textFieldBackground,
                                    fontFamily: MyTexts.Roboto,
                                  ),
                                ),

                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 16,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: MyColors.grayD4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          // 👈 allows badge to overflow
                          children: [
                            SvgPicture.asset(
                              Asset.notifications,
                              // or 'assets/images/notifications.svg'
                              width: 18,
                              height: 18,
                            ),
                            Positioned(
                              right: 0,
                              top: 3,
                              child: Container(
                                width: 6.19,
                                height: 6.19,
                                decoration: const BoxDecoration(
                                  color: MyColors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 0.8.h),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: MyColors.grayD4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SvgPicture.asset(
                              Asset.warning,
                              width: 18,
                              height: 18,
                              colorFilter: const ColorFilter.mode(
                                Colors.black,
                                BlendMode.srcIn,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 3,
                              child: Container(
                                width: 6.19,
                                height: 6.19,
                                decoration: const BoxDecoration(
                                  color: MyColors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HearderText(text: "Statics"),
                      const Gap(14),
                      SizedBox(
                        height: 93,
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                "Total Partners",
                                "123.4K",
                                Asset.noOfPartner,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard(
                                "Total Products",
                                "123.4K",
                                Asset.noOfConectors,
                              ),
                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: _buildStatCard(
                                "Total Connectors",
                                "250",
                                Asset.noOfUsers,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(14),
                      HearderText(text: "Notification"),
                      const Gap(14),
                      SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildNotiCard(
                                title: "Support Ticket",
                                value: "04",
                                icon: Asset.warning,
                                color: MyColors.redgray,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildNotiCard(
                                title: "Inbox",
                                value: "02",
                                icon: Asset.thumbup,
                                color: MyColors.warning,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(14),
                      HearderText(text: "Quick Access"),
                      const Gap(14),
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: MyColors.gray5D, width: 0.5),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.items.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1.3,
                          ),
                          itemBuilder: (context, index) {
                            final item = controller.items[index];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(item['icon'], height: 28, width: 28),
                                const SizedBox(height: 8),
                                Text(
                                  item['title'],
                                  textAlign: TextAlign.center,
                                  style: MyTexts.regular14.copyWith(
                                    color: MyColors.textFieldBackground,
                                    fontFamily: MyTexts.Roboto,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const Gap(14),
                      Row(
                        children: [
                          HearderText(text: "Merchant Store"),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "View All",
                              style: MyTexts.medium14.copyWith(color: MyColors.gray5D),
                            ),
                          ),
                        ],
                      ),
                      const Gap(14),
                      ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true, // Important for nested scrollables
                        physics:
                            const NeverScrollableScrollPhysics(), // Disables inner scrolling
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: MerchantCard(), // Use your card here
                          );
                        },
                      ),
                      const Gap(14),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required Widget icon, // 👈 change to Widget
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 12),
      child: Container(
        width: 180,
        height: 89,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.grayD4),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                icon,
                SizedBox(width: 0.6.h),
                Text(
                  title,
                  style: MyTexts.medium16.copyWith(
                    color: MyColors.textFieldBackground,

                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.8.h),
            Text(
              value,
              style: MyTexts.extraBold18.copyWith(color: MyColors.textFieldBackground),
            ),

            SizedBox(height: 2.h),

            // Team title row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Team", style: MyTexts.bold18.copyWith(color: MyColors.fontBlack)),
                  Text(
                    "View All",
                    style: MyTexts.medium12.copyWith(color: MyColors.textFieldBackground),
                  ),
                ],
              ),
            ),

            // Team List
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: 3,
              shrinkWrap: true, // Important for nested scrollables
              physics: const NeverScrollableScrollPhysics(), // Disables inner scrolling
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: MerchantCard(), // Use your card here
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.greyE5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // <--- important
        children: [
          SvgPicture.asset(icon, height: 20, width: 20),
          const Gap(6),
          Flexible(
            child: Text(
              title,
              style: MyTexts.regular13.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.Roboto,
              ),
              overflow: TextOverflow.ellipsis, // prevent overflow
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: MyTexts.bold16.copyWith(
                color: MyColors.black,
                fontFamily: MyTexts.Roboto,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotiCard({String? title, String? value, String? icon, Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.greyE5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 4, top: 4),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: (color ?? Colors.black).withValues(alpha: 0.3),
                ),
                child: SvgPicture.asset(
                  icon ?? "",
                  height: 30,
                  width: 30,
                  colorFilter: ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
                ),
              ),
              Container(
                height: 12,
                width: 12,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const Gap(12),

          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "",
                  style: MyTexts.regular13.copyWith(
                    color: MyColors.gray5D,
                    fontFamily: MyTexts.Roboto,
                  ),
                  overflow: TextOverflow.ellipsis, // optional
                ),
                Text(
                  value ?? "",
                  style: MyTexts.bold20.copyWith(
                    color: MyColors.black,
                    fontFamily: MyTexts.Roboto,
                  ),
                  overflow: TextOverflow.ellipsis, // optional
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HearderText extends StatelessWidget {
  String text;

  HearderText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: MyTexts.medium18.copyWith(
        color: MyColors.textFieldBackground,
        fontFamily: MyTexts.Roboto,
      ),
    );
  }
}
