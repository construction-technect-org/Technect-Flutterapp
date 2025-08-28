import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:construction_technect/app/core/utils/constants.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/text_theme.dart';
import 'package:construction_technect/app/modules/location/controller/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LocationView extends GetView<LocationController> {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
      
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.fontBlack,
                          fontFamily: MyTexts.Roboto,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      "Select your location for better tracking",
                      style: MyTexts.medium16.copyWith(
                        color: MyColors.shadeOfGray,
                        fontFamily: MyTexts.Roboto,
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Search Bar (bind with controller)
                  TextField(
                    onChanged: controller.updateSearch,
                    style: const TextStyle(fontSize: 14),
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
                      hintStyle: MyTexts.medium16.copyWith(
                        color: MyColors.darkGrayishRed,
                        fontFamily: MyTexts.Roboto,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: MyColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22.5),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Add Location Options
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Add manually
                          ListTile(
                            onTap: () {
                          Get.toNamed(Routes.ADDLOCATIONMANUALLY);

                            },
                            leading: const Icon(
                              Icons.add,
                              color: MyColors.primary,
                              size: 14,
                            ),
                            title: Text(
                              "Add Location Manually",
                              style: MyTexts.medium16.copyWith(
                                color: MyColors.fontBlack,
                                fontSize: 11,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                          ),

                          const Divider(height: 1, thickness: 0.5),

                          // Use current location
                          ListTile(
                            onTap: () {
                              controller.useCurrentLocation();
                              //  Get.to(() => const CurrentLocationView());
                            },
                            leading: const Icon(
                              Icons.my_location,
                              color: MyColors.primary,
                              size: 14,
                            ),
                            title: Text(
                              "Use your Current Location",
                              style: MyTexts.medium16.copyWith(
                                color: MyColors.fontBlack,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),

            // ℹ Info
            Center(
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // ✅ center horizontally
                crossAxisAlignment:
                    CrossAxisAlignment.center, // ✅ align vertically
                children: [
                  SvgPicture.asset(
                    Asset.Locationon,
                    height: 20, // adjust size if needed
                    width: 20,
                  ),
                  const SizedBox(width: 11),
                  Text(
                    "Drag the pin for your location",
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.redgray,
                      fontFamily: MyTexts.Roboto,
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            // Map Preview
            Container(
              width: 321,
              height: 377,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset("assets/images/map.png", fit: BoxFit.cover),
              ),
            ),

            // Submit Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 25),
              child: RoundedButton(
                buttonName: 'SUBMIT',
                onTap: () {
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
