import 'dart:io';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:open_filex/open_filex.dart';

class MediaPreviewDialog extends StatelessWidget {
  final String? imagePath;
  final String? fileName;
  final IconData? fileIcon;
  final String? filePath;
  final int? fileSize;
  final Function(String caption) onSend;

  const MediaPreviewDialog({
    super.key,
    this.imagePath,
    this.fileName,
    this.fileIcon,
    this.filePath,
    this.fileSize,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController captionController = TextEditingController();

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

            // Caption input area
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
                          onSend(caption);
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
    // Show image preview
    if (imagePath != null) {
      return Center(child: Image.file(File(imagePath!), fit: BoxFit.contain));
    }

    // Show file info card with preview button for documents
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
            // File Icon with background
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: MyColors.primary.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                fileIcon ?? Icons.insert_drive_file,
                size: 80,
                color: MyColors.primary,
              ),
            ),
            const SizedBox(height: 24),

            // File Name
            Text(
              fileName ?? 'File',
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

            // File Extension Badge
            if (fileName != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  fileName!.split('.').last.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 12),

            // File Size
            if (fileSize != null)
              Text(
                _formatFileSize(fileSize!),
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
            const SizedBox(height: 24),

            // Preview File Button
            if (filePath != null)
              ElevatedButton.icon(
                onPressed: () async {
                  await OpenFilex.open(filePath!);
                },
                icon: const Icon(Icons.visibility, color: Colors.white),
                label: const Text(
                  'Preview Document',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
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
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }
}
