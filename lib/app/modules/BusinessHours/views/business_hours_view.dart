import 'package:construction_technect/app/core/utils/custom_switch.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/BusinessHours/controller/business_hours_controller.dart';

class BusinessHoursView extends GetView<BusinessHoursController> {
  @override
  Widget build(BuildContext context) {
    // Load previous business hours data if provided
    final arguments = Get.arguments;
    if (arguments != null && arguments is List<Map<String, dynamic>>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.loadPreviousBusinessHours(arguments);
      });
    }
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: MyColors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: MyColors.oldLace,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.access_time,
                        color: MyColors.warning,
                        size: 30,
                      ),
                    ),
                    SizedBox(width: 2.h, height: 10.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "BUSINESS HOURS",
                          style: MyTexts.bold20.copyWith(
                            color: MyColors.textFieldBackground,
                          ),
                        ),
                        Text(
                          "Update your Working Hours",
                          style: MyTexts.medium16.copyWith(
                            color: MyColors.greyDetails,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 3.h),

                // Enable toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enable",
                          style: MyTexts.bold16.copyWith(color: MyColors.fontBlack),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          "Quickly Enable or Disable business hours",
                          style: MyTexts.regular14.copyWith(
                            color: MyColors.graniteGray,
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => CustomSwitch(
                        value: controller.isEnabled.value,
                        onChanged: (val) {
                          controller.isEnabled.value = val;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Divider(height: 2.h, color: MyColors.brightGray1),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Timezone",
                          style: MyTexts.bold16.copyWith(color: MyColors.fontBlack),
                        ),
                        SizedBox(height: 0.7.h),
                        Text(
                          "Set your timezone",
                          style: MyTexts.regular14.copyWith(
                            color: MyColors.graniteGray,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 6.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "(UTC-8:00) Pacific Time",
                              style: MyTexts.bold16.copyWith(
                                color: MyColors.fontBlack,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_up,
                                  size: 10,
                                  color: Colors.black,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 10,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(height: 4.h, color: MyColors.brightGray1),
                // Days List
                Obx(() {
                  if (!controller.isEnabled.value) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: controller.daysEnabled.keys.map((day) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Obx(() {
                          final bool enabled = controller.daysEnabled[day]!.value;
                          return Row(
                            children: [
                              CustomSwitch(
                                value: enabled,
                                onChanged: (val) {
                                  controller.daysEnabled[day]!.value = val;
                                },
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: Text(
                                  day,
                                  style: MyTexts.bold16.copyWith(
                                    color: MyColors.fontBlack,
                                  ),
                                ),
                              ),
                              if (enabled) ...[
                                
                                SizedBox(
                                  width: 90,
                                  height: 40,
                                  child: TextField(
                                    controller: controller.fromControllers[day],
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "From",
                                      hintStyle: MyTexts.bold14.copyWith(
                                        color: MyColors.fontBlack,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),

                                      // ✅ Default border
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: MyColors.textFieldBorder,
                                        ),
                                      ),

                                      // ✅ When enabled
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: MyColors.textFieldBorder,
                                        ),
                                      ),

                                      // ✅ When focused (clicked)
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: MyColors.textFieldBorder,
                                        ),
                                      ),

                                      // ✅ When error
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: MyColors.textFieldBorder,
                                        ),
                                      ),

                                      // ✅ When focused + error
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: MyColors.textFieldBorder,
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      controller.validateTimeInput(value, day, 'from');
                                    },
                                  ),
                                ),

                                const SizedBox(width: 10),
                               
                              SizedBox(
                                  width: 90,
                                  height: 40,
                                  child: TextField(
                                    controller: controller.toControllers[day],
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "From",
                                      hintStyle: MyTexts.bold14.copyWith(
                                        color: MyColors.fontBlack,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),

                                      // ✅ Default border
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: MyColors.textFieldBorder,
                                        ),
                                      ),

                                      // ✅ When enabled
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: MyColors.textFieldBorder,
                                        ),
                                      ),

                                      // ✅ When focused (clicked)
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: MyColors.textFieldBorder,
                                        ),
                                      ),

                                      // ✅ When error
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: MyColors.textFieldBorder,
                                        ),
                                      ),

                                      // ✅ When focused + error
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: MyColors.textFieldBorder,
                                        ),
                                      ),
                                    ),
                                     onChanged: (value) {
                                      controller.validateTimeInput(
                                        value,
                                        day,
                                        'to',
                                      );
                                    },
                                  ),
                                ),

                               
                             
                              ] else ...[
                                // Closed UI
                                Container(
                                  width: 190,
                                  height: 38,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: MyColors.textFieldBorder),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          Asset.closeIcon,
                                          width: 12,
                                          height: 12,
                                        ),
                                         SizedBox(width: 2.w),
                                        Text(
                                          "Closed",
                                          style: MyTexts.bold14.copyWith(
                                            color: MyColors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          );
                        }),
                      );
                    }).toList(),
                  );
                }),
                const Spacer(),
                RoundedButton(
                  buttonName: 'SUBMIT',
                  onTap: () {
                    controller.onSubmit();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
