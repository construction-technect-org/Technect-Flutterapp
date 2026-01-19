import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/AddManufacturerAddress/controller/add_manufacturer_address_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';

class AddManufacturerAddressView
    extends GetView<AddManufacturerAddressController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: const CommonAppBar(
            title: Text("Add Manufacturer Address"),
            isCenter: false,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "Add your manufacturer address for better service",
                  style: MyTexts.medium14.copyWith(color: MyColors.shadeOfGray),
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GooglePlaceAutoCompleteTextField(
                  textEditingController: controller.searchController,
                  googleAPIKey: "AIzaSyAgyOP5KnUC1XJlmp2q7lVBsWpaF6ZsT9Q",
                  focusNode: controller.googleFocusNode,
                  inputDecoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 18, right: 8),
                      child: SvgPicture.asset(
                        Asset.searchIcon,
                        height: 16,
                        width: 16,
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
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
                      controller.selectedAddress.value =
                          prediction.description ?? '';
                      controller.searchController.text =
                          prediction.description ?? '';
                    }
                  },
                  itemClick: (Prediction prediction) {
                    controller.searchController.text =
                        prediction.description ?? '';
                    controller
                        .searchController
                        .selection = TextSelection.fromPosition(
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
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
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
                    CommonTextField(
                      headerText: "Address Name",
                      hintText:
                          'Enter address name (e.g., Main Office, Factory)',
                      controller: controller.addressNameController,
                    ),
                    SizedBox(height: 1.5.h),
                    CommonTextField(
                      headerText: "Landmark",
                      hintText: "Enter landmark",
                      controller: controller.landmarkController,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Shipping Address",
                  style: MyTexts.medium14.copyWith(color: Colors.black),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Chip(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        side: const BorderSide(
                          color: MyColors.grey,
                          width: 1.0,
                        ),

                        label: Text(
                          "Manufacturing Unit",
                          style: MyTexts.medium14.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Chip(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        side: const BorderSide(
                          color: MyColors.grey,
                          width: 1.0,
                        ),

                        label: Text(
                          "Stockyard",
                          style: MyTexts.medium14.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Chip(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        side: const BorderSide(
                          color: MyColors.grey,
                          width: 1.0,
                        ),

                        label: Text(
                          "Warehouse",
                          style: MyTexts.medium14.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => controller.selectedAddress.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: MyColors.veryPaleBlue,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: MyColors.verypaleBlue),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: MyColors.black,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  controller.selectedAddress.value,
                                  style: MyTexts.medium14.copyWith(
                                    color: MyColors.black,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Obx(
                  () => RoundedButton(
                    buttonName: controller.isEditMode.value
                        ? 'Update'
                        : 'Submit',
                    onTap: controller.submitManufacturerAddress,
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
