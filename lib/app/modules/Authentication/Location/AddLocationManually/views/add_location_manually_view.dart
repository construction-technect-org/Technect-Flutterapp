import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/modules/Authentication/Location/AddLocationManually/controller/add_location_manually_controller.dart';

class AddLocationManuallyView extends GetView<AddLocationController> {
  const AddLocationManuallyView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: controller.locationAdded.value
            ? null // no appBar
            : PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight + 30),
                // adjust as needed
                child: CommonAppBar(
                  isCenter: false,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.isEditing.value
                            ? "Edit Location"
                            : "Add Location Manually",
                      ),
                      Text(
                        "Select your location for better tracking",
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.shadeOfGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        backgroundColor: MyColors.white,
        resizeToAvoidBottomInset: true,
        // ✅ allow body to resize on keyboard open
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(
              () => controller.locationAdded.value
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Asset.locationComplete,
                        ).paddingSymmetric(horizontal: 20),
                        SizedBox(height: 2.h),
                        Text(
                          "Location Connected!",
                          style: MyTexts.bold20.copyWith(
                            color: MyColors.textFieldBackground,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          "Your location is successfully connected.",
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.grey1,
                          ),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      // ✅ scroll instead of overflow
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Address Line 1',
                                style: MyTexts.light16.copyWith(
                                  color: MyColors.lightBlue,
                                ),
                              ),
                              Text(
                                '*',
                                style: MyTexts.light16.copyWith(
                                  color: MyColors.red,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          CustomTextField(
                            controller: controller.addressLine1Controller,
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Text(
                                'Address Line 2',
                                style: MyTexts.light16.copyWith(
                                  color: MyColors.lightBlue,
                                ),
                              ),
                              Text(
                                '*',
                                style: MyTexts.light16.copyWith(
                                  color: MyColors.red,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          CustomTextField(
                            controller: controller.addressLine2Controller,
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Text(
                                'Landmark',
                                style: MyTexts.light16.copyWith(
                                  color: MyColors.lightBlue,
                                ),
                              ),
                              Text(
                                '*',
                                style: MyTexts.light16.copyWith(
                                  color: MyColors.red,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          CustomTextField(
                            controller: controller.landmarkController,
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Text(
                                'City',
                                style: MyTexts.light16.copyWith(
                                  color: MyColors.lightBlue,
                                ),
                              ),
                              Text(
                                '*',
                                style: MyTexts.light16.copyWith(
                                  color: MyColors.red,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          CustomTextField(
                            controller: controller.cityController,
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Text(
                                'State',
                                style: MyTexts.light16.copyWith(
                                  color: MyColors.lightBlue,
                                ),
                              ),
                              Text(
                                '*',
                                style: MyTexts.light16.copyWith(
                                  color: MyColors.red,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          CustomTextField(
                            controller: controller.stateController,
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Text(
                                'Pin Code',
                                style: MyTexts.light16.copyWith(
                                  color: MyColors.lightBlue,
                                ),
                              ),
                              Text(
                                '*',
                                style: MyTexts.light16.copyWith(
                                  color: MyColors.red,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          CustomTextField(
                            controller: controller.pinCodeController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                          ),
                          SizedBox(height: 2.h), // ✅ space before button
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() {
                                return controller.from.value != "Home"
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'SAVE AS',
                                            style: MyTexts.regular16.copyWith(
                                              color: MyColors.fontBlack,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          // Add Location Type buttons
                                          Obx(
                                            () =>
                                                controller
                                                    .showAddLocationOption
                                                    .value
                                                ? Row(
                                                    children: [
                                                      _PillButton(
                                                        label: 'Office',
                                                        icon: Icons
                                                            .business_center_outlined,
                                                        selected:
                                                            controller
                                                                .selectedIndex
                                                                .value ==
                                                            0,
                                                        onTap: () => controller
                                                            .setSelectedIndex(
                                                              0,
                                                            ),
                                                      ),
                                                      const SizedBox(width: 12),
                                                      _PillButton(
                                                        label: 'factory',
                                                        icon:
                                                            Icons.work_outline,
                                                        selected:
                                                            controller
                                                                .selectedIndex
                                                                .value ==
                                                            1,
                                                        onTap: () => controller
                                                            .setSelectedIndex(
                                                              1,
                                                            ),
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox.shrink(),
                                          ),

                                          SizedBox(height: 2.h),
                                          // ✅ space before button
                                          // Checkbox for copying address
                                          Obx(
                                            () =>
                                                controller
                                                    .showAddLocationOption
                                                    .value
                                                ? Row(
                                                    children: [
                                                      Checkbox(
                                                        value: controller
                                                            .copyToOtherType
                                                            .value,
                                                        onChanged: (val) =>
                                                            controller
                                                                    .copyToOtherType
                                                                    .value =
                                                                val ?? false,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        'Use same address for ${controller.selectedIndex.value == 0 ? 'office' : 'factory'}',
                                                        style: MyTexts.medium14,
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox.shrink(),
                                          ),
                                        ],
                                      )
                                    : const SizedBox();
                              }),
                              SizedBox(height: 4.h),
                              // ✅ space before button
                              Obx(
                                () => RoundedButton(
                                  buttonName: controller.isLoading.value
                                      ? 'SUBMITTING...'
                                      : 'SUBMIT',
                                  onTap: controller.isLoading.value
                                      ? null
                                      : () => controller.submitLocation(),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              // ✅ bottom padding to avoid cut-off
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _PillButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Colors tuned to look like the screenshot
    const selectedBorder = Color(0xFFDB6B2B); // orange border
    const selectedFill = Color(0xFFFFF2EA); // pale orange fill
    const unselectedFill = Color(0xFFF6F7F9); // pale grey background
    const unselectedText = Color(0xFF1F2937); // dark navy for text

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? selectedFill : unselectedFill,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: selected ? MyColors.warning : MyColors.americanSilver,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // icon container to give the small rounded square look
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: selected
                    ? selectedBorder.withOpacity(0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                icon,
                size: 18,
                color: selected ? selectedBorder : MyColors.fontBlack,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: MyTexts.regular14.copyWith(
                color: selected ? MyColors.warning : unselectedText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
