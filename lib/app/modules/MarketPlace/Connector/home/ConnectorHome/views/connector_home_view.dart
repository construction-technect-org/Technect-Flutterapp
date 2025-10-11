import 'dart:io';

import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/home/ConnectorHome/components/connector_home_components.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/home/ConnectorHome/controllers/connector_home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/components/coming_soon_dialog.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/AddressModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/views/home_view.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';

class ConnectorHomeView extends StatelessWidget {
  final ConnectorHomeController controller = Get.put(ConnectorHomeController());
  final CommonController commonController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        // appBar: CommonAppBar(
        //   leadingWidth: 190,
        //   leading: Container(
        //     padding: const EdgeInsets.all(7),
        //     height: 49,
        //     margin: const EdgeInsets.only(left: 13, top: 10),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(12),
        //       color: MyColors.yellow,
        //       border: Border.all(color: MyColors.black),
        //     ),
        //     child: GestureDetector(
        //       onTap: () {
        //         Get.toNamed(Routes.MAIN);
        //       },
        //       child: Row(
        //         children: [
        //           SvgPicture.asset(Asset.connectorSvg, width: 24, height: 24),
        //           const Gap(8),
        //           Text(
        //             "Join As Partner",
        //             style: MyTexts.regular14.copyWith(
        //               color: Colors.black,
        //               fontFamily: MyTexts.Roboto,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.h),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 0,
              ),
              child: Row(
                children: [
                  Obx(() {
                    return (controller.profileData.value.data?.user?.image ??
                                "")
                            .isEmpty
                        ? Image.asset(Asset.profil, height: 50, width: 50)
                        : ClipOval(
                            child: getImageView(
                              finalUrl:
                                  "${APIConstants.bucketUrl}${controller.profileData.value.data?.user?.image ?? ""}",
                              fit: BoxFit.cover,
                              height: 50,
                              width: 50,
                            ),
                          );
                  }),
                  SizedBox(width: 1.h),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            'Welcome ${(controller.profileData.value.data?.user?.firstName ?? "").capitalizeFirst} ${(controller.profileData.value.data?.user?.lastName ?? "").capitalizeFirst}!',
                            style: MyTexts.medium16.copyWith(
                              color: MyColors.fontBlack,
                              fontFamily: MyTexts.Roboto,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            final addresses =
                                controller.addressData.data?.addresses ?? [];

                            if (addresses.isEmpty) {
                              Get.snackbar(
                                "No Address",
                                "Please add an address first",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return;
                            }

                            final officeAddress = addresses.firstWhere(
                              (a) => a.addressType?.toLowerCase() == 'office',
                              orElse: () => Address(),
                            );

                            final factoryAddress = addresses.firstWhere(
                              (a) => a.addressType?.toLowerCase() == 'factory',
                              orElse: () => Address(),
                            );

                            showModalBottomSheet(
                              context: Get.context!,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              backgroundColor: Colors.white,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(
                                      context,
                                    ).viewInsets.bottom,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Select Address",
                                          style: MyTexts.extraBold18.copyWith(
                                            color: MyColors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        IntrinsicHeight(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Expanded(
                                                child:
                                                    officeAddress.addressType !=
                                                        null
                                                    ? _addressCard(
                                                        address: officeAddress,
                                                        addressType:
                                                            officeAddress
                                                                .addressType,
                                                        isSelected:
                                                            controller
                                                                .isDefaultOffice
                                                                .value ==
                                                            true,
                                                      )
                                                    : Container(),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child:
                                                    factoryAddress
                                                            .addressType !=
                                                        null
                                                    ? _addressCard(
                                                        address: factoryAddress,
                                                        addressType:
                                                            factoryAddress
                                                                .addressType,
                                                        isSelected:
                                                            controller
                                                                .isDefaultOffice
                                                                .value ==
                                                            false,
                                                      )
                                                    : Container(),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Asset.location,
                                width: 9,
                                height: 12.22,
                              ),
                              SizedBox(width: 0.4.h),
                              Expanded(
                                child: Obx(() {
                                  return RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    text: TextSpan(
                                      style: MyTexts.medium14.copyWith(
                                        color: MyColors.textFieldBackground,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: controller
                                              .getCurrentAddress()
                                              .value,
                                        ),
                                        const WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 4),
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 16,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),

                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.NOTIFICATIONS);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.grayD4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SvgPicture.asset(
                            Asset.notifications,
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
                  ),
                  SizedBox(width: 0.8.h),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.NEWS);
                    },
                    child: Container(
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
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: HeaderText(text: "Features"),
                      ),
                      SizedBox(height: 1.h),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shrinkWrap: true,
                          itemCount: controller.features.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final item = controller.features[index];
                            return Obx(() {
                              final isSelected =
                                  controller.selectedIndex.value == index;
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: index == 0 ? 0 : 16.0,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    // if(isSelected){
                                    if (index == 0) {
                                      controller.selectedIndex.value = index;
                                    } else {
                                      SnackBars.successSnackBar(
                                        content: 'This feature will come soon',
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: 120,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isSelected
                                            ? MyColors.primary
                                            : MyColors.grayD4,
                                      ),
                                      color: isSelected
                                          ? MyColors.yellow
                                          : MyColors.greyE5,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          color: isSelected
                                              ? MyColors.primary
                                              : MyColors.grey,

                                          item['icon']!,
                                          width: 40,
                                          fit: BoxFit.cover,
                                          height: 40,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          item["title"]!,
                                          textAlign: TextAlign.center,
                                          style: MyTexts.medium13.copyWith(
                                            color: MyColors.fontBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 2.h),
                              HearderText(text: "Statics"),
                            const Gap(14),
                            Obx(
                              () => Row(
                                children: [
                                  Expanded(
                                    child: StaticsCard(
                                      title: "Total Partners",
                                      value:
                                          (controller
                                                      .dashboardData
                                                      .value
                                                      .data
                                                      ?.totalPartnerProfiles ??
                                                  0)
                                              .toString(),
                                      icon: Asset.noOfPartner,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: StaticsCard(
                                      title: "Total Products",
                                      value:
                                          (controller
                                                      .dashboardData
                                                      .value
                                                      .data
                                                      ?.totalProducts ??
                                                  0)
                                              .toString(),

                                      icon: Asset.noOfConectors,
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: StaticsCard(
                                      title: "Total Connectors",
                                      value:
                                          (controller
                                                      .dashboardData
                                                      .value
                                                      .data
                                                      ?.totalConnectorProfiles ??
                                                  0)
                                              .toString(),

                                      icon: Asset.noOfUsers,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(14),
                            HeaderText(text: "Quick Access"),
                            const Gap(14),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: MyColors.gray5D,
                                  width: 0.5,
                                ),
                              ),
                              child: SizedBox(
                                height: 200,
                                child: Center(
                                  child: GridView.builder(
                                    padding: const EdgeInsets.all(16),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller.items.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 20,
                                          crossAxisSpacing: 12,
                                          mainAxisExtent: 70,
                                        ),
                                    itemBuilder: (context, index) {
                                      final item = controller.items[index];
                                      return Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            if (index == 0) {
                                              Get.toNamed(
                                                Routes.APPROVAL_INBOX,
                                                arguments: {"isInbox": true},
                                              );
                                            } else if (index == 1) {
                                              Get.toNamed(
                                                Routes.REPORT,
                                                arguments: {"isReport": true},
                                              );
                                            } else if (index == 2) {
                                              Get.toNamed(
                                                Routes.REPORT,
                                                arguments: {"isReport": false},
                                              );
                                            } else if (index == 3) {
                                              Get.toNamed(Routes.SETTING);
                                            } else if (index == 4) {
                                              Get.toNamed(
                                                Routes.ROLE_MANAGEMENT,
                                                arguments: {"isHome": true},
                                              );
                                            } else if (index == 5) {
                                              Get.toNamed(Routes.WISH_LIST);
                                            } else if (index == 6) {
                                              Get.toNamed(Routes.NEWS);
                                            } else if (index == 7) {
                                              if (Platform.isAndroid) {
                                                Get.toNamed(Routes.REFER_EARN);
                                              } else {
                                                ComingSoonDialog.showComingSoonDialog(
                                                  featureName: 'Refer & Earn',
                                                );
                                              }
                                            }
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                item['icon'],
                                                height: 28,
                                                width: 28,
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                item['title'],
                                                textAlign: TextAlign.center,
                                                style: MyTexts.regular14
                                                    .copyWith(
                                                      color: MyColors
                                                          .textFieldBackground,
                                                      fontFamily:
                                                          MyTexts.Roboto,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
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
                                    style: MyTexts.medium14.copyWith(
                                      color: MyColors.gray5D,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(14),
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return const Padding(
                                  padding: EdgeInsets.only(bottom: 12),
                                  child: MerchantCard(),
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
          ],
        ),
      ),
    );
  }

  Widget _addressCard({
    Address? address,
    String? addressType,
    bool isSelected = false,
  }) {
    final displayText =
        "${address?.addressLine1}, ${address?.addressLine2}, ${address?.landmark}, ${address?.city}, ${address?.state} , ${address?.pinCode}";
    return GestureDetector(
      onTap: () {
        if (addressType == "office") {
          myPref.setDefaultAdd(true);
          controller.isDefaultOffice.value = true;
          controller.isDefaultOffice.refresh();
        } else {
          myPref.setDefaultAdd(false);
          controller.isDefaultOffice.value = false;
          controller.isDefaultOffice.refresh();
        }
        Get.back();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: MyColors.white,
          border: Border.all(
            color: isSelected ? MyColors.primary : MyColors.grayD4,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  addressType ?? "",
                  style: MyTexts.medium14.copyWith(color: MyColors.primary),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    final Placemark place = Placemark(
                      name: address?.addressLine1,
                      subAdministrativeArea: address?.landmark,
                      postalCode: address?.pinCode,
                      administrativeArea: address?.state,
                      locality: address?.city,
                      street: address?.addressLine2,
                    );
                    Get.back();
                    Get.toNamed(
                      Routes.ADD_LOCATION_MANUALLY,
                      arguments: {
                        "from": "Home",
                        "isCLocation": place,
                        "isOffice": addressType == "office" ? 0 : 1,
                        "id": address?.id,
                        "latitude": address?.latitude,
                        "longitude": address?.longitude,
                      },
                    );
                  },
                  icon: const Icon(Icons.edit, size: 18),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              displayText ?? "",
              style: MyTexts.regular14.copyWith(color: MyColors.fontBlack),
            ),
            const Gap(20),
          ],
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
              style: MyTexts.extraBold18.copyWith(
                color: MyColors.textFieldBackground,
              ),
            ),

            SizedBox(height: 2.h),

            // Team title row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Team",
                    style: MyTexts.bold18.copyWith(color: MyColors.fontBlack),
                  ),
                  Text(
                    "View All",
                    style: MyTexts.medium12.copyWith(
                      color: MyColors.textFieldBackground,
                    ),
                  ),
                ],
              ),
            ),

            // Team List
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: 3,
              shrinkWrap: true,
              // Important for nested scrollables
              physics: const NeverScrollableScrollPhysics(),
              // Disables inner scrolling
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

  Widget _buildNotiCard({
    String? title,
    String? value,
    Function()? onTap,

    String? icon,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,

      child: Container(
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
                    colorFilter: ColorFilter.mode(
                      color ?? Colors.black,
                      BlendMode.srcIn,
                    ),
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
      ),
    );
  }
}

class HearderText extends StatelessWidget {
  String text;
  TextStyle? textStyle;

  HearderText({super.key, required this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          textStyle ??
          MyTexts.medium18.copyWith(
            color: MyColors.black,
            fontFamily: MyTexts.Roboto,
          ),
    );
  }
}
