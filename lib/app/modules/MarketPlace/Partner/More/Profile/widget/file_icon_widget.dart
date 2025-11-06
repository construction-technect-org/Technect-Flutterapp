import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:path/path.dart' as path;

class FileIconWidget extends StatelessWidget {
  final String fileName;
  final double? size;
  final bool showFileName;
  final TextStyle? fileNameStyle;

  const FileIconWidget({
    super.key,
    required this.fileName,
    this.size = 50.0,
    this.showFileName = false,
    this.fileNameStyle,
  });

  @override
  Widget build(BuildContext context) {
    final extension = _getFileExtension(fileName);
    final displayName = path.basename(fileName);

    final iconWidget = _buildFileIcon(extension);

    if (!showFileName) {
      return iconWidget;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        iconWidget,
        const Gap(8),
        Text(
          displayName,
          textAlign: TextAlign.center,
          style:
              fileNameStyle ??
              MyTexts.medium14.copyWith(color: MyColors.gray2E),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _getFileExtension(String fileName) {
    if (fileName.isEmpty) return '';
    final parts = fileName.toLowerCase().split('.');
    return parts.length > 1 ? parts.last : '';
  }

  Widget _buildFileIcon(String extension) {
    final iconSize = size! * 0.6;

    switch (extension) {
      case 'pdf':
        return Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            Asset.pdf,
            height: iconSize,
            width: iconSize,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.picture_as_pdf, color: Colors.red, size: iconSize),
          ),
        );

      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'bmp':
      case 'webp':
      case 'svg':
        return Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: MyColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.image, color: MyColors.primary, size: iconSize),
        );

      case 'doc':
      case 'docx':
        return Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.description, color: Colors.blue, size: iconSize),
        );

      case 'xls':
      case 'xlsx':
        return Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.table_chart, color: Colors.green, size: iconSize),
        );

      case 'ppt':
      case 'pptx':
        return Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.slideshow, color: Colors.orange, size: iconSize),
        );

      case 'txt':
      case 'rtf':
        return Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.text_snippet, color: Colors.grey, size: iconSize),
        );

      case 'zip':
      case 'rar':
      case '7z':
      case 'tar':
      case 'gz':
        return Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.purple.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.archive, color: Colors.purple, size: iconSize),
        );

      case 'mp4':
      case 'avi':
      case 'mov':
      case 'wmv':
      case 'flv':
      case 'webm':
        return Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.indigo.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.videocam, color: Colors.indigo, size: iconSize),
        );

      case 'mp3':
      case 'wav':
      case 'flac':
      case 'aac':
      case 'ogg':
        return Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.teal.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.audiotrack, color: Colors.teal, size: iconSize),
        );

      default:
        return Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.insert_drive_file,
            color: Colors.orange,
            size: iconSize,
          ),
        );
    }
  }
}
