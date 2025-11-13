import 'dart:developer';
import 'dart:io';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';

class ChatUtils {
  /// Format message timestamp for display
  static String formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      return DateFormat('h:mm a').format(dateTime);
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else if (now.difference(dateTime).inDays < 7) {
      return DateFormat('EEEE').format(dateTime);
    } else {
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }
  }

  /// Get appropriate icon for file type
  static IconData getFileIcon(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'txt':
        return Icons.text_snippet;
      case 'zip':
        return Icons.folder_zip;
      default:
        return Icons.insert_drive_file;
    }
  }

  static Future<void> openFile(String fileUrl) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator(color: Colors.white)),
        barrierDismissible: false,
      );

      String localPath;

      if (fileUrl.startsWith('http://') || fileUrl.startsWith('https://')) {
        final fileName = fileUrl.split('/').last;
        final dir = await getTemporaryDirectory();
        localPath = '${dir.path}/$fileName';

        final file = File(localPath);
        if (!await file.exists()) {
          final response = await http.get(Uri.parse(fileUrl));
          if (response.statusCode == 200) {
            await file.writeAsBytes(response.bodyBytes);
          } else {
            throw Exception('Failed to download file');
          }
        }
      } else {
        localPath = fileUrl;
      }

      Get.back();

      final result = await OpenFilex.open(localPath);

      if (result.type != ResultType.done) {
        Get.snackbar(
          'Error',
          'Could not open file: ${result.message}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      Get.snackbar(
        'Error',
        'Could not open file: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Extract clean filename from media URL by removing timestamp prefix
  static String extractFileName(String mediaUrl) {
    if (mediaUrl.isEmpty) return 'File';

    try {
      final fileName = mediaUrl.split('/').last;
      // Remove timestamp prefix if exists (format: timestamp_actualfilename.ext)
      final parts = fileName.split('_');
      if (parts.length > 1 && int.tryParse(parts[0]) != null) {
        return parts.sublist(1).join('_');
      }
      return fileName;
    } catch (e) {
      return 'File';
    }
  }

  /// Check if message text is just a filename (not a caption)
  static bool isFileNameOnly(String message) {
    final extensions = [
      '.pdf',
      '.doc',
      '.docx',
      '.xls',
      '.xlsx',
      '.txt',
      '.zip',
    ];
    return extensions.any((ext) => message.toLowerCase().endsWith(ext));
  }

  /// Generate video thumbnail from local or remote video URL
  static Future<String?> getVideoThumbnail(String videoUrl) async {
    try {
      // Download video to temp directory if it's a remote URL
      if (videoUrl.startsWith('http')) {
        final tempDir = await getTemporaryDirectory();
        final fileName = videoUrl.split('/').last;
        final localPath = '${tempDir.path}/$fileName';
        final file = File(localPath);

        // Check if already downloaded
        if (!await file.exists()) {
          final response = await http.get(Uri.parse(videoUrl));
          if (response.statusCode == 200) {
            await file.writeAsBytes(response.bodyBytes);
          } else {
            return null;
          }
        }

        // Generate thumbnail from local file
        final thumbnailFile = await VideoCompress.getFileThumbnail(
          localPath,
          quality: 50,
        );
        return thumbnailFile.path;
      }

      // If it's a local file
      final thumbnailFile = await VideoCompress.getFileThumbnail(
        videoUrl,
        quality: 50,
      );
      return thumbnailFile.path;
    } catch (e) {
      log("❌ Error generating thumbnail: $e");
      return null;
    }
  }

  /// Check if message text is a video filename (contains video extension or path)
  static bool isVideoFileName(String message) {
    final videoExtensions = [
      '.mp4',
      '.mov',
      '.avi',
      '.mkv',
      '.3gp',
      '.m4v',
      '.wmv',
      '.flv',
    ];
    final lowerMessage = message.toLowerCase();
    return videoExtensions.any((ext) => lowerMessage.endsWith(ext)) ||
        lowerMessage.contains('/') || // Contains path separator
        lowerMessage.contains('\\'); // Contains Windows path separator
  }

  /// Build video thumbnail widget with play button overlay
  static Widget buildVideoThumbnailView(String? url) {
    if (url == null || url.isEmpty) {
      return Container(
        constraints: const BoxConstraints(
          maxWidth: 250,
          maxHeight: 200,
          minHeight: 150,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Icon(Icons.play_circle_outline, size: 60, color: Colors.white),
        ),
      );
    }

    // Build full URL if it's a relative path
    final videoUrl = url.startsWith('http') ? url : 'http://43.205.117.97$url';

    return FutureBuilder<String?>(
      future: getVideoThumbnail(videoUrl),
      builder: (context, snapshot) {
        return Container(
          constraints: const BoxConstraints(
            maxWidth: 250,
            maxHeight: 200,
            minHeight: 150,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Thumbnail or placeholder
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(snapshot.data!),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.videocam,
                          size: 50,
                          color: Colors.white54,
                        ),
                      );
                    },
                  ),
                )
              else if (snapshot.connectionState == ConnectionState.waiting)
                const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white54,
                  ),
                )
              else
                const Center(
                  child: Icon(Icons.videocam, size: 50, color: Colors.white54),
                ),

              // Dark overlay for better play icon visibility
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withValues(alpha: 0.3),
                ),
              ),

              // Play icon overlay
              const Center(
                child: Icon(
                  Icons.play_circle_outline,
                  size: 50,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
