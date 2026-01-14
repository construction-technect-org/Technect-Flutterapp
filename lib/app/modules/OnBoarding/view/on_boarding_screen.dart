import 'package:construction_technect/app/core/utils/common_fun.dart';
//import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/views/sign_up_details_view.dart';
import 'package:construction_technect/app/modules/OnBoarding/controller/on_boarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:construction_technect/app/core/utils/imports.dart';

class OnboardingScreen extends GetView<OnBoardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                children: [
                  /* Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          const Size(75, 28),
                        ),
                        backgroundColor: WidgetStateProperty.all(Colors.white),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),

                            side: const BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                      child: Text("Skip Login", style: MyTexts.regular14),
                    ),
                  ), */
                  //const Gap(16),
                  CarouselSlider(
                    items: [
                      getCarouselItems(Asset.role1),
                      getCarouselItems(Asset.houseOwner),
                      getCarouselItems(Asset.architect),
                    ],
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 20.h,
                      //aspectRatio: 11 / 5,
                      viewportFraction: .7,
                      autoPlayInterval: const Duration(seconds: 2), // wait time
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 900,
                      ), // slide speed
                      autoPlayCurve: Curves.easeInOut,
                      onPageChanged: (index, reason) {},
                    ),
                  ),
                  Gap(1.h),
                  CarouselSlider(
                    items: [
                      getCarouselItems(Asset.design),
                      getCarouselItems(Asset.contractor),
                      getCarouselItems(Asset.other),
                    ],
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 20.h,
                      // aspectRatio: 11 / 5,
                      viewportFraction: .7,
                      autoPlayInterval: const Duration(seconds: 2), // wait time
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 500,
                      ), // slide speed
                      autoPlayCurve: Curves.easeInOut,
                      onPageChanged: (index, reason) {},
                    ),
                  ),
                  Gap(1.h),
                  CarouselSlider(
                    items: [
                      getCarouselItems(Asset.role1),
                      getCarouselItems(Asset.houseOwner),
                      getCarouselItems(Asset.architect),
                    ],
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 20.h,
                      //aspectRatio: 11 / 5,
                      viewportFraction: .7,
                      autoPlayInterval: const Duration(seconds: 2), // wait time
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 700,
                      ), // slide speed
                      autoPlayCurve: Curves.easeInOut,
                      onPageChanged: (index, reason) {},
                    ),
                  ),
                  Gap(2.h),
                  Text(
                    "Connecting Construction Worldwide",
                    style: MyTexts.medium16,
                  ),
                  Gap(1.5.h),
                  RoundedButton(
                    buttonName: 'Login',
                    onTap: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                  ),
                  Gap(1.5.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: MyColors.grayD4,
                          indent: 10.sw,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Text(
                          'Or',
                          style: MyTexts.medium13.copyWith(
                            color: MyColors.greySecond,
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: MyColors.grayD4,
                          endIndent: 10.sw,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),

                  Gap(1.5.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: MyColors.grayD4),
                          ),
                          height: 4.sh,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset(Asset.googleIcon),
                          ),
                        ),
                        onTap: () {},
                      ),
                      SizedBox(width: 10.sw),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: MyColors.grayD4),
                          ),
                          height: 4.sh,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset(Asset.facebookIcon),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),

                  Gap(1.5.h),
                  GestureDetector(
                    onTap: () {
                      //if (Get.isBottomSheetOpen == true) return;
                      controller.showBottomSheet();
                      //Get.toNamed(Routes.SIGN_UP_DETAILS);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: MyTexts.regular16.copyWith(
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                        ),
                        Text(
                          "Sign-up",
                          style: MyTexts.bold16.copyWith(
                            color: MyColors.primary,
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //const Gap(32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getCarouselItems(String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8),
      child: Container(
        width: 50.w,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: MyColors.gra54EA),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        imagePath,
                        width: 100,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/OnBoarding/controller/on_boarding_controller.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      {
        "image": Asset.ob1,
        "title": "Building the Future, Connecting the World",
        "desc":
            "Delivering Excellence in Construction Across Continents – One Project at a Time",
      },
      {
        "image": Asset.ob1,
        "title": "Smart Solutions for Modern Infrastructure",
        "desc": "Empowering businesses with advanced construction technology.",
      },
      {
        "image": Asset.ob1,
        "title": "Safety, Quality, and Reliability",
        "desc": "We ensure every project meets the highest global standards.",
      },
      {
        "image": Asset.ob1,
        "title": "Let’s Build Together!",
        "desc": "Join us and be part of the future of construction excellence.",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Obx(
                () => Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      if (controller.currentIndex.value < 3) {
                        controller.skip();
                      }
                    },
                    child: Text(
                      "Skip",
                      style: MyTexts.medium16.copyWith(
                        color: controller.currentIndex.value < 3
                            ? MyColors.primary
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(20),
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: pages.length,
                  onPageChanged: controller.onPageChanged,
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Image.asset(
                            page["image"]!,
                            height: MediaQuery.of(context).size.height / 2,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          page["title"]!,
                          textAlign: TextAlign.center,
                          style: MyTexts.bold18.copyWith(
                            color: MyColors.gray2E,
                          ),
                        ),
                        const Gap(12),
                        Text(
                          page["desc"]!,
                          textAlign: TextAlign.center,
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.gray2E,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const Gap(24),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: controller.currentIndex.value == index ? 16 : 8,
                      decoration: BoxDecoration(
                        color: controller.currentIndex.value == index
                            ? MyColors.primary
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(24),
              Obx(
                () => RoundedButton(
                  buttonName: controller.currentIndex.value == 3
                      ? "Get Started"
                      : "Next",
                  onTap: controller.nextPage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
