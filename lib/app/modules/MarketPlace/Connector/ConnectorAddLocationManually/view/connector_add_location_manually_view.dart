import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorAddLocationManually/controllers/connector_add_location_manually_controller.dart';

class ConnectorAddLocationManuallyView
    extends GetView<ConnectorAddLocationManuallyController> {
  const ConnectorAddLocationManuallyView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 30),
          child: CommonAppBar(
            isCenter: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Add Location Manually"),
                Text(
                  "Select your location for better tracking",
                  style: MyTexts.medium14.copyWith(color: MyColors.shadeOfGray),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: MyColors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ✅ Search Field Row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.circular(22.5),
                            border: Border.all(color: MyColors.primary),
                          ),
                          child: TextFormField(
                            controller: controller.searchController,
                            onChanged: controller.onSearchChanged,
                            style: MyTexts.regular14.copyWith(
                              color: MyColors.darkGray,
                              fontFamily: MyTexts.SpaceGrotesk,
                            ),
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
                              hintText: 'Search for area, street name..',
                              hintStyle: MyTexts.regular14.copyWith(
                                color: MyColors.darkGray,
                                fontFamily: MyTexts.SpaceGrotesk,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.5),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h),

                  // ✅ Address Line 1
                  Row(
                    children: [
                      Text(
                        'Address Line 1',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                      Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.addressLine1Controller),
                  SizedBox(height: 2.h),

                  // ✅ Address Line 2
                  Row(
                    children: [
                      Text(
                        'Address Line 2',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                      Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.addressLine2Controller),
                  SizedBox(height: 2.h),

                  // ✅ Landmark
                  Row(
                    children: [
                      Text(
                        'Landmark',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                      Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.landmarkController),
                  SizedBox(height: 2.h),

                  // ✅ City/State
                  Row(
                    children: [
                      Text(
                        'City/State',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                      Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.cityStateController),
                  SizedBox(height: 2.h),

                  // ✅ Pin Code
                  Row(
                    children: [
                      Text(
                        'Pin Code',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                      Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.pinCodeController),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        ),

        // ✅ Bottom Submit Button
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24),
          child: RoundedButton(
            buttonName: 'SUBMIT',
            onTap: () {
              Get.toNamed(Routes.CONNECTOR_ADD_LOCATION_MANUALLY);
            },
          ),
        ),
      ),
    );
  }
}
