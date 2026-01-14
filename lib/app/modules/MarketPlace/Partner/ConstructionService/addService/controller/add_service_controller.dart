import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/success_screen.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/addService/service/add_constrcution_Service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/all_service_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/SerciveCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class FeatureItem {
  final TextEditingController headerController;
  final TextEditingController descController;

  FeatureItem()
    : headerController = TextEditingController(),
      descController = TextEditingController();
}

class AddServiceController extends GetxController {
  final formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  RxBool isEdit = false.obs;

  VoidCallback? onApiCall;

  RxList<FeatureItem> featureList = <FeatureItem>[].obs;

  void addNewFeature() {
    if (featureList.isNotEmpty) {
      final lastFeature = featureList.last;
      if (lastFeature.headerController.text.trim().isEmpty ||
          lastFeature.descController.text.trim().isEmpty) {
        SnackBars.errorSnackBar(
          content:
              "Please fill both header and description before adding another feature.",
        );
        return;
      }
    }

    featureList.add(FeatureItem());
  }

  void removeFeature(int index) {
    featureList.removeAt(index);
  }

  RxList<ServiceCategoryData> mainCategories = <ServiceCategoryData>[].obs;
  Rx<ServiceCategoryData?> selectedMainCategory = Rx<ServiceCategoryData?>(
    null,
  );

  RxList<ServicesSubCategories> subCategories = <ServicesSubCategories>[].obs;
  Rx<ServicesSubCategories?> selectedSubCategory = Rx<ServicesSubCategories?>(
    null,
  );
  RxList<String> pickedFilePathList = <String>[].obs;

  RxList<ServiceCategories> serviceCategories = <ServiceCategories>[].obs;
  Rx<ServiceCategories?> selectedServiceCategory = Rx<ServiceCategories?>(null);
  Rxn<String> selectedGST = Rxn<String>();

  void removeImageAt(int index) {
    if (imageSlots[index] != null) {
      removedImages["remove_image_${index + 1}"] = "remove";
      imageSlots[index] = null;
    }
  }

  final unitController = TextEditingController();
  final priceController = TextEditingController();
  final gstController = TextEditingController();
  final descriptionController = TextEditingController();
  final gstPriceController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  final refUrlController = TextEditingController();
  RxList<String?> imageSlots = List<String?>.filled(5, null).obs;
  Map<String, String> removedImages = {};

  final Rx<File?> selectedVideo = Rx<File?>(null);
  VideoPlayerController? videoPlayerController;
  VideoPlayerController? refVideoPlayerController;

  Future<void> pickImageEdit() async {
    List<XFile> pickedFiles = [];
    try {
      final emptySlots = imageSlots.where((e) => e == null).length;
      if (emptySlots <= 0) {
        SnackBars.errorSnackBar(content: "Maximum 5 images allowed");
        return;
      }

      if (emptySlots == 1) {
        // 🔴 Android requires single picker
        final XFile? file = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (file != null) {
          pickedFiles.add(file);
        }
      } else {
        // ✅ Multi image picker (limit >= 2)
        pickedFiles = await ImagePicker().pickMultiImage(limit: emptySlots);
      }

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        final toRemove = <String>[];
        removedImages.forEach((key, value) {
          final index = int.parse(key.split('_').last) - 1;
          if (index >= 0 &&
              index < imageSlots.length &&
              imageSlots[index] != null) {
            toRemove.add(key);
          }
        });
        for (final key in toRemove) {
          removedImages.remove(key);
        }
        for (var path in pickedFiles.map((e) => e.path)) {
          final emptyIndex = imageSlots.indexWhere((e) => e == null);
          if (emptyIndex != -1) {
            removedImages.remove("remove_image_${emptyIndex + 1}");
            imageSlots[emptyIndex] = path;
          } else {
            break;
          }
        }
        final hasAnyImage = imageSlots.any(
          (e) => e != null && e.toString().isNotEmpty,
        );
        if (hasAnyImage) {
          removedImages.removeWhere((key, value) {
            final index = int.parse(key.split('_').last) - 1;
            return index >= 0 &&
                index < imageSlots.length &&
                imageSlots[index] != null;
          });
        }
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Failed to pick images: $e", time: 3);
    }
  }

  void _checkVideoOrientation() {
    if (videoPlayerController != null) {
      final size = videoPlayerController!.value.size;
      isVideoPortrait.value = size.height > size.width;
      log(
        'Video Size: ${size.width}x${size.height}, Is Portrait: ${isVideoPortrait.value}',
      );
    }
  }

