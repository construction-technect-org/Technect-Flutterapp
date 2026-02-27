import 'package:construction_technect/app/core/utils/imports.dart';

class BottomController extends GetxController {
  final isBottomSheetOpen = false.obs;
  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, dynamic> && args.containsKey('index')) {
      currentIndex.value = args['index'] as int;
    }
  }
}
