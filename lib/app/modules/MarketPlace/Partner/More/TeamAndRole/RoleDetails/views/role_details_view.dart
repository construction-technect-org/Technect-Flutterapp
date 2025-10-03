import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleDetails/controllers/role_details_controller.dart';

class RoleDetailsView extends GetView<RoleDetailsController> {
  const RoleDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CommonAppBar(title: const Text("Role Details"), isCenter: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(5.w),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Edit Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.ADD_ROLE,
                          arguments: {
                            "isEdit": true,
                            "data": controller.roleDetailsModel,
                          },
                        );
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.primary.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.edit, color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),

                /// Role Details Card
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: MyColors.grayD4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Role Icon + Title
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: MyColors.paleBluecolor.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(Asset.Admin, width: 18, height: 18),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              controller.roleTitle.value,
                              style: MyTexts.medium18.copyWith(
                                color: MyColors.fontBlack,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),

                      /// Description Section
                      Text(
                        "Description",
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.fontBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        controller.roleDescription.value,
                        style: MyTexts.regular14.copyWith(color: MyColors.gray32),
                      ),
                      SizedBox(height: 2.h),

                      /// Functionalities
                      Text(
                        "Functionalities",
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.fontBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: MyColors.green),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.sp),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                          backgroundColor: MyColors.green.withOpacity(0.05),
                        ),
                        onPressed: () {},
                        child: Text(
                          controller.functionalities.toString(),
                          style: MyTexts.regular16.copyWith(color: MyColors.green),
                        ),
                      ),

                      Visibility(
                        visible: false,
                        child: Column(
                          children: [
                            SizedBox(height: 2.h),
                            const Divider(thickness: 1.2, color: MyColors.grayD4),
                            SizedBox(height: 2.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// Toggle
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Change Status",
                                      style: MyTexts.regular14.copyWith(
                                        color: MyColors.fontBlack,
                                      ),
                                    ),
                                    SizedBox(height: 0.5.h),
                                    Switch(
                                      activeColor: MyColors.green,
                                      value: controller.roleStatus.value == 'Active',
                                      onChanged: (value) {
                                        controller.roleStatus.value = value
                                            ? 'Active'
                                            : 'InActive';
                                      },
                                    ),
                                  ],
                                ),

                                /// Animated Status Badge
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 1.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: controller.roleStatus.value == 'Active'
                                        ? MyColors.green
                                        : MyColors.red,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    controller.roleStatus.value,
                                    style: MyTexts.regular16.copyWith(
                                      color: MyColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
}
