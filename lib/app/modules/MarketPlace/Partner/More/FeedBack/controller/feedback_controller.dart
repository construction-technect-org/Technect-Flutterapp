import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/FeedBack/service/FeedBackService.dart';

class FeedBackController extends GetxController {
  final suggestionController = TextEditingController();
  RxInt rating = 0.obs;
  RxBool isLoading = false.obs;
  final FeedbackService _service = FeedbackService();
  Future<void> addFeedBack() async {
    if (rating.value == 0) {
      SnackBars.errorSnackBar(content: "Please give rate");
      return;
    }
    isLoading.value = true;

    try {
      final result = await _service.addFeedback(
        text: suggestionController.text,
        rating: rating.value,
      );

      if (result.success == true) {
        suggestionController.text = "";
        rating.value = 0;
        Get.back();
      }
    } catch (e) {
      // No Error show
    } finally {
      isLoading.value = false;
    }
  }
}
