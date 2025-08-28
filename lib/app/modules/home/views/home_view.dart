import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:construction_technect/app/core/utils/constants.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final List<Map<String, String>> items = [
    {"icon": Asset.marketplaceIcon, "label": "Marketplace"},
    {"icon": Asset.erpIcon, "label": "ERP"},
    {"icon": Asset.crmIcon, "label": "CRM"},
    {"icon": Asset.ovpIcon, "label": "OVP"},
    {"icon": Asset.hrmsIcon, "label": "HRMS"},
    {"icon": Asset.projectManagementIcon, "label": "Project\nManagement"},
    {"icon": Asset.portfolioManagementIcon, "label": "Portfolio\nManagement"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,

      /// ✅ Custom AppBar
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(Asset.profil, height: 40, width: 40),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Vaishnavi!",
                  style: MyTexts.medium16.copyWith(
                    color: MyColors.fontBlack,
                    fontFamily: MyTexts.Roboto,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // 👇 Navigate to new screen
                     Get.toNamed(Routes.LOCATION);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(Asset.location, width: 9, height: 12.22),
                      const SizedBox(width: 2),
                      Text(
                        "Sadashiv Peth, Pune",
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.textFieldBackground,
                          fontFamily: MyTexts.Roboto,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                child: TextField(
                  style: const TextStyle(fontSize: 14),
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
                    hintStyle: MyTexts.medium16.copyWith(
                      color: MyColors.darkGrayishRed,
                      fontFamily: MyTexts.Roboto,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
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

              const SizedBox(height: 20),

              /// Features title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Features",
                  style: MyTexts.medium16.copyWith(
                    color: MyColors.textFieldBackground,
                    fontFamily: MyTexts.Roboto,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              /// ✅ FIXED GridView
              Transform.translate(
                offset: const Offset(
                  0,
                  0,
                ), // 👈 replaces margin: left -1, top 172
                child: Container(
                  height: 237,
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 0,
                          childAspectRatio: 0.80,
                        ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Wrap(
                          spacing: 6,
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.center,
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
                                      items[index]["icon"]!,
                                      height: 73,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30, // enough space for 2 lines
                              child: Text(
                                items[index]["label"]!,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: MyTexts.medium16.copyWith(
                                  color: MyColors.textFieldBackground,
                                  fontFamily: MyTexts.Roboto,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 24, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Team",
                      style: MyTexts.medium16.copyWith(
                        color: MyColors.textFieldBackground,
                        fontFamily: MyTexts.Roboto,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "View All",
                      style: MyTexts.medium16.copyWith(
                        color: MyColors.textFieldBackground,
                        fontFamily: MyTexts.Roboto,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 130,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Statistics",
                  style: MyTexts.medium16.copyWith(
                    color: MyColors.textFieldBackground,
                    fontFamily: MyTexts.Roboto,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
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

                    const SizedBox(width: 12),

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
                    color: Colors.white,
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
                            style: MyTexts.medium16.copyWith(
                              color: MyColors.textFieldBackground,
                              fontFamily: MyTexts.Roboto,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '2024-25',
                                style: MyTexts.medium16.copyWith(
                                  color: MyColors.textFieldBackground,
                                  fontFamily: MyTexts.Roboto,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down_outlined),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

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
                                const SizedBox(height: 6),
                                Text(
                                  _monthNames[monthIndex],
                                  style: MyTexts.medium16.copyWith(
                                    color: MyColors.textFieldBackground,
                                    fontFamily: MyTexts.Roboto,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 7,
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
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                icon, // 👈 directly place widget
                const SizedBox(width: 6),
                Text(
                  title,
                  style: MyTexts.medium16.copyWith(
                    color: MyColors.textFieldBackground,
                    fontFamily: MyTexts.Roboto,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: MyTexts.medium16.copyWith(
                color: MyColors.textFieldBackground,
                fontFamily: MyTexts.Roboto,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
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






