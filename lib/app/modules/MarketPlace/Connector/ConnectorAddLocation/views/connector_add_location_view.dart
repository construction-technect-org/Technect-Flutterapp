import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorAddLocation/controllers/connector_add_location_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConnectorAddLocationView extends GetView<ConnectorAddLocationController> {
  const ConnectorAddLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Back + Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
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
                      "ADD LOCATION",
                      style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.4.h),

              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Select your location for better tracking",
                  style: MyTexts.medium14.copyWith(color: MyColors.shadeOfGray),
                ),
              ),

               SizedBox(height: 2.h),

              // ✅ Search Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      fontFamily: MyTexts.Roboto,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 8),
                        child: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      hintText: 'Search for area, street name..',
                      hintStyle: MyTexts.regular14.copyWith(
                        color: MyColors.darkGray,
                        fontFamily: MyTexts.Roboto,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22.5),
                        borderSide: BorderSide.none,
                      ),
                      // 👇 Center text & hint vertically
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.h),

              // ✅ Info
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Asset.Locationon, height: 20, width: 20),
                    const SizedBox(width: 11),
                    Text(
                      "Drag the pin for your location",
                      style: MyTexts.regular14.copyWith(
                        color: MyColors.redgray,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: RoundedButton(buttonName: 'SUBMIT', onTap: () {
                  Get.toNamed(Routes.CONNECTOR_ADD_LOCATION_MANUALLY);

                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
