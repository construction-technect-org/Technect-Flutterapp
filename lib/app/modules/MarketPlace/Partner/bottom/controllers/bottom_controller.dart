import 'package:construction_technect/app/core/utils/imports.dart';

class BottomController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final isBottomSheetOpen = false.obs;
  final currentIndex = 0.obs;
}
