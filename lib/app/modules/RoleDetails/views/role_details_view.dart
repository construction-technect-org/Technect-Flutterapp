import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/welcome_name.dart';
import 'package:construction_technect/app/modules/RoleDetails/controllers/role_details_controller.dart';

class RoleDetailsView extends GetView<RoleDetailsController> {
  const RoleDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.white,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        title: WelcomeName(),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Role Details",
                          style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.ADD_ROLE,
                              arguments: {
                                "isEdit": true,
                                "data": controller.roleDetailsModel,
                              },
                            );
                          },
                          child: Container(
                            width: 27,
                            height: 26,
                            decoration: BoxDecoration(
                              color: MyColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.edit, size: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.5.h),

                    /// Role Card
                    Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3.w),
                          border: Border.all(color: MyColors.americanSilver),
                        ),
                        padding: EdgeInsets.all(4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 3.h,
                                  decoration: BoxDecoration(
                                    color: MyColors.paleBluecolor, // background color
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      Asset.Admin,
                                      width: 14.54, // scale as needed
                                      height: 13,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Text(
                                  controller.roleTitle.value,
                                  style: MyTexts.medium20.copyWith(
                                    color: MyColors.fontBlack,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 1.5.h),
                            Text(
                              "Role Description:",
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.fontBlack,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              controller.roleDescription.toString(),
                              style: MyTexts.regular14.copyWith(color: MyColors.gray32),
                            ),
                            /*  ...controller.roleDescription
                                .map(
                                  (desc) => Text(
                                    "• $desc",
                                    style: MyTexts.regular14.copyWith(
                                      color: MyColors.gray32,
                                    ),
                                  ),
                                )
                                .toList(),*/
                            SizedBox(height: 2.h),
                            Text(
                              "Functionality:",
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.fontBlack,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: MyColors.green),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.sp),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 1.2.h,
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                controller.functionalities.toString(),
                                style: MyTexts.regular16.copyWith(color: MyColors.green),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Role Status:",
                                      style: MyTexts.regular14.copyWith(
                                        color: MyColors.fontBlack,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 1.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: controller.roleStatus.value == 'Active'
                                            ? MyColors.green
                                            : MyColors.red,
                                        borderRadius: BorderRadius.circular(30.sp),
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
                                Column(
                                  children: [
                                    Text(
                                      "Change Role Status:",
                                      style: MyTexts.regular14.copyWith(
                                        color: MyColors.fontBlack,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Switch(
                                      activeColor: MyColors.green,
                                      value: controller.roleStatus.value == 'Active',
                                      onChanged: (value) {
                                        if (value) {
                                          controller.roleStatus.value = 'Active';
                                        } else {
                                          controller.roleStatus.value = 'InActive';
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
