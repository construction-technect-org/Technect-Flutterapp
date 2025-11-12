import 'dart:io';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:open_filex/open_filex.dart';
import 'package:video_player/video_player.dart';

class MediaPreviewDialog extends StatefulWidget {
  final String? imagePath;
  final String? videoPath; // ✅ new
  final String? fileName;
  final IconData? fileIcon;
  final String? filePath;
  final int? fileSize;
  final Function(String caption) onSend;

  const MediaPreviewDialog({
    super.key,
    this.imagePath,
    this.videoPath, // ✅ new
    this.fileName,
    this.fileIcon,
    this.filePath,
    this.fileSize,
    required this.onSend,
  });

  @override
  State<MediaPreviewDialog> createState() => _MediaPreviewDialogState();
}

class _MediaPreviewDialogState extends State<MediaPreviewDialog> {
  final TextEditingController captionController = TextEditingController();
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.videoPath != null) {
      _videoController = VideoPlayerController.file(File(widget.videoPath!))
        ..initialize().then((_) {
          setState(() {});
          _videoController?.play();
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: EdgeInsets.zero,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Preview', style: TextStyle(color: Colors.white)),
        ),
        body: Column(
          children: [
            // Preview area
            Expanded(child: _buildPreviewContent()),

            // Caption + Send
            Container(
              color: Colors.grey[900],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: captionController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Add a caption...',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[800],
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        maxLines: 3,
                        minLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: MyColors.primary,
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          final caption = captionController.text.trim();
                          Navigator.pop(context);
                          widget.onSend(caption);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewContent() {
    // ✅ Video Preview
    if (widget.videoPath != null && _videoController != null && _videoController!.value.isInitialized) {
      return Center(
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child:VideoPlayer(_videoController!),
            ),
            _PlayPauseOverlay(controller: _videoController!),
          ],
        ),
      );
    }

    // ✅ Image Preview
    if (widget.imagePath != null) {
      return Center(
        child: Image.file(File(widget.imagePath!), fit: BoxFit.contain),
      );
    }

    // ✅ File Preview
    return _buildFileInfoCard();
  }

  Widget _buildFileInfoCard() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(30),
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: MyColors.primary.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.fileIcon ?? Icons.insert_drive_file,
                size: 80,
                color: MyColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.fileName ?? 'File',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            if (widget.fileName != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  widget.fileName!.split('.').last.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            if (widget.fileSize != null)
              Text(
                _formatFileSize(widget.fileSize!),
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
            const SizedBox(height: 24),
            if (widget.filePath != null)
              ElevatedButton.icon(
                onPressed: () async {
                  await OpenFilex.open(widget.filePath!);
                },
                icon: const Icon(Icons.visibility, color: Colors.white),
                label: const Text(
                  'Preview Document',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

/// 🔘 Play/Pause overlay
class _PlayPauseOverlay extends StatelessWidget {
  final VideoPlayerController controller;

  const _PlayPauseOverlay({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.value.isPlaying ? controller.pause() : controller.play();
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: controller.value.isPlaying
            ? const SizedBox.shrink()
            : const Icon(
          Icons.play_circle_fill,
          color: Colors.white,
          size: 80,
        ),
      ),
    );
  }
}
