import 'package:construction_technect/app/core/utils/imports.dart';

class VRMBottomController extends GetxController {
  final isBottomSheetOpen = false.obs;
  final currentIndex = 1.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
