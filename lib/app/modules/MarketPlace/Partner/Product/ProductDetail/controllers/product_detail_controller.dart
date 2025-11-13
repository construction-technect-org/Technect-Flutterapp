import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/models/ProductDetailsModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/models/rating_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/services/ProductDetailService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class ProductDetailsController extends GetxController {
  Product product = Product();

  final RxBool isFromAdd = false.obs;
  final RxBool isFromConnector = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLiked = false.obs;
  final RxBool isVideoReady = false.obs;
  final RxInt currentIndex = 0.obs;
  final ProductDetailService _service = ProductDetailService();
  VideoPlayerController? videoPlayerController;
  VoidCallback? onApiCall;
  Rx<ProductDetailsModel> productDetailsModel = ProductDetailsModel().obs;
  RxList<Map<String, dynamic>> businessHoursData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    final argument = Get.arguments as Map? ?? {};
    product = argument['product'] ?? Product();
    isLiked.value = product.isInWishList ?? false;
    isFromAdd.value = argument["isFromAdd"] ?? false;
    isFromConnector.value = argument["isFromConnector"] ?? false;
    onApiCall = argument["onApiCall"];
    if (isFromAdd.value == false) {
      fetchReview(product.id ?? 0, isFromConnector.value);
      if (!(isFromAdd.value == false && isFromConnector.value == false)) {
        productDetails(product.id ?? 0);
      }
      final timeFormatter = DateFormat.jm();

      businessHoursData.value = businessHours.map((e) {
        String? formattedOpen;
        String? formattedClose;

        if (e.openTime != null && e.openTime!.isNotEmpty) {
          final open = DateFormat("HH:mm:ss").parse(e.openTime!);
          formattedOpen = timeFormatter.format(open);
        }

        if (e.closeTime != null && e.closeTime!.isNotEmpty) {
          final close = DateFormat("HH:mm:ss").parse(e.closeTime!);
          formattedClose = timeFormatter.format(close);
        }

        return {
          "id": e.id,
          "is_open": e.isOpen,
          "day_name": e.dayName,
          "open_time": formattedOpen,
          "close_time": formattedClose,
          "day_of_week": e.dayOfWeek,
        };
      }).toList();

      WidgetsBinding.instance.addPostFrameCallback((val) async {
        if (product.productVideo != null &&
            (product.productVideo?.isNotEmpty ?? false)) {
          final videoPath = product.productVideo ?? "";

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
                  .then((val) {
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
  }

  List<BusinessHours> get businessHours => product.businessHours ?? [];

  void onEditProduct() {
    Get.toNamed(
      Routes.ADD_PRODUCT,
      arguments: {"isEdit": true, 'product': product, "onApiCall": onApiCall},
    );
  }

  final RxList<Ratings> reviewList = <Ratings>[].obs;

  Future<void> fetchReview(int id, bool? isFromConnector) async {
    try {
      isLoading.value = true;
      final result = isFromConnector == false
          ? await _service.fetchAllReview(id: id.toString())
          : await _service.fetchConnectorReview(id: id.toString());
      if (result != null && result.success == true) {
        reviewList.assignAll(result.data?.ratings ?? []);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> productDetails(int id) async {
    try {
      isLoading.value = true;
      productDetailsModel.value = await _service.productDetails(
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

  Future<void> retryVideoInitialization() async {
    if (product.productVideo != null) {
      videoPlayerController?.dispose();
      videoPlayerController = null;
      isVideoReady.value = false;
      update();

      final videoPath = product.productVideo ?? "";

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

  @override
  void onClose() {
    try {
      videoPlayerController?.pause();
      videoPlayerController?.dispose();
    } catch (_) {}
    super.onClose();
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
}
