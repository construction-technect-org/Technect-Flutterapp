import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final CommonController commonController = Get.find();

  @override
  Widget build(BuildContext context) {
    return _buildMainContent();
  }

  Widget _buildMainContent() {
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
                    // 🔴 Red Dot Badge
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
                /// Search bar
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

                SizedBox(height: 2.h),

                /// Features title
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
                  height: 237,
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
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 4,
                      bottom: 20, // 👈 extra bottom space
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.80,
                    ),
                    itemCount: controller.items.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 70,
                            width: 65,
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFEB3B),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Positioned(
                                  bottom: -15,
                                  left: 0,
                                  right: 0,
                                  child: Image.asset(
                                    controller.items[index]["icon"]!,
                                    height: 73,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 0.7.h),
                          SizedBox(
                            child: Text(
                              controller.items[index]["label"]!,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textHeightBehavior: const TextHeightBehavior(
                                applyHeightToFirstAscent: false,
                                applyHeightToLastDescent: false,
                              ),
                              style: MyTexts.medium12.copyWith(
                                height: 1.2,
                                color: MyColors.textFieldBackground,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 1.h),
                Obx(() {
                  if (commonController.hasProfileComplete.value) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 24, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Team",
                                style: MyTexts.medium18.copyWith(
                                  color: MyColors.textFieldBackground,
                                ),
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
                        SizedBox(
                          height: 130,
                          child: GestureDetector(
                            onTap: () {
                              //   Get.toNamed(Routes.ROLE_MANAGEMENT);
                            },
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 7,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 20, top: 15),
                                  child: Column(
                                    children: [
                                      const CircleAvatar(
                                        radius: 35,
                                        backgroundImage: AssetImage(Asset.team),
                                      ),
                                      SizedBox(height: 1.h),
                                      Text(
                                        'Mohan Sau',
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
                            ),
                          ),
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

                                /// Chart Container
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
