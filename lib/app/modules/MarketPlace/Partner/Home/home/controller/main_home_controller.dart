import 'dart:developer';
import 'dart:io';

import 'package:construction_technect/app/core/utils/globals.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/category_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/category_product_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/main_category_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/subcategory_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/get_filter_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class MainHomeController extends GetxController {
  final HomeService _homeService = Get.find<HomeService>();

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  bool isEdit = false;
  final pageController = PageController();
  RxList<String> pickedFilePathList = <String>[].obs;
  RxList addProduct = [
    "1.Basic Product Details",
    "2.Pricing & Units",
    "3.Technical Specifications",
  ].obs;

  RxBool isLoading = false.obs;

  final brandNameController = TextEditingController();
  final stockController = TextEditingController();
  final noteController = TextEditingController();
  final termsController = TextEditingController();
  final priceController = TextEditingController();
  final gstPriceController = TextEditingController();
  final amountController = TextEditingController();
  RxBool showExtraFields = false.obs;

  RxBool isOutStock = true.obs;
  RxList<MainCategoryData?> mainCatList = <MainCategoryData?>[].obs;
  RxList<String> mainCatListNames = <String>[].obs;
  RxList<FullCategoryData?> catList = <FullCategoryData?>[].obs;
  RxList<String> catListNames = <String>[].obs;
  RxList<SubCategoryData?> subCatList = <SubCategoryData?>[].obs;
  RxList<String> subCatListNames = <String>[].obs;
  RxList<CategoryProductData?> catProdList = <CategoryProductData?>[].obs;
  RxList<String> catProdListNames = <String>[].obs;

  RxList<FilterData> filters = <FilterData>[].obs;

  Map<String, TextEditingController> dynamicControllers = {};
  final Map<String, Rxn<String>> dropdownValues = {};
  final Map<String, RxList<String>> multiDropdownValues = {};

  RxInt selectedSiteAddressId = 0.obs;
  RxString selectedSiteAddressName = ''.obs;
  Rxn<String> selectedMainCatName = Rxn<String>();
  Rxn<String> selectedCatName = Rxn<String>();
  Rxn<String> selectedSubCatName = Rxn<String>();
  Rxn<String> selectedCatProdName = Rxn<String>();
  Rxn<String> selectedGST = Rxn<String>();

  RxList<String?> imageSlots = List<String?>.filled(5, null).obs;
  RxList<String> gstList = <String>["5%", "12%", "18%", "28%"].obs;
  Map<String, String> removedImages = {};

  Rxn<String> selectedWareHouseType = Rxn<String>();

  final stockYardAddressController = TextEditingController();

  RxList<ManufacturerAddress> siteLocations = <ManufacturerAddress>[].obs;
  Rxn<ManufacturerAddress> selectedSiteAddress = Rxn<ManufacturerAddress>();

  final Rx<File?> selectedVideo = Rx<File?>(null);
  VideoPlayerController? videoPlayerController;
  final RxBool isVideoPortrait = false.obs;

  Rxn<String> selectedMainCategoryId = Rxn<String>();

  void removeImageAt(int index) {
    if (imageSlots[index] != null) {
      log("Removed");
      removedImages["remove_image_${index + 1}"] = "remove";
      imageSlots[index] = null;
    }
  }

  Future createProduct() async {
    try {
      isLoading.value = true;

      final response = await _homeService.createProject(
        brandName: brandNameController.text.trim(),
        stock: stockController.text.trim(),
        note: noteController.text.trim(),
        terms: termsController.text.trim(),
        price: priceController.text.trim(),
        gstPrice: gstPriceController.text.trim(),
        amount: amountController.text.trim(),
        imageSlots: imageSlots,
        videoPath: selectedVideo.value?.path, // ✅ FIXED
      );

      if (response["success"] == true) {
        Get.snackbar(
          "Success",
          response["message"] ?? "Product created successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Error",
          response["message"] ?? "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.printError(info: "Create Product Error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void gstCalculate() {
    final double amount =
        double.parse(priceController.text.isEmpty ? '0.0' : priceController.text) *
        double.parse(
          selectedGST.value.toString().replaceAll("%", "").isEmpty
              ? '0.0'
              : (selectedGST.value.toString().replaceAll("%", "")),
        ) /
        100;
    gstPriceController.text = amount.toStringAsFixed(2);
    amountController.text = (amount + double.parse(priceController.text)).toStringAsFixed(2);
  }

  void selectSiteAddress(ManufacturerAddress? site) {
    if (site != null) {
      selectedSiteAddress.value = site;
      selectedSiteAddressId.value = site.id ?? 0;
      selectedSiteAddressName.value = site.addressName ?? '';
    } else {
      selectedSiteAddress.value = null;
      selectedSiteAddressId.value = 0;
      selectedSiteAddressName.value = '';
    }
  }

  Future<void> pickImage() async {
    List<XFile> results = [];
    try {
      final remainingSlots = 5 - pickedFilePathList.length;
      log("RS $remainingSlots PFL ${pickedFilePathList.length}");
      if (remainingSlots <= 0) {
        SnackBars.errorSnackBar(content: "You can only upload up to 5 images");
        return;
      }

      if (remainingSlots == 1) {
        // 🔴 Android requires single picker
        final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (file != null) {
          results.add(file);
        }
      } else {
        // ✅ Multi image picker (limit >= 2)
        results = await ImagePicker().pickMultiImage(limit: remainingSlots);
      }

      if (results.length > remainingSlots) {
        SnackBars.errorSnackBar(content: "You can only upload up to $remainingSlots images");
        return;
      }

      if (results.isNotEmpty) {
        pickedFilePathList.addAll(results.map((e) => e.path));
      }
    } catch (e) {
      log("Failed pick");
      SnackBars.errorSnackBar(content: 'Failed to pick images: $e', time: 3);
    }
  }

  Future<void> pickImageEdit() async {
    List<XFile> pickedFiles = [];
    try {
      final empSlots = imageSlots.where((e) => e == null).length;
      log("Empty $empSlots");

      if (empSlots <= 0) {
        SnackBars.errorSnackBar(content: "Maximum 5 images allowed");
        return;
      }

      if (empSlots == 1) {
        // 🔴 Android requires single picker
        final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (file != null) {
          pickedFiles.add(file);
        }
      } else {
        // ✅ Multi image picker (limit >= 2)
        pickedFiles = await ImagePicker().pickMultiImage(limit: empSlots);
      }

      if (pickedFiles.length > empSlots) {
        SnackBars.errorSnackBar(content: "You can only select up to $empSlots more images.");
        // You must exit the function here to prevent processing the excess images.
        return;
      }
      if (pickedFiles.isNotEmpty) {
        final toRemove = <String>[];
        removedImages.forEach((key, value) {
          final index = int.parse(key.split('_').last) - 1;
          if (index >= 0 && index < imageSlots.length && imageSlots[index] != null) {
            toRemove.add(key);
          }
        });
        for (final key in toRemove) {
          removedImages.remove(key);
        }
        for (final path in pickedFiles.map((e) => e.path)) {
          final emptyIndex = imageSlots.indexWhere((e) => e == null);
          if (emptyIndex != -1) {
            removedImages.remove("remove_image_${emptyIndex + 1}");
            imageSlots[emptyIndex] = path;
          } else {
            break;
          }
        }
        final hasAnyImage = imageSlots.any((e) => e != null && e.isNotEmpty);
        if (hasAnyImage) {
          removedImages.removeWhere((key, _) {
            final index = int.parse(key.split('_').last) - 1;
            return index >= 0 && index < imageSlots.length && imageSlots[index] != null;
          });
        }
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Failed to pick images: $e", time: 3);
    }
  }

  @override
  void onInit() {
    super.onInit();

    imageSlots.value = List<String?>.filled(5, null);
    if (storage.token.isNotEmpty) {
      fetchMainCategoryForProduct("connector", 'Material');
    }
  }

  Future<void> fetchMainCategoryForProduct(String mFor, String matType) async {
    if (storage.token.isEmpty) {
      log("Skipping fetchMainCategoryForProduct: No token");
      return;
    }
    String? modID;
    try {
      isLoading.value = true;
      mainCatList.clear();
      mainCatListNames.clear();
      final res = await _homeService.getAllModules(mFor: mFor);
      if (res.success == true) {
        await storage.setModuleDetails(res);
        if (res.data != null) {
          if (res.data!.modules != null) {
            if (res.data!.modules!.isNotEmpty) {
              for (int i = 0; i < res.data!.modules!.length; i++) {
                if (res.data!.modules![i].name == matType) {
                  modID = res.data!.modules![i].id;
                  final response = await _homeService.getMainCategories(moduleID: modID!);
                  if (response.success == true) {
                    if (response.data != null) {
                      mainCatList.addAll(response.data!);
                      for (int i = 0; i < mainCatList.length; i++) {
                        mainCatListNames.add(mainCatList[i]!.name ?? "");
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategoryForProduct(String mainCatID) async {
    try {
      isLoading.value = true;
      catList.clear();
      catListNames.clear();
      final res = await _homeService.getCategories(mainCatID: mainCatID);
      if (res.success == true) {
        if (res.data != null) {
          catList.addAll(res.data!);
          for (int i = 0; i < catList.length; i++) {
            catListNames.add(catList[i]!.name ?? "");
          }
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSubCategoryForProduct(String catID) async {
    try {
      isLoading.value = true;
      subCatList.clear();
      subCatListNames.clear();
      final res = await _homeService.getSubCategories(catID: catID);
      if (res.success == true) {
        if (res.data != null) {
          subCatList.addAll(res.data!);
          for (int i = 0; i < subCatList.length; i++) {
            subCatListNames.add(subCatList[i]!.name ?? "");
          }
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCCForProduct(String subCatID) async {
    try {
      isLoading.value = true;
      catProdList.clear();
      catProdListNames();
      final res = await _homeService.getCategoriesProduct(subCatID: subCatID);
      if (res.success == true) {
        if (res.data != null) {
          catProdList.addAll(res.data!);
          for (int i = 0; i < catProdList.length; i++) {
            catProdListNames.add(catProdList[i]!.name ?? "");
          }
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
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

  void removeVideo() {
    selectedVideo.value = null;
    try {
      videoPlayerController?.pause();
      videoPlayerController?.dispose();
    } catch (_) {}
    videoPlayerController = null;
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
      if (sizeInMB > 10) {
        SnackBars.errorSnackBar(content: "Video must be less than 10 MB");
        return;
      }

      selectedVideo.value = file;
      videoPlayerController?.dispose();
      videoPlayerController = VideoPlayerController.file(file);
      await videoPlayerController!.initialize();
      videoPlayerController!.setLooping(false);
      videoPlayerController!.setVolume(1.0);

      _checkVideoOrientation();
    }
  }

  void _checkVideoOrientation() {
    if (videoPlayerController != null) {
      final size = videoPlayerController!.value.size;
      isVideoPortrait.value = size.height > size.width;
      log('Video Size: ${size.width}x${size.height}, Is Portrait: ${isVideoPortrait.value}');
    }
  }

  void onMainCategorySelected(String? categoryName) {
    // if (categoryName == null) {
    //   subCategories.clear();
    //   subCategoryNames.clear();
    //   selectedSubCategory.value = null;
    //   productsList.clear();
    //   subProductsList.clear();
    //   productNames.clear();
    //   subProductNames.clear();
    //   selectedProduct.value = null;
    //   selectedMainCategory.value = null;
    //   return;
    // }

    selectedMainCatName.value = categoryName;

    final selected = mainCatList.firstWhereOrNull((c) => c?.name == categoryName);
    log("Selected ${selected?.name}, ${selected?.id} ");
    selectedMainCategoryId.value = selected?.id ?? "";
    if (selected != null) {
      fetchCategoryForProduct(selected.id ?? "");
    }
  }

  void onCategorySelected(String? categoryName) {
    selectedCatName.value = categoryName;
    final selected = catList.firstWhereOrNull((c) => c?.name == categoryName);
    if (selected != null) {
      fetchSubCategoryForProduct(selected.id ?? "");
    }
  }

  void onSubCategorySelected(String? subCategoryName) {
    selectedSubCatName.value = subCategoryName;
    final selected = subCatList.firstWhereOrNull((c) => c?.name == subCategoryName);
    if (selected != null) {
      fetchCCForProduct(selected.id ?? "");
    }
  }
}
