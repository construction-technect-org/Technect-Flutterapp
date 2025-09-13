import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/location/controllers/location_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationView extends GetView<LocationController> {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Back + Title
                Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      borderRadius: BorderRadius.circular(50),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Select a Location",
                      style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
                    ),
                  ],
                ),
                SizedBox(height: 0.4.h),

                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "Select your location for better tracking",
                    style: MyTexts.medium14.copyWith(color: MyColors.shadeOfGray),
                  ),
                ),

                const SizedBox(height: 20),

                // ✅ Search Field
                Container(
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
                    controller: controller.searchController,
                    onChanged: controller.onSearchChanged,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 8),
                        child: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      hintText: 'Search',
                      hintStyle: MyTexts.medium16.copyWith(color: MyColors.darkGray),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22.5),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Obx(
                        () => controller.isSearching.value
                            ? const Padding(
                                padding: EdgeInsets.all(14),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(14),
                                child: SvgPicture.asset(
                                  Asset.filterIcon,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 3.h),

                // ✅ Info
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Asset.Locationon, height: 20, width: 20),
                      const SizedBox(width: 11),
                      Text(
                        "Drag the pin for your location",
                        style: MyTexts.medium16.copyWith(color: MyColors.redgray),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),

                // ✅ Add Location Options
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          onTap: controller.navigateToManualAddress,
                          leading: const Icon(
                            Icons.add,
                            color: MyColors.primary,
                            size: 16,
                          ),
                          title: Text(
                            "Add Location Manually",
                            style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                          ),
                        ),
                        const Divider(height: 1, thickness: 0.5),
                        ListTile(
                          onTap: controller.useCurrentLocation,
                          leading: const Icon(
                            Icons.my_location,
                            color: MyColors.primary,
                            size: 16,
                          ),
                          title: Text(
                            "Use your Current Location",
                            style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left side text
                       Text(
                        "Delivery Radius",
                       style: MyTexts.regular16.copyWith(color: MyColors.fontBlack),

                      ),

                      // Right side box
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:  Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "5 KM",
                               style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),

                            ),
                            const SizedBox(width: 6),

                            // Up/Down arrows
                            const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.keyboard_arrow_up, size: 18),
                                Icon(Icons.keyboard_arrow_down, size: 18),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(color: MyColors.brightGray1),
                SizedBox(height: 1.h),
                // ✅ Google Map
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
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

                SizedBox(height: 3.h),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // ✅ Centers buttons horizontally in the Row
                      children: [
                        SizedBox(
                          width: 35.w,
                          height: 48,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: MyColors.red),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Clear",
                              style: MyTexts.medium16.copyWith(
                                color: MyColors.red,
                                fontFamily: MyTexts.Roboto,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        RoundedButton(
                          onTap: () {
                            Get.toNamed(Routes.ADD_PRODUCT);
                          },
                          buttonName: '',
                          borderRadius: 12,
                          width: 35.w,
                          height: 48,
                          color: MyColors.lightBlueSecond,
                          verticalPadding: 0,
                          horizontalPadding: 0,
                          child: Center(
                            child: Text(
                              'Apply',
                              style: MyTexts.medium16.copyWith(
                                color: MyColors.white,
                                fontFamily: MyTexts.Roboto,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
