import 'dart:developer';
import 'dart:io';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/success_screen.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/addService/service/add_constrcution_Service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/SerciveCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

/// ===============================
/// CONTROLLER
/// ===============================
class AddServiceController extends GetxController {
  /// Loading state
  RxBool isLoading = false.obs;
  RxBool isEdit = false.obs;

  /// API data
  Rx<ServiceCategoryModel> categoryHierarchyDataCM = ServiceCategoryModel().obs;

  /// Category lists
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
  RxList<String> gstList = <String>["5%", "12%", "18%", "28%"].obs;
  Rxn<String> selectedGST = Rxn<String>();

  void removeImageAt(int index) {
    if (imageSlots[index] != null) {
      removedImages["remove_image_${index + 1}"] = "remove";
      imageSlots[index] = null;
    }
  }

  /// Form controllers
  final unitController = TextEditingController();
  final priceController = TextEditingController();
  final gstController = TextEditingController();
  final descriptionController = TextEditingController();
  final gstPriceController = TextEditingController();
  final amountController = TextEditingController();
  RxList<String?> imageSlots = List<String?>.filled(5, null).obs;
  Map<String, String> removedImages = {};

  /// Media
  RxList<XFile> serviceImages = <XFile>[].obs;
  Rx<XFile?> serviceVideo = Rx<XFile?>(null);

  final Rx<File?> selectedVideo = Rx<File?>(null);
  VideoPlayerController? videoPlayerController;

  RxList<XFile> referenceImages = <XFile>[].obs;
  Rx<XFile?> referenceVideo = Rx<XFile?>(null);

  /// For Edit Mode (Existing Media)
  RxList<String> oldServiceImages = <String>[].obs;
  RxString oldServiceVideo = ''.obs;


