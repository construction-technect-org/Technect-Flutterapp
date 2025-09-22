import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Address/controller/address_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressView extends GetView<AddressController> {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: CommonAppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Add Location"),
                Text(
                  "Select your location for better tracking",
                  style: MyTexts.medium14.copyWith(color: MyColors.shadeOfGray),
                ),
              ],
            ),
            isCenter: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.h),
                Container(
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
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.onSearchChanged(value);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 8),
                        child: SvgPicture.asset(
                          Asset.searchIcon,
                          height: 16,
                          width: 16,
                          color: MyColors.primary,
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      hintText: 'Search',
                      hintStyle: MyTexts.medium16.copyWith(
                        color: MyColors.darkGray,
                      ),
                      filled: true,
                      fillColor: MyColors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),

                      // 🔹 Always show border with primary color
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22.5),
                        borderSide: const BorderSide(color: MyColors.primary),
                      ),

                      // 🔹 Also keep same style on focus
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22.5),
                        borderSide: const BorderSide(color: MyColors.primary),
                      ),

                      // suffixIcon: Obx(
                      //   () => controller.isSearching.value
                      //       ? const Padding(
                      //           padding: EdgeInsets.all(14),
                      //           child: SizedBox(
                      //             width: 20,
                      //             height: 20,
                      //             child: CircularProgressIndicator(
                      //               strokeWidth: 2,
                      //               valueColor: AlwaysStoppedAnimation<Color>(
                      //                 Colors.grey,
                      //               ),
                      //             ),
                      //           ),
                      //         )
                      //       : Padding(
                      //           padding: const EdgeInsets.all(14),
                      //           child: SvgPicture.asset(
                      //             Asset.filterIcon,
                      //             height: 20,
                      //             width: 20,
                      //           ),
                      //         ),
                      // ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: MyColors.Gray83),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.h),
                          child: ListTile(
                            onTap: () {
                              controller.place.value = null;
                              controller.navigateToManualAddress();
                            },
                            leading: const Icon(
                              Icons.add,
                              color: MyColors.primary,
                              size: 16,
                            ),
                            title: Text(
                              "Add Location Manually",
                              style: MyTexts.regular16.copyWith(
                                color: MyColors.fontBlack,
                                fontFamily: MyTexts.Roboto,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.h),
                          child: Divider(
                            height: 0.1.h,
                            thickness: 0.5,
                            color: MyColors.black.withValues(alpha: 0.5),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.h),
                          child: ListTile(
                            onTap: () {
                              if (controller.currentAddress.isNotEmpty) {
                                controller.place.value = controller.place2;
                                controller.navigateToManualAddress();
                              } else {
                                controller.useCurrentLocation().then((val) {
                                  controller.place.value = controller.place2;
                                  controller.navigateToManualAddress();
                                });
                              }
                            },
                            leading: const Icon(
                              Icons.my_location,
                              color: MyColors.primary,
                              size: 16,
                            ),
                            title: Text(
                              "Use your Current Location",
                              style: MyTexts.regular16.copyWith(
                                color: MyColors.fontBlack,
                                fontFamily: MyTexts.Roboto,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 3.h),
                // Info
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Asset.Locationon, height: 20, width: 20),
                      const SizedBox(width: 11),
                      Text(
                        "Drag the pin for your location",
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.redgray,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Expanded(
                  child: Obx(
                    () => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      child: GoogleMap(
                        onMapCreated: controller.onMapCreated,
                        onCameraMove: controller.onCameraMove,
                        onCameraIdle: controller.onCameraIdle,
                        initialCameraPosition: CameraPosition(
                          target: controller.currentPosition.value,
                          zoom: controller.mapZoom.value,
                        ),
                        markers: controller.markers.values.toSet(),
                        mapType: controller.mapType.value,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        mapToolbarEnabled: false,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Obx(
                    () => RoundedButton(
                      buttonName: 'SUBMIT',
                      onTap: controller.isLoading.value
                          ? null
                          : controller.saveLocation,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
