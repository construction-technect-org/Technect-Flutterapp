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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeVideosForService(service.value, token: _initToken);
    });
  }

  int _initToken = 0;

  Future<void> loadService(Service newService) async {
    _initToken++;
    final currentToken = _initToken;
    await _disposeVideoControllers();

    service.value = newService;
    isVideoReady.value = false;
    isRefVideo.value = false;
    currentIndex.value = 0;
    update();

    if (!isEdit.value) {
      await serviceDetails(service.value.id ?? 0);
    }

    await _initializeVideosForService(service.value, token: currentToken);
  }

  Future<void> _initializeVideosForService(Service svc, {required int token}) async {
    final List<Future<void>> inits = [];

    if (svc.reference != null && svc.reference?.referenceType?.toLowerCase() == 'video') {
      final refPath = svc.reference?.referenceS3Key ?? svc.reference?.referenceUrl ?? '';
      if (refPath.isNotEmpty) {
        inits.add(_initializeReferenceVideo(refPath, token: token));
      }
    }

    if (svc.video != null) {
      final videoPath = svc.video?.mediaS3Key ?? svc.video?.mediaUrl ?? '';
      if (videoPath.isNotEmpty) {
        inits.add(_initializeMainVideo(videoPath, token: token));
      }
    }

    if (inits.isNotEmpty) {
      await Future.wait(inits);
    }
  }

  double displayAspectRatio(VideoPlayerController? vController) {
    if (vController != null) {
      vController.pause();
      final size = vController.value.size;
      final bool isVideoPortrait = size.height > size.width;
      log('Video Size: ${size.width}x${size.height}, Is Portrait: $isVideoPortrait');

      return isVideoPortrait ? 9 / 16 : 16 / 9;
    } else {
      return 16 / 9;
    }
  }

  Future<void> _initializeReferenceVideo(String referencePath, {required int token}) async {
    final referenceVideoUrl = referencePath.startsWith('http')
        ? referencePath
        : APIConstants.bucketUrl + referencePath;
    log('Reference video path: $referencePath');
    log('Reference video URL: $referenceVideoUrl');
    try {
      final localController = VideoPlayerController.networkUrl(
        Uri.parse(referenceVideoUrl),
        httpHeaders: {'Range': 'bytes=0-', 'Accept': 'video/*', 'User-Agent': 'Mozilla/5.0'},
        videoPlayerOptions: VideoPlayerOptions(),
      );

      await localController.initialize().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Reference video initialization took too long');
        },
      );

      if (token != _initToken) {
        try {
          await localController.pause();
          localController.dispose();
        } catch (_) {}
        return;
      }

      try {
        await refVideoPlayerController?.pause();
        refVideoPlayerController?.dispose();
      } catch (_) {}
      refVideoPlayerController = localController;
      isRefVideo.value = true;
      update();
    } catch (e) {
      if (token == _initToken) {
        isRefVideo.value = false;
        update();
      }
    }
  }

  Future<void> _disposeVideoControllers() async {
    try {
      await videoPlayerController?.pause();
      videoPlayerController?.dispose();
    } catch (_) {}
    videoPlayerController = null;

    try {
      await refVideoPlayerController?.pause();
      refVideoPlayerController?.dispose();
    } catch (_) {}
    refVideoPlayerController = null;

    isVideoReady.value = false;
    isRefVideo.value = false;
    update();
  }

  Future<void> _initializeMainVideo(String videoPath, {required int token}) async {
    final videoUrl = videoPath.startsWith('http') ? videoPath : APIConstants.bucketUrl + videoPath;
    log('Main video path: $videoPath');
    log('Full main video URL: $videoUrl');
    try {
      final localController = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
        httpHeaders: {'Range': 'bytes=0-', 'Accept': 'video/*', 'User-Agent': 'Mozilla/5.0'},
        videoPlayerOptions: VideoPlayerOptions(),
      );

      await localController.initialize().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Video initialization took too long');
        },
      );

      if (token != _initToken) {
        try {
          await localController.pause();
          localController.dispose();
        } catch (_) {}
        return;
      }

      try {
        await videoPlayerController?.pause();
        videoPlayerController?.dispose();
      } catch (_) {}
      videoPlayerController = localController;
      isVideoReady.value = true;
      update();
    } catch (e) {
      if (token == _initToken) {
        isVideoReady.value = false;
        update();
      }
    }
  }

  void onEditService() {
    Get.toNamed(
      Routes.ADD_SERVICES,
      arguments: {"isEdit": isEdit.value, 'service': service.value, "onApiCall": onApiCall},
    );
  }

  @override
  void onClose() {
    _disposeVideoControllers();
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
          httpHeaders: {'Range': 'bytes=0-', 'Accept': 'video/*', 'User-Agent': 'Mozilla/5.0'},
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
          log('Video retry failed: $e');
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
          service.value.reference?.referenceS3Key ?? service.value.reference?.referenceUrl ?? "";

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
          httpHeaders: {'Range': 'bytes=0-', 'Accept': 'video/*', 'User-Agent': 'Mozilla/5.0'},
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
          log('Reference video retry failed: $e');
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
        ? VideoPlayerController.networkUrl(Uri.parse(videoPath))
        : VideoPlayerController.file(File(videoPath));

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return PopScope(
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            try {
              playerController.pause();
              playerController.dispose();
            } catch (_) {}
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
                          child: Tooltip(
                            message: 'Close',
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(22),
                                onTap: () async {
                                  try {
                                    await playerController.pause();
                                    await playerController.dispose();
                                  } catch (_) {}
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                                ),
                              ),
                            ),
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
          log('Could not launch $url');
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
      productDetailsModel.value = await AddServiceService().serviceDetails(id: id.toString());
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }
}
