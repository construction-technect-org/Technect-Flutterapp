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
  final PhoneNumberController = TextEditingController();
  final emilaController = TextEditingController();

  late YoutubePlayerController youtubeController;

  final String videoUrl = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';

 @override
void onInit() {
  super.onInit();
  final videoId = YoutubePlayer.convertUrlToId(videoUrl);
  youtubeController = YoutubePlayerController(
    initialVideoId: videoId ?? '',
    flags: const YoutubePlayerFlags(
      autoPlay: false,  // <-- Don't auto play on init
      mute: false,
    ),
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
