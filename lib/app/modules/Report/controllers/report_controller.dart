import 'package:construction_technect/app/core/utils/imports.dart';

class ReportController extends GetxController {
  final statusCards = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  RxBool isReport = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
      isReport.value = Get.arguments["isReport"];
    }
  }
}
