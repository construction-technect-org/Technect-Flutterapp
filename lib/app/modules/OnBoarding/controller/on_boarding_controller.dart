import 'package:construction_technect/app/core/utils/imports.dart';

class OnBoardingController extends GetxController {
  RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();

  void nextPage() {
    if (currentIndex.value < 3) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      getStarted();
    }
  }

  void skip() {
    pageController.jumpToPage(3);
  }

  void getStarted() {
    Get.offAllNamed(Routes.LOGIN);
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }
}
