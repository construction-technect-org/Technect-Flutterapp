import 'package:construction_technect/app/core/utils/imports.dart';

class ReportController extends GetxController {
  final statusCards = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  RxBool isLoading = false.obs;
}
