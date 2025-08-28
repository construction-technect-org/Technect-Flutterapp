import 'package:get/get.dart';

class AddLocationController extends GetxController {
  // Form fields
  RxString addressLine1 = ''.obs;
  RxString addressLine2 = ''.obs;
  RxString landmark = ''.obs;
  RxString cityState = ''.obs;
  RxString pinCode = ''.obs;

  // Example: Validation / submit logic
  void submitLocation() {
    if (addressLine1.isEmpty ||
        landmark.isEmpty ||
        cityState.isEmpty ||
        pinCode.isEmpty) {
      Get.snackbar("Error", "Please fill all required fields");
      return;
    }
    Get.snackbar("Success", "Location saved successfully!");
    // TODO: Call API or save data
  }
}
