import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/all_service_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class ServiceDetailController extends GetxController {
  Rx<Service> service = Service().obs;

  ProfileModel profileData = ProfileModel.fromJson(
    myPref.getProfileData() ?? {},
  );
  final RxBool isLoading = false.obs;
  final RxBool isLiked = false.obs;
  final RxBool isEdit = false.obs;
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

    // fetchServiceDetails(service.id ?? 0);
    WidgetsBinding.instance.addPostFrameCallback((val) async {
      // Initialize video from reference if reference type is video
      if (service.value.reference != null &&
          service.value.reference?.referenceType?.toLowerCase() == 'video') {
        // Try referenceS3Key first, fallback to referenceUrl
        final referencePath =
            service.value.reference?.referenceS3Key ??
            service.value.reference?.referenceUrl ??
            "";

        if (referencePath.isNotEmpty) {
          // If path doesn't start with http, prepend bucket URL
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

            await refVideoPlayerController?.initialize().timeout(
              const Duration(seconds: 30),
              onTimeout: () {
                log('Reference video initialization timeout');
                throw TimeoutException('Video initialization took too long');
              },
            );

            log('Reference video initialized successfully');
            update(); // Notify listeners to rebuild
          } catch (e) {
            log('Error initializing reference video: $e');
            if (kDebugMode) {
              print('Reference video initialization failed: $e');
            }
          }
        }
      }

      // Initialize video controllers for video in media list (only if reference is not video)
      if (service.value.reference?.referenceType?.toLowerCase() != 'video' &&
          service.value.video != null) {
        // Try mediaS3Key first, fallback to mediaUrl
        final videoPath =
            service.value.video?.mediaS3Key ??
            service.value.video?.mediaUrl ??
            "";

        if (videoPath.isNotEmpty) {
          // If path doesn't start with http, prepend bucket URL
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

            // Add timeout for initialization
            await videoPlayerController?.initialize().timeout(
              const Duration(seconds: 30),
              onTimeout: () {
                log('Video initialization timeout');
                throw TimeoutException('Video initialization took too long');
              },
            );

            log('Video initialized successfully');
            update(); // Notify listeners to rebuild
          } catch (e) {
            log('Error initializing video: $e');
            // Show error to user or provide fallback
            if (kDebugMode) {
              print('Video initialization failed: $e');
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
    // Dispose video controller
    videoPlayerController?.dispose();
    super.onClose();
  }

  Future<void> retryVideoInitialization() async {
    if (service.value.video != null) {
      // Dispose old controller
      videoPlayerController?.dispose();
      videoPlayerController = null;
      update();

      // Try mediaS3Key first, fallback to mediaUrl
      final videoPath = service.value.video?.mediaS3Key ?? "";

      if (videoPath.isEmpty) {
        log('No main video path available for retry');
        update();
        return;
      }

      // If path doesn't start with http, prepend bucket URL
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

        log('Video retry successful');
        update();
      } catch (e) {
        log('Error retrying video initialization: $e');
        // Show error message to user
        if (kDebugMode) {
          print('Video retry failed: $e');
        }
        update();
      }
    }
  }

  Future<void> retryReferenceVideoInitialization() async {
    // Retry reference video (only if reference type is video)
    if (service.value.reference != null &&
        service.value.reference?.referenceType?.toLowerCase() == 'video') {
      // Dispose old controller
      videoPlayerController?.dispose();
      videoPlayerController = null;
      update();

      // Try referenceS3Key first, fallback to referenceUrl
      final referencePath =
          service.value.reference?.referenceS3Key ??
          service.value.reference?.referenceUrl ??
          "";

      if (referencePath.isEmpty) {
        log('No reference video path available for retry');
        update();
        return;
      }

      // If path doesn't start with http, prepend bucket URL
      final referenceVideoUrl = referencePath.startsWith('http')
          ? referencePath
          : APIConstants.bucketUrl + referencePath;
      log('Retrying reference video - path: $referencePath');
      log('Retrying reference video - URL: $referenceVideoUrl');

      try {
        videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(referenceVideoUrl),
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
            log('Reference video initialization timeout on retry');
            throw TimeoutException('Video initialization took too long');
          },
        );

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
}
