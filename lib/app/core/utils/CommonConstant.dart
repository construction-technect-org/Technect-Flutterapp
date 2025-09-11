import 'dart:developer';
import 'dart:io';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;

class CommonConstant {
  Future<File> compressImage(File file, {int maxSize = 1048576}) async {
    int quality = 90; // Start with high quality
    const int minQuality = 10; // Prevents excessive quality loss
    const int step = 10;

    File compressedFile = file;

    // Print original file size
    final double originalSizeMB = file.lengthSync() / 1024 / 1024;
    log('Original File Size: ${originalSizeMB.toStringAsFixed(2)} MB');

    // If file is already under the max size, return it immediately
    if (compressedFile.lengthSync() <= maxSize) {
      log('No compression needed');
      return compressedFile;
    }

    while (compressedFile.lengthSync() > maxSize && quality > minQuality) {
      final File? tempCompressed = await _compressFile(compressedFile, quality);
      if (tempCompressed != null &&
          tempCompressed.lengthSync() < compressedFile.lengthSync()) {
        compressedFile = tempCompressed;
      }
      quality -= step;
    }

    final double compressedSizeMB = compressedFile.lengthSync() / 1024 / 1024;
    log('Compressed File Size: ${compressedSizeMB.toStringAsFixed(2)} MB');
    return compressedFile;
  }

  Future<File?> _compressFile(File file, int quality) async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final String targetPath =
          '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

      final XFile? compressedFile = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: quality,
        minWidth: 1080, // Reducing resolution more aggressively
        minHeight: 720,
      );

      if (compressedFile != null) {
        return File(compressedFile.path);
      }
    } catch (e) {
      debugPrint("Compression failed: $e");
    }
    return null;
  }

  Future<XFile?> filePick() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    XFile? file;
    if (result != null) {
      final newFile = await compressImage(File(result.files.first.path ?? ''));
      file = XFile(newFile.path);
    }

    return file;
  }

  Future<XFile?> pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        // Compress the image
        final compressedFile = await compressImage(File(image.path));
        return XFile(compressedFile.path);
      }
    } catch (e) {
      debugPrint("Error picking image from gallery: $e");
    }
    return null;
  }
}
