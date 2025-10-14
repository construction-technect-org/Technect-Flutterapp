import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/OnBoarding/controller/on_boarding_controller.dart';
import 'package:gap/gap.dart';

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
