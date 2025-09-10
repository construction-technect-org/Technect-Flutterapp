import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final CommonController commonController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: MyColors.white,
          elevation: 0,
          title: Row(
            children: [
              Image.asset(Asset.profil, height: 40, width: 40),
              SizedBox(width: 1.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      'Welcome ${controller.profileData.value.data?.user?.firstName}!',
                      style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.navigateToEditAddress();
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(Asset.location, width: 9, height: 12.22),
                        SizedBox(width: 0.4.h),
                        Obx(
                          () => Text(
                            controller.getCurrentAddress(),
                            style: MyTexts.medium14.copyWith(
                              color: MyColors.textFieldBackground,
                            ),
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
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.hexGray92),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  clipBehavior: Clip.none, // 👈 allows badge to overflow
                  children: [
                    SvgPicture.asset(
                      Asset.notifications, // or 'assets/images/notifications.svg'
                      width: 28,
                      height: 28,
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(22.5),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000), // light shadow (10% black)
                          blurRadius: 8, // soften the shadow
                          offset: Offset(0, 4), // move shadow down
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 18, right: 8),
                          child: SvgPicture.asset(
                            Asset.searchIcon,
                            height: 16,
                            width: 16,
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                        hintText: 'Search',
                        hintStyle: MyTexts.medium16.copyWith(color: MyColors.darkGray),
                        filled: true,
                        fillColor: MyColors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22.5),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            Asset.filterIcon,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Features",
                    style: MyTexts.extraBold18.copyWith(
                      color: MyColors.textFieldBackground,
                    ),
                  ),
                ),
                SizedBox(height: 1.h),

                /// ✅ FIXED GridView
                Container(
                  height: 210, // match your design
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.items.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // 4 items per row
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1, // roughly square
                      ),
                      itemBuilder: (context, index) {
                        final item = controller.items[index];
                        final isSelected = controller.selectedIndex.value == index;

                        return GestureDetector(
                          onTap: () {
                            controller.selectedIndex.value = index;
                            if (item['title'] == "Marketplace") {
                              Get.toNamed(Routes.MARKET_PLACE);
                            }
                          },
                          child: Container(
                            width: 85,
                            height: 85,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFFFED29)
                                  : const Color(0x99FFED29),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(item['icon'], height: 40, width: 50),
                                Text(
                                  item["title"],
                                  textAlign: TextAlign.center,
                                  style: MyTexts.medium14.copyWith(
                                    color: MyColors.fontBlack,
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
                SizedBox(height: 1.h),
                Obx(() {
                  if (commonController.hasProfileComplete.value) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.teamList.isNotEmpty)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 25,
                                  right: 24,
                                  top: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Team",
                                      style: MyTexts.medium18.copyWith(
                                        color: MyColors.textFieldBackground,
                                      ),
                                    ),
                                    // Text(
                                    //   "View All",
                                    //   style: MyTexts.medium12.copyWith(
                                    //     color: MyColors.textFieldBackground,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 130,
                                child: GestureDetector(
                                  onTap: () {
                                    // Get.toNamed(Routes.ROLE_MANAGEMENT);
                                  },
                                  child: Obx(() {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.teamList.length,
                                      itemBuilder: (context, index) {
                                        final teamMember = controller.teamList[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                            top: 15,
                                          ),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 35,
                                                child: ClipOval(
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        teamMember.profilePhotoUrl ?? '',
                                                    width: 70,
                                                    height: 70,
                                                    fit: BoxFit.cover,
                                                    placeholder: (context, url) =>
                                                        Container(
                                                          width: 70,
                                                          height: 70,
                                                          decoration: const BoxDecoration(
                                                            color: MyColors.grey1,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: const Center(
                                                            child:
                                                                CupertinoActivityIndicator(
                                                                  color: MyColors.primary,
                                                                  radius: 15,
                                                                ),
                                                          ),
                                                        ),
                                                    errorWidget: (context, url, error) =>
                                                        Container(
                                                          width: 70,
                                                          height: 70,
                                                          decoration: const BoxDecoration(
                                                            color: MyColors.grey1,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: const Icon(
                                                            Icons.person,
                                                            color: MyColors.grey,
                                                            size: 35,
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 1.h),
                                              Text(
                                                teamMember.fullName ?? 'Unknown',
                                                style: MyTexts.medium16.copyWith(
                                                  color: MyColors.dimGray,
                                                  fontFamily: MyTexts.Roboto,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Statistics",
                            style: MyTexts.medium18.copyWith(
                              color: MyColors.textFieldBackground,
                            ),
                          ),
                        ),
                        Center(
                          child: Row(
                            children: [
                              // No of Users Card (SVG icon)
                              _buildInfoCard(
                                icon: SvgPicture.asset(
                                  Asset.noOfUsers,
                                  height: 11.7,
                                  width: 12.39,
                                ),
                                title: "No of Users",
                                value: "34",
                              ),

                              // Total Products Card (Material Icon)
                              _buildInfoCard(
                                icon: SvgPicture.asset(
                                  Asset.totalProducts,
                                  height: 11.7,
                                  width: 12.39,
                                ),
                                title: "Total Products",
                                value: "104",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x33000000), // subtle black shadow (20%)
                                  blurRadius: 4, // smooth edges
                                  offset: Offset(0, 2), // shadow below bar
                                ),
                              ],
                              color: MyColors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Top Row (Title + Dropdown)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Interests',
                                      style: MyTexts.medium14.copyWith(
                                        color: MyColors.textFieldBackground,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '2024-25',
                                          style: MyTexts.medium12.copyWith(
                                            color: MyColors.textFieldBackground,
                                          ),
                                        ),
                                        const Icon(Icons.keyboard_arrow_down_outlined),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: List.generate(_monthNames.length, (
                                    monthIndex,
                                  ) {
                                    return Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          for (int i = 0; i < 4; i++)
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 2,
                                              ),
                                              child: Container(
                                                width: 10,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color: (i.isEven || monthIndex % 2 == 0)
                                                      ? MyColors.warning
                                                      : MyColors.progressRemaining,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                              ),
                                            ),
                                          SizedBox(height: 0.6.h),
                                          Text(
                                            _monthNames[monthIndex],
                                            style: MyTexts.extraBold12.copyWith(
                                              color: MyColors.textFieldBackground,
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
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text("Statistics", style: MyTexts.medium18),
                        ),
                        SizedBox(height: 1.h),
                        Center(child: Image.asset(Asset.worldMap, width: 90.w)),
                        SizedBox(height: 2.h),
                        Center(
                          child: Text(
                            "Connecting Construction World-wide with AI",
                            textAlign: TextAlign.center,
                            style: MyTexts.bold16,
                          ),
                        ),
                      ],
                    );
                  }
                }),
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
      padding: const EdgeInsets.only(left: 18, top: 12),
      child: Container(
        width: 169,
        height: 89,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08), // 👈 subtle shadow
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3), // 👈 downward shadow
            ),
          ],
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
          ],
        ),
      ),
    );
  }
}

List<String> _monthNames = [
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
  "Feb",
  "Mar",
];
