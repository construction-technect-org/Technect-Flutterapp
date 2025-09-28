import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/FeedBack/service/FeedBackService.dart';

class FeedBackController extends GetxController {
  final suggestionController = TextEditingController();
  RxInt rating = 0.obs;
  RxBool isLoading = false.obs;

  Future<void> addFeedBack() async {
    if (rating.value == 0) {
      SnackBars.errorSnackBar(content: "Please give rate");
      return;
    } else if (suggestionController.text.isEmpty) {
      SnackBars.errorSnackBar(content: "Please add feedback/suggection");
      return;
    }
    isLoading.value = true;

    try {
      final result = await FeedbackService.addFeedback(
        text: suggestionController.text,
        rating: rating.value,
      );

      if (result != null && result.success) {
        suggestionController.text = "";
        rating.value = 0;
        Get.back();
        SnackBars.successSnackBar(content: result.message);
      } else {
        Get.snackbar("Failed", result?.message ?? "Something went wrong");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