  Future<void> pickImage() async {
    List<XFile> results = [];
    try {
      final remainingSlots = 5 - pickedFilePathList.length;
      if (remainingSlots <= 0) {
        SnackBars.errorSnackBar(content: "You can only upload up to 5 images");
        return;
      }

      if (remainingSlots == 1) {
        // 🔴 Android requires single picker
        final XFile? file = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (file != null) {
          results.add(file);
        }
      } else {
        // ✅ Multi image picker (limit >= 2)
        results = await ImagePicker().pickMultiImage(limit: remainingSlots);
      }

      if (results.length > remainingSlots) {
        SnackBars.errorSnackBar(
          content: "You can only upload up to $remainingSlots images",
        );
        return;
      }

      if (results.isNotEmpty) {
        pickedFilePathList.addAll(results.map((e) => e.path));
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Failed to pick images: $e', time: 3);
    }
  }

  RxInt serviceId = 0.obs;
  Rx<ServiceReferenceItem> serviceRef = ServiceReferenceItem().obs;
  Rx<ServiceMediaItem> serviceVid = ServiceMediaItem().obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryServiceHierarchy();
    onApiCall = Get.arguments?["onApiCall"] ?? () {};
    isEdit.value = Get.arguments?["isEdit"] ?? false;
    if (Get.arguments != null && Get.arguments["service"] != null) {
      final s = Get.arguments["service"];
      serviceId.value = s.id;
      serviceVid.value = s.video;

      if (s.reference != null) {
        referenceDeleted.value = false;
        serviceRef.value = s.reference;
        if (serviceRef.value.referenceType == "video") {
          refVideoPlayerController?.dispose();
          refVideoPlayerController = VideoPlayerController.networkUrl(
            Uri.parse(
              APIConstants.bucketUrl + (serviceRef.value.referenceS3Key ?? ""),
            ),
          );
          WidgetsBinding.instance.addPostFrameCallback((val) async {
            await refVideoPlayerController!.initialize();
            refVideoPlayerController!.setLooping(false);
          });
          _checkVideoOrientation();
        }
      } else {
        referenceDeleted.value = true;
      }
      _prefillServiceData(s);
    }
  }

