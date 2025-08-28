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
      backgroundColor: MyColors.white,
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
                         SizedBox(width: 0.8.h),
                        Text("Add Location Manually",
                            style: MyTexts.medium18.copyWith(
                        color: MyColors.fontBlack,
                      ),),
                      ],
                    ),
                   SizedBox(height: 0.4.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Select your location for better tracking",
                       style: MyTexts.medium14.copyWith(
                      color: MyColors.shadeOfGray,
                    ),
                      ),
                    ),

                     SizedBox(height: 4.h),

                    // Search Bar
                              Container(
  decoration: BoxDecoration(
    color: MyColors.white,
    borderRadius: BorderRadius.circular(22.5),
    boxShadow: const [
      BoxShadow(
        color: Color(0x1A000000), // light shadow (10% black)
        blurRadius: 8,           // soften the shadow
        offset: Offset(0, 4),    // move shadow down
      ),
    ],
  ),
  child: TextField(
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
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22.5),
        borderSide: BorderSide.none,
      ),
      suffixIcon: Padding(
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
                     const EdgeInsets.symmetric(vertical: 25),
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

