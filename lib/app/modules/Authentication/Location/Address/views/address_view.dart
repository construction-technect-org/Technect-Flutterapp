import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/Authentication/Location/Address/controller/address_controller.dart';
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
                CommonTextField(
                  hintText: 'Search',
                  borderRadius: 50,
                  prefixIcon: SvgPicture.asset(
                    Asset.searchIcon,
                    height: 16,
                    width: 16,
                    color: MyColors.primary,
                  ),
                  controller: controller.searchController,
                  onChange: (value) {
                    controller.onSearchChanged(value??"");
                  },
                ),
                SizedBox(height: 2.h),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: MyColors.grayD4),
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
                                fontFamily: MyTexts.SpaceGrotesk,
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
                                controller.navigateToManualAddress(isCLocation: true);
                              } else {
                                controller.useCurrentLocation().then((val) {
                                  controller.place.value = controller.place2;
                                  controller.navigateToManualAddress(isCLocation: true);
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
                                fontFamily: MyTexts.SpaceGrotesk,
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