  Future<void> _prefillServiceData(dynamic service) async {
    try {
      /// --- Category Selections ---
      selectedMainCategory.value = mainCategories.firstWhereOrNull(
        (e) => e.id == service.mainCategoryId,
      );

      if (selectedMainCategory.value != null) {
        subCategories.assignAll(
          selectedMainCategory.value?.subCategories ?? [],
        );
        selectedSubCategory.value = subCategories.firstWhereOrNull(
          (e) => e.id == service.subCategoryId,
        );

        if (selectedSubCategory.value != null) {
          serviceCategories.assignAll(
            selectedSubCategory.value?.serviceCategories ?? [],
          );
          selectedServiceCategory.value = serviceCategories.firstWhereOrNull(
            (e) => e.id == service.serviceCategoryId,
          );
        }
      }

      /// --- Text Controllers ---
      unitController.text = service.units ?? "";
      priceController.text = service.price ?? "";
      refUrlController.text = service.serviceReferenceUrl ?? '';
      noteController.text = service.note ?? '';
      gstController.text = service.gstPercentage ?? "";
      descriptionController.text = service.description ?? "";
      gstPriceController.text = service.gstAmount ?? "";
      amountController.text = service.totalAmount ?? "";
      selectedGST.value = "${service.gstPercentage?.split(".").first}%";
      featureList.clear();
      if (service.features != null && service.features is List) {
        final List<ServiceFeature> features = service.features;
        for (final f in features) {
          final item = FeatureItem();
          item.headerController.text = f.feature ?? '';
          item.descController.text = f.details ?? '';
          featureList.add(item);
        }
      }
      featureList.refresh();
      imageSlots.value = List<String?>.filled(5, null);
      final existingImages = service.images ?? [];
      for (int i = 0; i < existingImages.length && i < 5; i++) {
        imageSlots[i] =
            "${APIConstants.bucketUrl}${existingImages[i].mediaS3Key!}";
      }

      final existingVideo = serviceVid.value;
      WidgetsBinding.instance.addPostFrameCallback((val) async {
        selectedVideo.value = File("abc");
        videoPlayerController?.dispose();
        videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(
            APIConstants.bucketUrl + existingVideo.mediaS3Key.toString(),
          ),
        );
        await videoPlayerController!.initialize();
        videoPlayerController!.setLooping(false);
      });

      log("✅ Prefilled service edit data");
    } catch (e) {
      log("⚠️ Prefill error: $e");
    }
  }

  Future<void> fetchCategoryServiceHierarchy() async {
    try {
      isLoading(true);

      final cachedCategoryHierarchy = myPref.getServiceCategoryHierarchyModel();
      final categoryHierarchy =
          cachedCategoryHierarchy ??
          await HomeService().getCategoryServiceHierarchy();

      mainCategories.assignAll(categoryHierarchy.data ?? []);
    } catch (e) {
      log("Error fetching categories: $e");
    } finally {
      isLoading(false);
    }
  }

  void onMainCategorySelected(String? value) {
    selectedMainCategory.value = mainCategories.firstWhereOrNull(
      (e) => e.name == value,
    );

    subCategories.assignAll(selectedMainCategory.value?.subCategories ?? []);

    selectedSubCategory.value = null;
    selectedServiceCategory.value = null;
    serviceCategories.clear();
  }

  void onSubCategorySelected(String? value) {
    selectedSubCategory.value = subCategories.firstWhereOrNull(
      (e) => e.name == value,
    );

    serviceCategories.assignAll(
      selectedSubCategory.value?.serviceCategories ?? [],
    );

    selectedServiceCategory.value = null;
  }

  void onServiceCategorySelected(String? value) {
    selectedServiceCategory.value = serviceCategories.firstWhereOrNull(
      (e) => e.name == value,
    );
  }

  void gstCalculate() {
    final double amount =
        double.parse(
          priceController.text.isEmpty ? '0.0' : priceController.text,
        ) *
        double.parse(
          selectedGST.value.toString().replaceAll("%", "").isEmpty
              ? '0.0'
              : (selectedGST.value.toString().replaceAll("%", "")),
        ) /
        100;
    gstPriceController.text = amount.toStringAsFixed(2);
    amountController.text = (amount + double.parse(priceController.text))
        .toStringAsFixed(2);
  }

  final RxBool isVideoPortrait = false.obs;

  Future<void> openVideoPickerBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Select Video Option", style: MyTexts.medium16),
                const Gap(20),
                ListTile(
                  leading: const Icon(Icons.videocam_rounded),
                  title: const Text("Record Video"),
                  onTap: () {
                    Get.back();
                    pickVideo(isRecord: true);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.video_library_rounded),
                  title: const Text("Upload from Gallery"),
                  onTap: () {
                    Get.back();
                    pickVideo(isRecord: false);
                  },
                ),
                const Gap(8),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> pickVideo({required bool isRecord}) async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickVideo(
      source: isRecord ? ImageSource.camera : ImageSource.gallery,
      maxDuration: const Duration(minutes: 2),
    );

    if (picked != null) {
      final file = File(picked.path);
      final sizeInMB = file.lengthSync() / (1024 * 1024);
      if (sizeInMB > 10) {
        SnackBars.errorSnackBar(content: "Video must be less than 10 MB");
        return;
      }

      selectedVideo.value = file;
      videoPlayerController?.dispose();
      videoPlayerController = VideoPlayerController.file(file);
      await videoPlayerController!.initialize();
      videoPlayerController!.setLooping(false);
      _checkVideoOrientation();
    }
  }

  void removeVideo() {
    selectedVideo.value = null;
    videoPlayerController?.dispose();
    videoPlayerController = null;
  }

  final AddServiceService _service = AddServiceService();

  Future<void> createService() async {
    isLoading.value = true;
    Map<String, dynamic> fields = {};
    final List<Map<String, String>> featureData = featureList
        .map(
          (f) => {
            "feature": f.headerController.text.trim(),
            "details": f.descController.text.trim(),
          },
        )
        .where(
          (item) => item["feature"]!.isNotEmpty && item["details"]!.isNotEmpty,
        )
        .toList();

    final String featuresJson = jsonEncode(featureData);
    final imageList = pickedFilePathList;
    int index = 1;
    final Map<String, String> selectedFiles = {};
    for (final path in imageList) {
      if (path.contains('http')) {
        fields["image_$index"] = path;
      } else {
        selectedFiles["image_$index"] = path;
      }
      index++;
    }
    if (referenceFile.value != null) {
      selectedFiles['reference'] = referenceFile.value!.path;
    }

    selectedFiles["video"] = selectedVideo.value?.path ?? "";

    fields = {
      "main_category_id": selectedMainCategory.value?.id.toString(),
      "sub_category_id": selectedSubCategory.value?.id.toString(),
      "service_category_id": selectedServiceCategory.value?.id.toString(),
      "units": unitController.text,
      "price": priceController.text,
      "gst_percentage": selectedGST.value,
      "description": descriptionController.text,
      "note": noteController.text,
      if (featureList.isNotEmpty) "features": featuresJson,
      if (refUrlController.text.isNotEmpty)
        "service_reference_url": refUrlController.text,
      if (referenceFile.value != null) 'reference_type': referenceFileUrl.value,
    };

    try {
      final res = await _service.createService(
        fields: fields,
        files: selectedFiles,
      );
      if (res.success) {
        Get.to(
          () => SuccessScreen(
            title: "Success!",
            header: "Service added successfully!",
            onTap: () {
              // Get.back();
              // Get.back();
              Get.toNamed(Routes.MAIN);
            },
          ),
        );
      } else {
        Get.snackbar("Error", res.message ?? "Failed to add service");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateService(int serviceId) async {
    isLoading.value = true;
    final Map<String, String> selectedFiles = {};
    final List<Map<String, String>> featureData = featureList
        .map(
          (f) => {
            "feature": f.headerController.text.trim(),
            "details": f.descController.text.trim(),
          },
        )
        .where(
          (item) => item["feature"]!.isNotEmpty && item["details"]!.isNotEmpty,
        )
        .toList();

    final String featuresJson = jsonEncode(featureData);
    if (referenceFile.value != null && referenceDeleted.value == true) {
      selectedFiles['reference'] = referenceFile.value!.path;
    }

    final Map<String, dynamic> fields = {
      "main_category_id": selectedMainCategory.value?.id.toString(),
      "sub_category_id": selectedSubCategory.value?.id.toString(),
      "service_category_id": selectedServiceCategory.value?.id.toString(),
      "units": unitController.text,
      "price": priceController.text,
      "gst_percentage": selectedGST.value,
      "description": descriptionController.text,
      "note": noteController.text,
      "features": featuresJson,
      "service_reference_url": refUrlController.text,
      'reference_type': referenceFileUrl.value,
    };
    if (referenceDeleted.value == true) {
      fields["remove_reference"] = "remove";
    }
    final Map<String, String> tempRemoved = Map.from(removedImages);

    for (int i = 0; i < imageSlots.length; i++) {
      final path = imageSlots[i];
      final key = "image_${i + 1}";

      if (path == null || path.trim().isEmpty) {
        tempRemoved["remove_image_${i + 1}"] = "remove";
        continue;
      }

      tempRemoved.remove("remove_image_${i + 1}");

      if (path.contains('http')) {
        fields[key] = path;
      } else {
        selectedFiles[key] = path;
      }
    }
    if ((selectedVideo.value?.path ?? "") != "abc") {
      selectedFiles["video"] = selectedVideo.value?.path ?? "";
    }

    fields.addAll(tempRemoved);

    try {
      final res = await _service.updateService(
        serviceId: serviceId,
        fields: fields,
        files: selectedFiles.isNotEmpty ? selectedFiles : null,
      );

      if (res.success) {
        Get.to(
          () => SuccessScreen(
            title: "Success!",
            header: "Service updated successfully!",
            onTap: () {
              onApiCall?.call();
            },
          ),
        );
      } else {
        Get.snackbar("Error", res.message ?? "Failed to update service");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Rx<File?> referenceFile = Rx<File?>(null);
  RxString referenceFileUrl = ''.obs;
  RxString referenceFileType = ''.obs;

  Future<void> pickReferenceFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'pdf', 'doc', 'docx'],
      );

      if (result != null && result.files.isNotEmpty) {
        final pickedFile = File(result.files.first.path!);
        referenceFile.value = pickedFile;
        referenceFileUrl.value = '';

        final extension = pickedFile.path.split('.').last.toLowerCase();

        if (['jpg', 'jpeg', 'png'].contains(extension)) {
          referenceFileType.value = 'image';
        } else if (extension == 'mp4') {
          referenceFileType.value = 'video';
        } else if (['pdf', 'doc', 'docx'].contains(extension)) {
          referenceFileType.value = 'doc';
        } else {
          referenceFileType.value = 'doc';
        }
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Failed to pick file: $e", time: 3);
    }
  }

  void removeReferenceFile() {
    referenceFile.value = null;
    referenceFileUrl.value = '';
  }

  RxBool referenceDeleted = true.obs;

  void deleteReferenceFile() {
    referenceDeleted.value = true;
    referenceFileUrl.value = "";
    referenceFile.value = null;
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
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
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
}
