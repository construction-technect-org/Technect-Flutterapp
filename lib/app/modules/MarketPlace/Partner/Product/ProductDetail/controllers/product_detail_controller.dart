import 'dart:io';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/models/ProductDetailsModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/models/rating_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/services/ProductDetailService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class ProductDetailsController extends GetxController {
  Product product = Product();

  ProfileModel profileData = ProfileModel.fromJson(
    myPref.getProfileData() ?? {},
  );
  final RxBool showProductDetails = false.obs;
  final RxBool isFromAdd = false.obs;
  final RxBool isFromConnector = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLiked = false.obs;
  final RxInt currentIndex = 0.obs;
  final ProductDetailService _service = ProductDetailService();
  VideoPlayerController? videoPlayerController;
  final VoidCallback? onApiCall = Get.arguments['onApiCall'] ?? () {};
  Rx<ProductDetailsModel> productDetailsModel = ProductDetailsModel().obs;

  @override
  void onInit() {
    final argument = Get.arguments as Map;
    product = argument['product'] ?? Product();
    isLiked.value = product.isInWishList ?? false;
    isFromAdd.value = argument["isFromAdd"];
    isFromConnector.value = argument["isFromConnector"];
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
        videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(APIConstants.bucketUrl + product.productVideo.toString()),
        );
        await videoPlayerController?.initialize();
      });
    }
    super.onInit();
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
        latitude: Get.find<HomeController>().currentLatitude.toString(),
        longitude: Get.find<HomeController>().currentLongitude.toString(),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
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
  RxList<Map<String, dynamic>> businessHoursData = <Map<String, dynamic>>[].obs;

}
