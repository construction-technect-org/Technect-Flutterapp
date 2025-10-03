import 'package:construction_technect/app/core/utils/custom_snackbar.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorRequestDemo/service/RequestDemoService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ConnectorRequestDemoController extends GetxController {
  final List<String> mainCategories = [
    "Construction",
    "Electrical",
    "Plumbing",
    "Interior",
    "Painting",
  ];

  RxString selectedMainCategory = "".obs;
  bool isEdit = false;
  final RxBool showVideo = false.obs;

  // ignore: non_constant_identifier_names
  final phoneNumberController = TextEditingController();
  final emilaController = TextEditingController();

  late YoutubePlayerController youtubeController;

  final String videoUrl = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';

  Future<void> addRequestDemo() async {
    if (selectedMainCategory.value.isEmpty) {
      SnackBars.errorSnackBar(content: "Select demo category");
      return;
    }
    if (phoneNumberController.text.isEmpty) {
      SnackBars.errorSnackBar(content: "Please fill phone number ");
      return;
    } else if (int.parse(phoneNumberController.text) == 10) {
      SnackBars.errorSnackBar(content: "Please fill valid phone number ");
      return;
    }
    if (emilaController.text.isEmpty) {
      SnackBars.errorSnackBar(content: "Please fill email address");
      return;
    } else if (!GetUtils.isEmail(emilaController.text)) {
      SnackBars.errorSnackBar(content: 'Please enter a valid email');
      return;
    }
    try {
      final result = await RequestDemoService.addRequestDemo(
        demoFor: selectedMainCategory.value,
        email: emilaController.text,
        phone: phoneNumberController.text,
      );

      if (result != null && result.success) {
        selectedMainCategory.value = "";
        emilaController.text = "";
        phoneNumberController.text="";
        Get.back();
        SnackBars.successSnackBar(content: result.message);
      } else {
        selectedMainCategory.value = "";
        emilaController.text = "";
        phoneNumberController.text="";

      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
    }
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

  // Handlers
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
