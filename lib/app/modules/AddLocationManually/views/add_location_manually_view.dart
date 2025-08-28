import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/text_theme.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/modules/AddLocationManually/controller/add_location_manually_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ use full get import

class AddLocationManuallyView extends GetView<AddLocationController> {
  const AddLocationManuallyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                          child: const Icon(Icons.arrow_back_ios,
                              size: 20, color: Colors.black),
                        ),
                        const SizedBox(width: 8),
                        Text("Add Location Manually",
                            style: MyTexts.medium16.copyWith(
                              color: MyColors.fontBlack,
                              fontFamily: MyTexts.Roboto,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            )),
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

                    // Search Bar
                    TextField(
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

                    SizedBox(height: 2.h),
                    // Address Line 1
                       SizedBox(height: 2.h),

                    // Example repeated fields
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
                    const CustomTextField(),
                    SizedBox(height: 2.h),

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
                    const CustomTextField(),
  SizedBox(height: 2.h),

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
                    const CustomTextField(),  SizedBox(height: 2.h),

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
                    const CustomTextField(),
                      SizedBox(height: 2.h),

                    Row(
                      children: [
                        Text(
                          'Pin Code*',
                          style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                        ),
                        Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    const CustomTextField(),

                        Padding(
                padding:
                     const EdgeInsets.symmetric(horizontal: 26, vertical: 25),
                child: RoundedButton(
                  buttonName: 'SUBMIT',
                  onTap: () => controller.submitLocation(),
                ),
              ),
          
                    // 🔽 (You can keep your other repeated fields here)
                  ],
                ),
              ),

             ],
                )),

           
            
          ),
        );
  }
}

