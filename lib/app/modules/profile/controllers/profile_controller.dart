import 'package:construction_technect/app/core/utils/imports.dart';

class ProfileController extends GetxController {
  final selectedTabIndex = 0.obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
