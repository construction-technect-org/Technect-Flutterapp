import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/dashboard/dashbaord_controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final CommonController commonController = Get.find<CommonController>();
    final DashBoardController controller = Get.find<DashBoardController>();

    return Drawer(
      width: 85.w,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(50),
                    Text('My Profile', style: MyTexts.bold18.copyWith(color: MyColors.lightBlue)),
                    Text(
                      "Today's task progress - 64%",
                      style: MyTexts.medium12.copyWith(color: MyColors.lightBlue.withOpacity(0.6)),
                    ),
                    const Gap(20),
                    Obx(() {
                      final userEmail = commonController.userEmail;
                      final userPhone = commonController.userPhone;
                      final profileImage = commonController.userImage;
                      final designation = commonController.userDesignation;

                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Transform.scale(
                                      scaleX: -1,
                                      child: const CircularProgressIndicator(
                                        value: 0.64,
                                        strokeWidth: 4,
                                        backgroundColor: MyColors.grayEA,
                                        valueColor: AlwaysStoppedAnimation<Color>(MyColors.yellow),
                                      ),
                                    ),
                                  ),
                                  ClipOval(
                                    child: profileImage.isEmpty
                                        ? const Icon(
                                            Icons.account_circle,
                                            size: 100,
                                            color: MyColors.grey,
                                          )
                                        : getImageView(
                                            finalUrl: profileImage.startsWith('http')
                                                ? profileImage
                                                : "${APIConstants.bucketUrl}$profileImage",
                                            fit: BoxFit.cover,
                                            height: 100,
                                            width: 100,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(10),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '${controller.userMainModel?.firstName?.capitalizeFirst ?? ''} ${controller.userMainModel?.lastName?.capitalizeFirst ?? ''}',
                                    style: MyTexts.medium16.copyWith(
                                      color: MyColors.fontBlack,
                                      fontFamily: MyTexts.SpaceGrotesk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (designation.isNotEmpty)
                              Text(
                                designation,
                                style: MyTexts.medium14.copyWith(color: MyColors.grey),
                              ),
                            if (userEmail.isNotEmpty)
                              Text(
                                userEmail,
                                style: MyTexts.medium12.copyWith(color: MyColors.grey),
                              ),
                            if (userPhone.isNotEmpty)
                              Text(
                                userPhone,
                                style: MyTexts.medium12.copyWith(color: MyColors.grey),
                              ),
                          ],
                        ),
                      );
                    }),
                    const Gap(16),
                    Obx(() {
                      final bizName = commonController.bizName;
                      final bizLogo = commonController.bizLogo;
                      final bizGst = commonController.bizGst;

                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: MyColors.whiteBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: const BoxDecoration(
                                color: MyColors.yellow,
                                shape: BoxShape.circle,
                              ),
                              child: bizLogo.isEmpty
                                  ? const Icon(Icons.business, color: MyColors.primary)
                                  : ClipOval(
                                      child: getImageView(
                                        finalUrl: bizLogo.startsWith('http')
                                            ? bizLogo
                                            : "${APIConstants.bucketUrl}$bizLogo",
                                        fit: BoxFit.cover,
                                        height: 48,
                                        width: 48,
                                      ),
                                    ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bizName.isNotEmpty ? bizName : 'Company Name',
                                    style: MyTexts.bold16.copyWith(color: MyColors.black),
                                  ),
                                  if (bizGst.isNotEmpty)
                                    Text(
                                      'GST: $bizGst',
                                      style: MyTexts.medium14.copyWith(
                                        color: MyColors.lightBlue.withOpacity(0.6),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios, size: 16, color: MyColors.grey),
                          ],
                        ),
                      );
                    }),
                    const Gap(8),
                    Obx(() {
                      final addresses = commonController.addresses;
                      String displayAddress = 'Add your address';
                      if (addresses.isNotEmpty) {
                        final defaultAddr = addresses.firstWhere(
                          (e) => e.isDefault == true,
                          orElse: () => addresses[0],
                        );
                        displayAddress = defaultAddr.fullAddress;
                      }

                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: MyColors.whiteBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: MyColors.black.withAlpha(128),
                            ),
                            const Gap(4),
                            Expanded(
                              child: Text(
                                displayAddress,
                                style: MyTexts.medium14.copyWith(
                                  color: MyColors.black.withAlpha(128),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 4),
                      );
                    }),
                    const Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Team', style: MyTexts.bold16),
                        Text(
                          '10 Members',
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.lightBlue.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),
                    SizedBox(
                      height: 40,
                      child: Stack(
                        children: List.generate(5, (index) {
                          return Positioned(
                            left: index * 28.0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const CircleAvatar(
                                radius: 18,
                                backgroundColor: MyColors.greyFive,
                                backgroundImage: AssetImage(Asset.profil),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Saved Locations', style: MyTexts.bold16),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.DELIVERY_LOCATION);
                          },
                          child: Row(
                            children: [
                              Text(
                                'View all',
                                style: MyTexts.medium14.copyWith(color: MyColors.lightBlue),
                              ),
                              const Gap(4),
                              const Icon(Icons.arrow_forward, size: 16, color: MyColors.lightBlue),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(12),
                    Obx(() {
                      final addresses = commonController.addresses;
                      if (addresses.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            "No saved locations yet",
                            style: MyTexts.medium14.copyWith(color: MyColors.grey),
                          ),
                        );
                      }
                      return Column(
                        children: addresses.take(3).map((addr) {
                          String addressId = '';
                          addressId = addr.id ?? "";

                          return GestureDetector(
                            onTap: () async {
                              if (addr.isDefault != true && addressId.isNotEmpty) {
                                await commonController.setDefaultAddress(addressId);
                              }
                            },
                            child: _buildLocationItem(
                              addr.label ?? 'Address',
                              addr.fullAddress,
                              addr.isDefault == true ? Colors.green : Colors.blue,
                              isDefault: addr.isDefault == true,
                            ),
                          );
                        }).toList(),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.PROFILE);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.primary),
                        color: MyColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "View Profile",
                            style: MyTexts.bold16.copyWith(color: MyColors.white),
                          ),
                          const Gap(8),
                          Icon(Icons.person_outline, color: MyColors.white, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const Gap(12),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.SETTING);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Settings", style: MyTexts.bold16.copyWith(color: MyColors.primary)),
                          const Gap(8),
                          const Icon(Icons.settings_outlined, color: MyColors.primary, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationItem(
    String title,
    String subtitle,
    Color iconColor, {
    bool isDefault = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconColor.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(Icons.location_on, color: iconColor, size: 18),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(title, style: MyTexts.bold14, overflow: TextOverflow.ellipsis),
                    ),
                    if (isDefault) ...[
                      const Gap(8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Default',
                          style: MyTexts.medium12.copyWith(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  subtitle,
                  style: MyTexts.medium12.copyWith(color: MyColors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
