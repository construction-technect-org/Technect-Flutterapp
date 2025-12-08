import 'package:construction_technect/app/core/utils/imports.dart';

class VrmBottomController extends GetxController {
  final isBottomSheetOpen = false.obs;
  final currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
