import 'package:construction_technect/app/core/utils/imports.dart';

class BottomController extends GetxController {
  final currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