  Future<void> pickImageEdit() async {
    try {
      // Count how many slots are still empty
      final emptySlots = imageSlots.where((e) => e == null).length;
      if (emptySlots <= 0) {
        SnackBars.errorSnackBar(content: "Maximum 5 images allowed");
        return;
      }

      // Pick multiple images but only up to the available empty slots
      final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage(
        limit: emptySlots == 1 ? null : emptySlots,
      );

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        // Remove stale removal flags
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
        // int assignIndex = 0;
        for (var path in pickedFiles.map((e) => e.path)) {
          final emptyIndex = imageSlots.indexWhere((e) => e == null);
          if (emptyIndex != -1) {
            removedImages.remove("remove_image_${emptyIndex + 1}");
            imageSlots[emptyIndex] = path;
            // assignIndex++;
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

  Future<void> pickImage() async {
    try {
      final remainingSlots = 5 - pickedFilePathList.length;
      if (remainingSlots <= 0) {
        SnackBars.errorSnackBar(content: "You can only upload up to 5 images");
        return;
      }

      final List<XFile>? results = await ImagePicker().pickMultiImage(
        limit: remainingSlots,
      );

      if (results != null && results.isNotEmpty) {
        pickedFilePathList.addAll(results.map((e) => e.path));
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Failed to pick images: $e', time: 3);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCategoryServiceHierarchy();
    if (Get.arguments != null && Get.arguments["service"] != null) {
      isEdit.value = true;
      final service = Get.arguments["service"];
      log("Editing Service ID: ${service.id}");
      _prefillServiceData(service);
    }
  }

  void _prefillServiceData(dynamic service) {
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
      gstController.text = service.gstPercentage ?? "";
      descriptionController.text = service.description ?? "";
      gstPriceController.text = service.gstAmount ?? "";
      amountController.text = service.totalAmount ?? "";
      selectedGST.value = "${service.gstPercentage?.split(".").first}%";
      if (service.media != null) {
        oldServiceImages.assignAll(service.media!.whereType<String>().toList());
      }

      if (service.references != null) {
        referenceImages.assignAll(
          service.references!
              .whereType<String>()
              .map((path) => XFile(path))
              .toList(),
        );
      }

      if (service.media != null &&
          service.media!.first.toString().endsWith(".mp4")) {
        oldServiceVideo.value = service.media!.first.toString();
      }

      /// --- Initialize old video preview ---
      if (oldServiceVideo.value.isNotEmpty) {
        videoPlayerController = VideoPlayerController.network(
          APIConstants.bucketUrl + oldServiceVideo.value,
        );
        videoPlayerController!.initialize();
        videoPlayerController!.setLooping(false);
      }

      log("✅ Prefilled service edit data");
    } catch (e) {
      log("⚠️ Prefill error: $e");
    }
  }

  Future<void> fetchCategoryServiceHierarchy() async {
    try {
      isLoading(true);

      final cachedCategoryHierarchy = myPref.getServiceCategoryHierarchyModel();
      if (cachedCategoryHierarchy != null) {
        categoryHierarchyDataCM.value = cachedCategoryHierarchy;
      } else {
        final apiCategoryHierarchy = await HomeService()
            .getCategoryServiceHierarchy();

        categoryHierarchyDataCM.value = apiCategoryHierarchy;
      }

      mainCategories.assignAll(categoryHierarchyDataCM.value.data ?? []);
    } catch (e) {
      log("Error fetching categories: $e");
    } finally {
      isLoading(false);
    }
  }

  /// --- Dropdown Logic ---
  void onMainCategorySelected(String? value) {
    selectedMainCategory.value = mainCategories.firstWhereOrNull(
      (e) => e.name == value,
    );

    // ✅ use assignAll() instead of .value =
    subCategories.assignAll(selectedMainCategory.value?.subCategories ?? []);

    selectedSubCategory.value = null;
    selectedServiceCategory.value = null;
    serviceCategories.clear();
  }

  void onSubCategorySelected(String? value) {
    selectedSubCategory.value = subCategories.firstWhereOrNull(
      (e) => e.name == value,
    );

    // ✅ use assignAll() here too
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
      if (sizeInMB > 24) {
        SnackBars.errorSnackBar(content: "Video must be less than 24 MB");
        return;
      }

      selectedVideo.value = file;
      videoPlayerController?.dispose();
      videoPlayerController = VideoPlayerController.file(file);
      await videoPlayerController!.initialize();
      videoPlayerController!.setLooping(false);
    }
  }

  final AddServiceService _service = AddServiceService();

  void removeVideo() {
    selectedVideo.value = null;
    videoPlayerController?.dispose();
    videoPlayerController = null;
  }

  Future<void> createService() async {
    isLoading.value = true;
     Map<String, dynamic> fields = {};

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

    selectedFiles["video"] = selectedVideo.value?.path ?? "";

    fields = {
      "main_category_id": selectedMainCategory.value?.id.toString(),
      "sub_category_id": selectedSubCategory.value?.id.toString(),
      "service_category_id": selectedServiceCategory.value?.id.toString(),
      "units": unitController.text,
      "price": priceController.text,
      "gst_percentage": selectedGST.value,
      "description": descriptionController.text,
    };

    try {
      final res = await _service.createService(fields: fields, files: selectedFiles);
      if (res.success) {
        // Get.to(
        //   () => SuccessScreen(
        //     title: "Success!",
        //     header: "Service added successfully!",
        //     onTap: () {
        //       Get.back();
        //       Get.back();
        //     },
        //   ),
        // );
      } else {
        Get.snackbar("Error", res.message ?? "Failed to add service");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Update existing product
  Future<void> updateService(int serviceId) async {
    isLoading.value = true;
    final Map<String, String> selectedFiles = {};

    final Map<String, dynamic> fields = {
      "main_category_id": selectedMainCategory.value?.id.toString(),
      "sub_category_id": selectedSubCategory.value?.id.toString(),
      "service_category_id": selectedServiceCategory.value?.id.toString(),
      "units": unitController.text,
      "price": priceController.text,
      "gst_percentage": selectedGST.value,
      "description": descriptionController.text,
    };
    // 🟩 Step 1: Prepare a copy of remove map
    final Map<String, String> tempRemoved = Map.from(removedImages);

    // 🟦 Step 2: Rebuild fields and remove flags properly
    for (int i = 0; i < imageSlots.length; i++) {
      final path = imageSlots[i];
      final key = "image_${i + 1}";

      if (path == null || path.trim().isEmpty) {
        // slot is empty => keep/remove flag
        tempRemoved["remove_image_${i + 1}"] = "remove";
        continue;
      }

      // slot has an image, so ensure it's not marked removed
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
              Get.back();
              Get.back();
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
}
