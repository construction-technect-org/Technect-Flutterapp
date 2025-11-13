import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/addService/service/add_constrcution_Service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/serviceDetail/model/service_deatil_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/all_service_model.dart';
import 'package:video_player/video_player.dart';

class ServiceDetailController extends GetxController {
  Rx<Service> service = Service().obs;

  final RxBool isLoading = false.obs;
  final RxBool isEdit = false.obs;
  final RxBool isRefVideo = false.obs;
  final RxBool isVideoReady = false.obs;
  final RxInt currentIndex = 0.obs;
  VoidCallback? onApiCall;

  VideoPlayerController? videoPlayerController;
  VideoPlayerController? refVideoPlayerController;

  @override
  void onInit() {
    super.onInit();
    final argument = Get.arguments as Map?;
    service.value = argument?['service'] ?? Service();
    onApiCall = argument?["onApiCall"];
    isEdit.value = argument?["isEdit"] ?? false;

    if (isEdit.value == false) {
      serviceDetails(service.value.id ?? 0);
    }

    WidgetsBinding.instance.addPostFrameCallback((val) async {
      if (service.value.reference != null &&
          service.value.reference?.referenceType?.toLowerCase() == 'video') {
        final referencePath =
            service.value.reference?.referenceS3Key ??
            service.value.reference?.referenceUrl ??
            "";

        if (referencePath.isNotEmpty) {
          final referenceVideoUrl = referencePath.startsWith('http')
              ? referencePath
              : APIConstants.bucketUrl + referencePath;
          log('Reference video path: $referencePath');
          log('Reference video URL: $referenceVideoUrl');

          try {
            refVideoPlayerController = VideoPlayerController.networkUrl(
              Uri.parse(referenceVideoUrl),
              httpHeaders: {
                'Range': 'bytes=0-',
                'Accept': 'video/*',
                'User-Agent': 'Mozilla/5.0',
              },
              videoPlayerOptions: VideoPlayerOptions(),
            );

            await refVideoPlayerController
                ?.initialize()
                .timeout(
                  const Duration(seconds: 30),
                  onTimeout: () {
                    log('Reference video initialization timeout');
                    throw TimeoutException(
                      'Video initialization took too long',
                    );
                  },
                )
                .then((val) {
                  isRefVideo.value = true;
                });
            log('Reference video initialized successfully');
            update();
          } catch (e) {
            log('Error initializing reference video: $e');
            if (kDebugMode) {
              print('Reference video initialization failed: $e');
            }
          }
        }
      }

      if (service.value.reference?.referenceType?.toLowerCase() != 'video' &&
          service.value.video != null) {
        final videoPath =
            service.value.video?.mediaS3Key ??
            service.value.video?.mediaUrl ??
            "";

        if (videoPath.isNotEmpty) {
          final videoUrl = videoPath.startsWith('http')
              ? videoPath
              : APIConstants.bucketUrl + videoPath;
          log('Main video path: $videoPath');
          log('Full main video URL: $videoUrl');

          try {
            videoPlayerController = VideoPlayerController.networkUrl(
              Uri.parse(videoUrl),
              httpHeaders: {
                'Range': 'bytes=0-',
                'Accept': 'video/*',
                'User-Agent': 'Mozilla/5.0',
              },
              videoPlayerOptions: VideoPlayerOptions(),
            );

            await videoPlayerController
                ?.initialize()
                .timeout(
                  const Duration(seconds: 30),
                  onTimeout: () {
                    log('Video initialization timeout');
                    throw TimeoutException(
                      'Video initialization took too long',
                    );
                  },
                )
                .then((_) {
                  isVideoReady.value = true;
                });

            log('Main video initialized successfully');
            update();
          } catch (e) {
            log('Error initializing main video: $e');
            if (kDebugMode) {
              print('Main video initialization failed: $e');
            }
          }
        }
      }
    });
  }

  void onEditService() {
    Get.toNamed(
      Routes.ADD_SERVICES,
      arguments: {
        "isEdit": isEdit.value,
        'service': service.value,
        "onApiCall": onApiCall,
      },
    );
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    refVideoPlayerController?.dispose();
    super.onClose();
  }

