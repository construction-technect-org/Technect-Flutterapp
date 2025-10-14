import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSiteLocation/controllers/connector_site_location_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';

class ConnectorSiteLocationView extends GetView<ConnectorSiteLocationController> {
  const ConnectorSiteLocationView({super.key});

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
                      "ADD SITE LOCATION",
                      style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.4.h),

              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Add your site location for better tracking",
                  style: MyTexts.medium14.copyWith(color: MyColors.shadeOfGray),
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GooglePlaceAutoCompleteTextField(
                  textEditingController: controller.searchController,
                  googleAPIKey: "AIzaSyAgyOP5KnUC1XJlmp2q7lVBsWpaF6ZsT9Q",
                  inputDecoration: InputDecoration(
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
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22.5),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    filled: true,
                    fillColor: MyColors.white,
                  ),
                  debounceTime: 800,
                  countries: const ["in"],
                  getPlaceDetailWithLatLng: (Prediction prediction) {
                    if (prediction.lat != null && prediction.lng != null) {
                      final LatLng newPosition = LatLng(
                        double.parse(prediction.lat!),
                        double.parse(prediction.lng!),
                      );
                      controller.isSearching.value = true;
                      controller.mapController.animateCamera(
                        CameraUpdate.newLatLngZoom(newPosition, 16.0),
                      );

                      controller.currentPosition.value = newPosition;
                      controller.selectedAddress.value = prediction.description ?? '';
                      controller.searchController.text = prediction.description ?? '';
                    }
                  },
                  itemClick: (Prediction prediction) {
                    controller.searchController.text = prediction.description ?? '';
                    controller.searchController.selection = TextSelection.fromPosition(
                      TextPosition(offset: prediction.description?.length ?? 0),
                    );
                  },
                  itemBuilder: (context, index, Prediction prediction) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: MyColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              prediction.description ?? '',
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.fontBlack,
                                fontFamily: MyTexts.SpaceGrotesk,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  containerHorizontalPadding: 10,
                  placeType: PlaceType.geocode,
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(height: 1.h),
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
                        fontFamily: MyTexts.SpaceGrotesk,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      // Google Map
                      GoogleMap(
                        onMapCreated: controller.onMapCreated,
                        onCameraMove: controller.onCameraMove,
                        onCameraIdle: controller.onCameraIdle,
                        initialCameraPosition: CameraPosition(
                          target: controller.currentPosition.value,
                          zoom: controller.mapZoom.value,
                        ),
                        mapType: controller.mapType.value,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        mapToolbarEnabled: false,
                      ),
                      // Center Pin Icon
                      const Center(
                        child: Icon(Icons.location_on, color: Colors.red, size: 40),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Site Name",
                      style: MyTexts.medium14.copyWith(
                        color: MyColors.fontBlack,
                        fontFamily: MyTexts.SpaceGrotesk,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: MyColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: TextFormField(
                        controller: controller.siteNameController,
                        style: MyTexts.regular14.copyWith(
                          color: MyColors.darkGray,
                          fontFamily: MyTexts.SpaceGrotesk,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter site name',
                          hintStyle: MyTexts.regular14.copyWith(
                            color: MyColors.darkGray.withValues(alpha: 0.6),
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.5.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Landmark",
                      style: MyTexts.medium14.copyWith(
                        color: MyColors.fontBlack,
                        fontFamily: MyTexts.SpaceGrotesk,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: MyColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: TextFormField(
                        controller: controller.landmarkController,
                        style: MyTexts.regular14.copyWith(
                          color: MyColors.darkGray,
                          fontFamily: MyTexts.SpaceGrotesk,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter landmark',
                          hintStyle: MyTexts.regular14.copyWith(
                            color: MyColors.darkGray.withValues(alpha: 0.6),
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Obx(
                () => controller.selectedAddress.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: MyColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: MyColors.primary.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: MyColors.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  controller.selectedAddress.value,
                                  style: MyTexts.regular12.copyWith(
                                    color: MyColors.primary,
                                    fontFamily: MyTexts.SpaceGrotesk,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Obx(
                  () => RoundedButton(
                    buttonName: controller.isEditMode.value ? 'UPDATE' : 'SUBMIT',
                    onTap: controller.submitSiteLocation,
                  ),
                ),
              ),
              SizedBox(height: 1.h),
            ],
          ),
        ),
      ),
    );
  }
}
