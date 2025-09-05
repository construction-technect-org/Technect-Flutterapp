import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/TeamDetails/controllers/team_details_controller.dart';
import 'package:dotted_border/dotted_border.dart';

class TeamDetailsView extends GetView<TeamDetailsController> {
  const TeamDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.white,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        title: Row(
          children: [
            Image.asset(Asset.profil, height: 5.h, width: 5.h),
            SizedBox(width: 2.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Vaishnavi!",
                  style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.ADDRESS),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Asset.location,
                        width: 2.w,
                        height: 2.4.h,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        "Sadashiv Peth, Pune",
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.textFieldBackground,
                        ),
                      ),
                      SizedBox(width: 1.w),
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
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(Asset.notifications, width: 28, height: 28),
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
          padding: EdgeInsets.only(bottom: 3.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Search bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(22.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 4.w, right: 2.w),
                        child: SvgPicture.asset(
                          Asset.searchIcon,
                          height: 2.h,
                          width: 2.h,
                        ),
                      ),
                      hintText: 'Search',
                      hintStyle: MyTexts.medium16.copyWith(
                        color: MyColors.darkGray,
                      ),
                      filled: true,
                      fillColor: MyColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22.5),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: SvgPicture.asset(
                          Asset.filterIcon,
                          height: 3.h,
                          width: 3.h,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.h),

              /// Team Details
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Team Details",
                      style: MyTexts.medium18.copyWith(
                        color: MyColors.fontBlack,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 7.w,
                        height: 3.5.h,
                        decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Team Info Card
              Padding(
                padding: EdgeInsets.all(4.w),
                child: Obx(
                  () => Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.w),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 4.h,
                              backgroundImage: const NetworkImage(
                                "https://via.placeholder.com/150",
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.userName.value,
                                    style: MyTexts.extraBold20.copyWith(
                                      color: MyColors.fontBlack,
                                    ),
                                  ),
                                  Text(
                                    controller.userEmail.value,
                                    style: MyTexts.regular14.copyWith(
                                      color: MyColors.lightGray,
                                    ),
                                  ),
                                  Text(
                                    "User Role: ${controller.userRole.value}",
                                    style: MyTexts.regular14.copyWith(
                                      color: MyColors.fontBlack,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: MyColors.hexGray92),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 18,
                              color: MyColors.primary,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              controller.userPhone.value,
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.lightGray,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 18,
                              color: MyColors.primary,
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Text(
                                controller.userAddress.value,
                                style: MyTexts.regular14.copyWith(
                                  color: MyColors.lightGray,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 2.h),

              /// Documents Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: const Text(
                  "Documents",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 1.5.h),

              Obx(
                () => Column(
                  children: controller.documents.map((doc) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.h,
                      ),
                      child: _buildCertificationItem(
                        doc["title"]!,
                        doc["organization"]!,
                        doc["expiry"]!,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCertificationItem(
  String title,
  String organization,
  String expiryDate,
) {
  return DottedBorder(
    borderType: BorderType.RRect,
    radius: Radius.circular(3.w),
    color: const Color(0xFF8C8C8C),
    dashPattern: const [5, 5],
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Icon box + actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 10.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9F0FF),
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.w),
                  child: SvgPicture.asset(
                    Asset.certificateIcon,
                    colorFilter: const ColorFilter.mode(
                      MyColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(Asset.viewEye),
                  SizedBox(width: 3.w),
                  SvgPicture.asset(Asset.Delete),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),

          /// Content
          Text(
            title,
            style: MyTexts.medium22.copyWith(
              color: MyColors.black,
              fontFamily: MyTexts.Roboto,
            ),
          ),
          Text(
            organization,
            style: MyTexts.medium14.copyWith(
              color: const Color(0xFF717171),
              fontFamily: MyTexts.Roboto,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            expiryDate,
            style: MyTexts.medium14.copyWith(
              color: const Color(0xFF717171),
              fontFamily: MyTexts.Roboto,
            ),
          ),
        ],
      ),
    ),
  );
}