  Future<void> retryVideoInitialization() async {
    if (service.value.video != null) {
      videoPlayerController?.dispose();
      videoPlayerController = null;
      update();

      final videoPath = service.value.video?.mediaS3Key ?? "";

      if (videoPath.isEmpty) {
        log('No main video path available for retry');
        update();
        return;
      }

      final videoUrl = videoPath.startsWith('http')
          ? videoPath
          : APIConstants.bucketUrl + videoPath;
      log('Retrying main video - path: $videoPath');
      log('Retrying main video - URL: $videoUrl');

      try {
        videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(videoUrl),
          httpHeaders: {
            'Range': 'bytes=0-',
            'Accept': 'video/*',
            'User-Agent': 'Mozilla/5.0',
          },
          videoPlayerOptions: VideoPlayerOptions(),
        );

        await videoPlayerController?.initialize().timeout(
          const Duration(seconds: 30),
          onTimeout: () {
            log('Video initialization timeout on retry');
            throw TimeoutException('Video initialization took too long');
          },
        );
        isVideoReady.value = true;
        log('Reference video retry successful');
        log('Video retry successful');
        update();
      } catch (e) {
        log('Error retrying video initialization: $e');
        if (kDebugMode) {
          print('Video retry failed: $e');
        }
        update();
      }
    }
  }

  Future<void> retryReferenceVideoInitialization() async {
    if (service.value.reference != null &&
        service.value.reference?.referenceType?.toLowerCase() == 'video') {
      refVideoPlayerController?.dispose();
      refVideoPlayerController = null;
      update();

      final referencePath =
          service.value.reference?.referenceS3Key ??
          service.value.reference?.referenceUrl ??
          "";

      if (referencePath.isEmpty) {
        log('No reference video path available for retry');
        update();
        return;
      }

      final referenceVideoUrl = referencePath.startsWith('http')
          ? referencePath
          : APIConstants.bucketUrl + referencePath;
      log('Retrying reference video - path: $referencePath');
      log('Retrying reference video - URL: $referenceVideoUrl');

      try {
        refVideoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(referenceVideoUrl),
          httpHeaders: {
            'Range': 'bytes=0-',
            'Accept': 'video/*',
            'User-Agent': 'Mozilla/5.0',
          },
          videoPlayerOptions: VideoPlayerOptions(),
        );

        await refVideoPlayerController?.initialize().timeout(
          const Duration(seconds: 30),
          onTimeout: () {
            log('Reference video initialization timeout on retry');
            throw TimeoutException('Video initialization took too long');
          },
        );

        isRefVideo.value = true;
        log('Reference video retry successful');
        update();
      } catch (e) {
        log('Error retrying reference video initialization: $e');
        if (kDebugMode) {
          print('Reference video retry failed: $e');
        }
        update();
      }
    }
  }

  void openVideoDialog(BuildContext context, String videoPath, bool isNetwork) {
    try {
      videoPlayerController?.pause();
    } catch (_) {}

    final playerController = isNetwork
        ? VideoPlayerController.network(videoPath)
        : VideoPlayerController.file(File(videoPath));

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            try {
              await playerController.pause();
              await playerController.dispose();
            } catch (_) {}
            return true;
          },
          child: Dialog(
            insetPadding: const EdgeInsets.all(16),
            child: FutureBuilder(
              future: () async {
                await playerController.initialize();
                await playerController.setLooping(false);
                await playerController.setVolume(1.0);
                return true;
              }(),
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
                            onPressed: () async {
                              try {
                                await playerController.pause();
                                await playerController.dispose();
                              } catch (_) {}
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
          ),
        );
      },
    ).then((_) {
      try {
        playerController.pause();
        playerController.dispose();
      } catch (_) {}
    });
  }

  Future<void> openReferenceUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (kDebugMode) {
          print('Could not launch $url');
        }
      }
    } catch (e) {
      log('Error opening reference URL: $e');
    }
  }

  Rx<ServiceDetailModel> productDetailsModel = ServiceDetailModel().obs;
  RxList<Map<String, dynamic>> businessHoursData = <Map<String, dynamic>>[].obs;
  Future<void> serviceDetails(int id) async {
    try {
      isLoading.value = true;
      productDetailsModel.value = await AddServiceService().serviceDetails(
        id: id.toString(),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
