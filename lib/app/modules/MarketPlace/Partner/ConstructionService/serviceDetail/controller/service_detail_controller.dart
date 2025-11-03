
import 'package:construction_technect/app/core/utils/imports.dart';

import 'package:get/get.dart';
import 'dart:io';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/all_service_model.dart';
import 'package:video_player/video_player.dart';

class ServiceDetailController extends GetxController {
  Service service = Service();

  ProfileModel profileData = ProfileModel.fromJson(myPref.getProfileData() ?? {});
  final RxBool isFromAdd = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLiked = false.obs;
  final RxInt currentIndex = 0.obs;

  VideoPlayerController? videoPlayerController;
  // final VoidCallback? onApiCall = Get.arguments?['onApiCall'] ?? () {};

  Rx<Service> serviceDetailsModel = Service().obs;

  @override
  void onInit() {
    super.onInit();
    final argument = Get.arguments as Map?;
    service = argument?['service'] ?? Service();
    isFromAdd.value = argument?['isFromAdd'] ?? false;

    if (!isFromAdd.value) {
      // fetchServiceDetails(service.id ?? 0);
      WidgetsBinding.instance.addPostFrameCallback((val) async {
        if (service.media?.isNotEmpty == true) {
          videoPlayerController = VideoPlayerController.networkUrl(
            Uri.parse(APIConstants.bucketUrl + service.media!.first.toString()),
          );
          await videoPlayerController?.initialize();
        }
      });
    }
  }

  // Future<void> fetchServiceDetails(int id) async {
  //   try {
  //     isLoading.value = true;
  //     final result = await _service.getServiceDetails(id: id.toString());
  //     if (result != null && result.success == true) {
  //       serviceDetailsModel.value = result.data ?? Service();
  //     }
  //   } catch (e) {
  //     if (kDebugMode) print(e);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  void onEditService() {
    Get.toNamed(
      Routes.ADD_SERVICES,
      arguments: {"isEdit": true, 'service': service,

        // "onApiCall": onApiCall
      },
    );
  }

  void openVideoDialog(BuildContext context, String videoPath, bool isNetwork) {
    final playerController = isNetwork
        ? VideoPlayerController.network(videoPath)
        : VideoPlayerController.file(File(videoPath));

    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: FutureBuilder(
            future: playerController.initialize(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                playerController.play();
                return AspectRatio(
                  aspectRatio: playerController.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      VideoPlayer(playerController),
                      VideoProgressIndicator(
                        playerController,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                          backgroundColor: MyColors.grayEA,
                          playedColor: MyColors.primary,
                          bufferedColor: MyColors.grayEA,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            playerController.pause();
                            playerController.dispose();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      },
    );
  }
}
