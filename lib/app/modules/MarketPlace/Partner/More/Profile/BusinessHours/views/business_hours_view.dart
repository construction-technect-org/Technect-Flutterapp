import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/custom_switch.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/BusinessHours/controller/business_hours_controller.dart';

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
        appBar: CommonAppBar(
          isCenter: false,
          title: Text("EDIT BUSINESS HOURS".toUpperCase()),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: RoundedButton(
            buttonName: 'SUBMIT',
            onTap: () {
              controller.onSubmit();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  "Update your Working Hours",
                  style: MyTexts.medium16.copyWith(
                    color: MyColors.greyDetails,
                    fontFamily: MyTexts.Roboto,
                  ),
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
                          style: MyTexts.bold16.copyWith(
                            color: MyColors.fontBlack,
                          ),
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
                          style: MyTexts.bold16.copyWith(
                            color: MyColors.fontBlack,
                          ),
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
                          final bool enabled =
                              controller.daysEnabled[day]!.value;
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
                                  style: MyTexts.bold15.copyWith(
                                    color: MyColors.fontBlack,
                                  ),
                                ),
                              ),
                              if (enabled) ...[
                                SizedBox(
                                  width: 60,
                                  height: 40,
                                  child: TextField(
                                    style: MyTexts.bold16.copyWith(
                                      color: Colors.black,
                                    ),
                                    controller: controller.fromControllers[day],
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "From",
                                      hintStyle: MyTexts.bold14.copyWith(
                                        color: MyColors.grey,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),

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
                                        'from',
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(width: 6),

                                // 🔽 AM/PM Dropdown
                                Obx(
                                  () => DropdownButton<String>(
                                    underline: const SizedBox(),
                                    iconSize: 0,
                                    dropdownColor: Colors.white,
                                    value: controller.fromPeriods[day]!.value,
                                    items: ["AM", "PM"].map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: MyTexts.bold14.copyWith(
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: null,
                                  ),
                                ),
                                const SizedBox(width: 20),

                                SizedBox(
                                  width: 60,
                                  height: 40,
                                  child: TextField(
                                    style: MyTexts.bold16.copyWith(
                                      color: Colors.black,
                                    ),
                                    controller: controller.toControllers[day],
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "To",
                                      hintStyle: MyTexts.bold14.copyWith(
                                        color: MyColors.grey,
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

                                const SizedBox(width: 6),

                                // 🔽 AM/PM Dropdown
                                Obx(
                                  () => DropdownButton<String>(
                                    iconSize: 0,
                                     dropdownColor: Colors.white,
                                     underline: const SizedBox(),

                                    value: controller.toPeriods[day]!.value,
                                    items: ["AM", "PM"].map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: MyTexts.bold14.copyWith(
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: null,
                                  ),
                                ),
                              ] else ...[
                                // Closed UI
                                Container(
                                  width: 190,
                                  height: 44,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColors.textFieldBorder,
                                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
