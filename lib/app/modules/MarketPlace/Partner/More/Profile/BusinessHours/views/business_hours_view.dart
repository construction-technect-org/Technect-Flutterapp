import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/custom_switch.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/BusinessHours/controller/business_hours_controller.dart';

class BusinessHoursView extends GetView<BusinessHoursController> {
  @override
  Widget build(BuildContext context) {
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: RoundedButton(
            buttonName: 'Submit',
            onTap: () {
              controller.onSubmit();
            },
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Asset.moreIBg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text("Edit Business Hours"),
                  isCenter: false,
                  leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enable",
                                    style: MyTexts.bold15.copyWith(
                                      color: MyColors.gray2E,
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    "Quickly Enable or Disable business hours",
                                    style: MyTexts.medium13.copyWith(
                                      color: MyColors.gray54,
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
                          SizedBox(height: 3.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Timezone",
                                    style: MyTexts.bold15.copyWith(
                                      color: MyColors.gray2E,
                                    ),
                                  ),
                                  SizedBox(height: 0.7.h),
                                  Text(
                                    "Set your timezone",
                                    style: MyTexts.medium13.copyWith(
                                      color: MyColors.gray54,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 5.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: MyColors.grayEA),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(9),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "(UTC-8:00) Pacific Time",
                                        style: MyTexts.medium13.copyWith(
                                          color: MyColors.gray54,
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      const Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 10,
                                            color: Colors.black,
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_up,
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
                                            controller.daysEnabled[day]!.value =
                                                val;
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
                                              controller: controller
                                                  .fromControllers[day],
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                  2,
                                                ),
                                              ],
                                              decoration: InputDecoration(
                                                hintText: "From",
                                                hintStyle: MyTexts.bold14
                                                    .copyWith(
                                                      color: MyColors.grey,
                                                    ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),

                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                    color: MyColors.grayCD,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      borderSide:
                                                          const BorderSide(
                                                            color:
                                                                MyColors.grayCD,
                                                          ),
                                                    ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      borderSide:
                                                          const BorderSide(
                                                            color:
                                                                MyColors.grayCD,
                                                          ),
                                                    ),

                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                    color: MyColors.grayCD,
                                                  ),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      borderSide:
                                                          const BorderSide(
                                                            color:
                                                                MyColors.grayCD,
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

                                          Obx(
                                            () => DropdownButton<String>(
                                              underline: const SizedBox(),
                                              iconSize: 0,
                                              dropdownColor: Colors.white,
                                              value: controller
                                                  .fromPeriods[day]!
                                                  .value,
                                              items: ["AM", "PM"].map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                    style: MyTexts.medium13
                                                        .copyWith(
                                                          color:
                                                              MyColors.gray2E,
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
                                              controller:
                                                  controller.toControllers[day],
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                  2,
                                                ),
                                              ],
                                              decoration: InputDecoration(
                                                hintText: "To",
                                                hintStyle: MyTexts.bold14
                                                    .copyWith(
                                                      color: MyColors.grey,
                                                    ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),

                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                    color: MyColors.grayCD,
                                                  ),
                                                ),

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      borderSide:
                                                          const BorderSide(
                                                            color:
                                                                MyColors.grayCD,
                                                          ),
                                                    ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      borderSide:
                                                          const BorderSide(
                                                            color:
                                                                MyColors.grayCD,
                                                          ),
                                                    ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                    color: MyColors.grayCD,
                                                  ),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      borderSide:
                                                          const BorderSide(
                                                            color:
                                                                MyColors.grayCD,
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

                                              value: controller
                                                  .toPeriods[day]!
                                                  .value,
                                              items: ["AM", "PM"].map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                    style: MyTexts.medium13
                                                        .copyWith(
                                                          color:
                                                              MyColors.gray2E,
                                                        ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: null,
                                            ),
                                          ),
                                        ] else ...[
                                          Container(
                                            width: 190,
                                            height: 44,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFCECE9),
                                              border: Border.all(
                                                color: const Color(0xFFF9D0CB),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    Asset.moon,
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                  SizedBox(width: 2.w),
                                                  Text(
                                                    "Closed",
                                                    style: MyTexts.bold14
                                                        .copyWith(
                                                          color: MyColors.black,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
