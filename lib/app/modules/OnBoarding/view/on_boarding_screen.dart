import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
//import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/views/sign_up_details_view.dart';
import 'package:construction_technect/app/modules/OnBoarding/controller/on_boarding_controller.dart';
import 'package:flutter/scheduler.dart';

class OnboardingScreen extends GetView<OnBoardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.white, // ✅ status bar color
            statusBarIconBrightness: Brightness.dark, // ✅ icons dark
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(),
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
                    Stack(
                      children: [
                        /// ✅ Background Map Image — clean show hoga
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.4,
                            child: Image.asset(
                              Asset.locationImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        /// ✅ Carousels on top — no overlay
                        Column(
                          children: [
                            Gap(3.h),

                            const AutoScrollRow(
                              images: [
                                Asset.role1,
                                Asset.houseOwner,
                                Asset.architect,
                              ],
                            ),

                            Gap(1.h),

                            const AutoScrollRow(
                              images: [
                                Asset.design,
                                Asset.contractor,
                                Asset.other,
                              ],
                              reverse: true, // opposite direction
                            ),

                            Gap(1.h),

                            const AutoScrollRow(
                              images: [
                                Asset.role1,
                                Asset.houseOwner,
                                Asset.architect,
                              ],
                            ),

                            Gap(6.h),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Column(
                        children: [
                          Text(
                            "Connecting Construction Worldwide",
                            style: MyTexts.medium16,
                          ),
                          Gap(1.5.h),
                          RoundedButton(
                            buttonName: 'Login',
                            onTap: () async {
                              // final bool isLocationReady = await controller
                              //     .checkLocation();
                              // if (isLocationReady) {
                                controller.showLoginBottomSheet();
                              // }
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
                              if (Get.isBottomSheetOpen == true) return;
                              // final bool isLocationReady = await controller
                              //     .checkLocation();
                              // if (isLocationReady) {
                                controller.showBottomSheet();
                              // }

                              // Get.toNamed(Routes.OTP_Verification);
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
                        ],
                      ),
                    )

                    //const Gap(32),
                  ],
                ),
              ),
            ),
          ))
      ),
    );
  }

  Widget getCarouselItems(String imagePath) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h, right: 2.w),
      child: Container(
        width: 35.w,
        height: 5.h, // ✅ responsive
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          border: Border.all(color: Colors.grey.withOpacity(0.15)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(0.5.h), // ✅ responsive padding
          child: Center(
            child: Image.asset(
              imagePath,
              width: 20.w,  // ✅ responsive
              height: 20.h, // ✅ responsive
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }}

class AutoScrollRow extends StatefulWidget {
  final List<String> images;
  final bool reverse;

  const AutoScrollRow({
    super.key,
    required this.images,
    this.reverse = false,
  });

  @override
  State<AutoScrollRow> createState() => _AutoScrollRowState();
}

class _AutoScrollRowState extends State<AutoScrollRow>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _ticker = createTicker((_) {
      if (!_controller.hasClients) return;

      final maxScroll = _controller.position.maxScrollExtent;
      final minScroll = _controller.position.minScrollExtent;

      double newOffset =
          _controller.offset + (widget.reverse ? -1.1 : 1.4); // 👈 slow speed

      if (newOffset >= maxScroll) {
        newOffset = minScroll;
      } else if (newOffset <= minScroll) {
        newOffset = maxScroll;
      }

      _controller.jumpTo(newOffset);
    });

    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18.h,
      child: ListView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        reverse: widget.reverse,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.images.length * 20,
        itemBuilder: (context, index) {
          final image =
          widget.images[index % widget.images.length];

          return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              width: 30.w,
              height: 11.h, // 👈 pehle approx 18.h area me tha, ab 5.h kam
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                border: Border.all(color: Colors.grey.withOpacity(0.15)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(1.h),
                child: Center(
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          );
        },
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
