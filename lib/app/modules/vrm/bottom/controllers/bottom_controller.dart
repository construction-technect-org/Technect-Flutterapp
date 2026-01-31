import 'package:construction_technect/app/core/utils/imports.dart';

class VRMBottomController extends GetxController {
  final isBottomSheetOpen = false.obs;
  final currentIndex = 1.obs;
  final RxString myRole = ''.obs;
  void changeTab(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    print("MyRole ${myPref.role.val}");
    myRole.value = myPref.role.val;
    print("MyRole $myRole");
  }
}
