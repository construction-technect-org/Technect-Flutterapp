import 'package:construction_technect/app/core/utils/custom_snackbar.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/RequestDemo/service/RequestDemoService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RequestDemoController extends GetxController {
  final List<String> mainCategories = [
    "Construction",
    "Electrical",
    "Plumbing",
    "Interior",
    "Painting",
  ];
  RxInt isValid = (-1).obs;
  RxString countryCode = "".obs;

  RxString selectedMainCategory = "".obs;
  bool isEdit = false;
  final RxBool showVideo = false.obs;

  final phoneNumberController = TextEditingController();
  final emilaController = TextEditingController();

  late YoutubePlayerController youtubeController;

  final String videoUrl = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';

  Future<void> addRequestDemo() async {
    try {
      final result = await RequestDemoService.addRequestDemo(
        demoFor: selectedMainCategory.value,
        email: emilaController.text,
        phone: phoneNumberController.text,
      );

      if ((result?.success ?? false) == true) {
        selectedMainCategory.value = "";
        emilaController.text = "";
        phoneNumberController.text = "";
        Get.back();
        SnackBars.successSnackBar(content: result?.message ?? '');
      } else {
        selectedMainCategory.value = "";
        emilaController.text = "";
        phoneNumberController.text = "";
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {}
  }

  @override
  void onInit() {
    super.onInit();
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    youtubeController = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
  }

  void onMainCategorySelected(String? value) {
    if (value != null) {
      selectedMainCategory.value = value;
    }
  }

  void playVideo() {
    showVideo.value = true;
    youtubeController.play();
  }

  @override
  void onClose() {
    youtubeController.pause();
    youtubeController.dispose();
    super.onClose();
  }
}
