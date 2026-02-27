import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/controller/add_delivery_address_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class AddDeliveryAddressView extends GetView<AddDeliveryAddressController> {
  const AddDeliveryAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: MyColors.white,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 70,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Get.back(),
                ),
              ),
            ),
            title: Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  controller.isEditMode.value ? "Edit Address" : "Add Address",
                  style: MyTexts.bold16.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              // 1. Full Screen Map
              Obx(
                () => GoogleMap(
                  onMapCreated: controller.onMapCreated,
                  onCameraMove: controller.onCameraMove,
                  onCameraIdle: controller.onCameraIdle,
                  initialCameraPosition: CameraPosition(
                    target: controller.currentPosition.value,
                    zoom: controller.mapZoom.value,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  mapToolbarEnabled: false,
                  zoomControlsEnabled: false,
                  padding: EdgeInsets.only(bottom: 30.h, top: 120),
                ),
              ),

              // 2. Fixed Center Pin
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 35),
                  child: Icon(Icons.location_on, color: Colors.redAccent, size: 45),
                ),
              ),

              // 3. Floating Search Bar
              Positioned(
                top: MediaQuery.of(context).padding.top + 70,
                left: 16,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: GooglePlaceAutoCompleteTextField(
                    textEditingController: controller.searchController,
                    googleAPIKey: "AIzaSyAgyOP5KnUC1XJlmp2q7lVBsWpaF6ZsT9Q",
                    focusNode: controller.googleFocusNode,
                    inputDecoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 40),
                      hintText: 'Search for area, street name..',
                      hintStyle: MyTexts.regular14.copyWith(color: MyColors.darkGray),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    debounceTime: 600,
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
                    },
                  ),
                ),
              ),

              // 4. Draggable Bottom Sheet for Form
              DraggableScrollableSheet(
                initialChildSize: 0.35,
                minChildSize: 0.3,
                maxChildSize: 0.95,
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 5),
                      ],
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const Gap(24),
                          Text("Add address label", style: MyTexts.bold16),
                          const Gap(12),
                          Obx(
                            () => Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: controller.labelOptions.map((label) {
                                final isSelected = controller.selectedLabel.value == label;
                                return GestureDetector(
                                  onTap: () => controller.selectedLabel.value = label,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected ? MyColors.primary : MyColors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                        color: isSelected ? MyColors.primary : MyColors.grayEA,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: MyColors.primary.withOpacity(0.3),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Text(
                                      label,
                                      style: MyTexts.medium14.copyWith(
                                        color: isSelected ? Colors.white : MyColors.fontBlack,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const Gap(24),
                          Text("Address Details", style: MyTexts.bold16),
                          const Gap(16),
                          CommonTextField(
                            headerText: "House no. and floor",
                            hintText: "Enter house no. and floor",
                            controller: controller.houseNoController,
                          ),
                          const Gap(16),
                          CommonTextField(
                            headerText: "Building and block number (Optional)",
                            hintText: "Enter building and block number",
                            controller: controller.buildingBlockController,
                          ),
                          const Gap(16),
                          CommonTextField(
                            headerText: "Landmark and Area name (Optional)",
                            hintText: "Enter landmark or area",
                            controller: controller.landmarkAreaController,
                          ),
                          const Gap(16),
                          Row(
                            children: [
                              Expanded(
                                child: CommonTextField(
                                  headerText: "Pincode",
                                  hintText: "Pincode",
                                  controller: controller.pincodeController,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const Gap(16),
                              Expanded(
                                child: CommonTextField(
                                  headerText: "City",
                                  hintText: "City",
                                  controller: controller.cityController,
                                ),
                              ),
                            ],
                          ),
                          const Gap(16),
                          Row(
                            children: [
                              Expanded(
                                child: CommonTextField(
                                  headerText: "State",
                                  hintText: "State",
                                  controller: controller.stateController,
                                ),
                              ),
                              const Gap(16),
                              Expanded(
                                child: CommonTextField(
                                  headerText: "Country",
                                  hintText: "Country",
                                  controller: controller.countryController,
                                ),
                              ),
                            ],
                          ),
                          const Gap(32),
                          SizedBox(
                            width: double.infinity,
                            child: Obx(
                              () => RoundedButton(
                                buttonName: controller.isEditMode.value
                                    ? 'Update Address'
                                    : 'Save Address',
                                onTap: controller.submitDeliveryAddress,
                                height: 55,
                                borderRadius: 12,
                                color: MyColors.primary,
                              ),
                            ),
                          ),
                          // Extra space for keyboard if needed
                          Gap(MediaQuery.of(context).viewInsets.bottom > 0 ? 300 : 50),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
