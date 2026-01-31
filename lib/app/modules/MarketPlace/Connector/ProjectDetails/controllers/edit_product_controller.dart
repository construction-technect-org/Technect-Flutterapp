import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ProjectDetails/views/media_bottom_sheet.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class EditProductController extends GetxController {
  final isEditLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController pNameController = TextEditingController();
  final TextEditingController pCodeController = TextEditingController();
  final TextEditingController pAreaController = TextEditingController();
  final TextEditingController pAddressController = TextEditingController();
  final TextEditingController pFloorsController = TextEditingController();
  final TextEditingController pTypeController = TextEditingController();
  final TextEditingController pDescController = TextEditingController();
  RxString selectedValue = "".obs;

  final ImagePicker _picker = ImagePicker();
  RxList<PlatformFile> images = <PlatformFile>[].obs;
  //RxList<String?> images = List<String?>.filled(5, null).obs;
  RxList<PlatformFile> pdfs = <PlatformFile>[].obs;
  Rx<PlatformFile?> video = Rx<PlatformFile?>(null);
  Map<String, String> removedImages = {};

  // Convert bytes to MB
  double _bytesToMb(int bytes) => bytes / (1024 * 1024);

  Future<void> pickImages() async {
    if (images.length >= 5) {
      SnackBars.errorSnackBar(content: "Maximum 5 images allowed");
      return;
    }

    final List<XFile>? pickedImages = await _picker.pickMultiImage();

    if (pickedImages != null) {
      for (var img in pickedImages) {
        if (images.length >= 5) {
          SnackBars.errorSnackBar(content: "Maximum 5 images allowed");
          break;
        }

        final file = File(img.path);
        final sizeMb = _bytesToMb(file.lengthSync());

        if (sizeMb > 2) {
          SnackBars.errorSnackBar(
            content: "File too large, Image must be ≤ 2 MB",
          );
          continue;
        }

        images.add(
          PlatformFile(name: img.name, path: img.path, size: file.lengthSync()),
        );
      }
    }
  }

  // Add Image
  /*Future<void> _pickImages() async {
    List<XFile> pickedFiles = [];
    final emptySlots = images.where((e) => e == null).length;
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
        if (index >= 0 && index < images.length && images[index] != null) {
          toRemove.add(key);
        }
      });
      for (final key in toRemove) {
        removedImages.remove(key);
      }
      for (var path in pickedFiles.map((e) => e.path)) {
        final emptyIndex = images.indexWhere((e) => e == null);
        if (emptyIndex != -1) {
          removedImages.remove("remove_image_${emptyIndex + 1}");
          images[emptyIndex] = path;
        } else {
          break;
        }
      }
      final hasAnyImage = images.any(
        (e) => e != null && e.toString().isNotEmpty,
      );
      if (hasAnyImage) {
        removedImages.removeWhere((key, value) {
          final index = int.parse(key.split('_').last) - 1;
          return index >= 0 && index < images.length && images[index] != null;
        });
      }
    }
  } */

  // Add Video
  Future<void> pickVideo() async {
    if (video.value != null) {
      Get.snackbar("Limit Reached", "Only 1 video allowed");
      return;
    }

    final XFile? picked = await _picker.pickVideo(source: ImageSource.gallery);

    if (picked != null) {
      final file = File(picked.path);
      final sizeMb = _bytesToMb(file.lengthSync());

      if (sizeMb > 10) {
        Get.snackbar("File too large", "Video must be ≤ 10 MB");
        return;
      }

      video.value = PlatformFile(
        name: picked.name,
        path: picked.path,
        size: file.lengthSync(),
      );
    }
  }

  // Add PDF
  Future<void> pickPDF() async {
    if (pdfs.length >= 2) {
      Get.snackbar("Limit Reached", "Only 2 PDFs allowed");
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final file = result.files.first;
      final sizeMb = _bytesToMb(file.size);

      if (sizeMb > 5) {
        Get.snackbar("File too large", "PDF must be ≤ 5 MB");
        return;
      }

      pdfs.add(file);
    }
  }

  void removeImage(int index) => images.removeAt(index);
  void removePdf(int index) => pdfs.removeAt(index);
  void removeVideo() => video.value = null;

  void openMediaBottomSheet() {
    Get.bottomSheet(
      MediaBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}
