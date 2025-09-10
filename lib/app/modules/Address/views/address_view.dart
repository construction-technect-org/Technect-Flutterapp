import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Address/controller/address_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressView extends GetView<AddressController> {
  const AddressView({super.key});

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
                // Back + Title
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
                      "Add Location",
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
                        child: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      hintText: 'Search',
                      hintStyle: MyTexts.medium16.copyWith(color: MyColors.darkGray),
                      filled: true,
                      fillColor: MyColors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
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
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.grey,
                                    ),
                                  ),
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
                SizedBox(height: 2.h),

                // Add Location Options
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000), // light shadow (10% black)
                          blurRadius: 8, // soften the shadow
                          offset: Offset(0, 4), // move shadow down
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          onTap: () {
                            controller.navigateToManualAddress();
                          },
                          leading: const Icon(
                            Icons.add,
                            color: MyColors.primary,
                            size: 16,
                          ),
                          title: Text(
                            "Add Location Manually",
                            style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        ),

                        const Divider(height: 1, thickness: 0.5),

                        ListTile(
                          onTap: () {
                            controller.useCurrentLocation();
                          },
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
                        style: MyTexts.medium16.copyWith(color: MyColors.redgray),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Obx(
                        () => GoogleMap(
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
                ),
                SizedBox(height: 3.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Obx(
                    () => RoundedButton(
                      buttonName: 'SUBMIT',
                      onTap: controller.isLoading.value ? null : controller.saveLocation,
                    ),
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
