import 'package:construction_technect/app/core/utils/chat_utils.dart';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/ChatData/controllers/connector_chat_system_controller.dart';
import 'package:construction_technect/app/modules/ChatSystem/widgets/chat_image_viewer.dart';

class ConnectorChatSystemView extends StatelessWidget {
  final ConnectorChatSystemController controller = Get.put(
    ConnectorChatSystemController(),
  );

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: MyColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.attach_file, color: MyColors.primary),
              ),
              title: const Text('Document'),
              subtitle: const Text('Share files'),
              onTap: () {
                Navigator.pop(context);
                controller.sendFile();
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: MyColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.image, color: MyColors.primary),
              ),
              title: const Text('Gallery'),
              subtitle: const Text('Choose from gallery'),
              onTap: () {
                Navigator.pop(context);
                controller.sendImageFromGallery();
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: MyColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt, color: MyColors.primary),
              ),
              title: const Text('Camera'),
              subtitle: const Text('Take a photo'),
              onTap: () {
                Navigator.pop(context);
                controller.sendImageFromCamera();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CommonAppBar(
        backgroundColor: MyColors.white,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(controller.image)),
            const SizedBox(width: 10),
            Text(
              controller.name,
              style: MyTexts.medium18.copyWith(color: MyColors.black),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final messages = controller.messages;

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.all(12),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isMine = message.sentBy == controller.currentUser.id;
                  final isRead = message.status == MessageStatus.read;

                  return Align(
                    alignment: isMine
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMine
                              ? MyColors.primary
                              : MyColors.veryPaleBlue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (message.type == 'image') ...[
                              GestureDetector(
                                onTap: () {
                                  final imageUrl =
                                      (message.mediaUrl?.startsWith('http') ??
                                          false)
                                      ? message.mediaUrl!
                                      : 'http://43.205.117.97${message.mediaUrl ?? ''}';

                                  showDialog(
                                    context: context,
                                    barrierColor: Colors.black,
                                    builder: (context) => ChatImageViewer(
                                      imageUrl: imageUrl,
                                      senderName: isMine
                                          ? 'You'
                                          : controller.name,
                                      timestamp: message.createdAt,
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                          0.65,
                                      maxHeight: 300,
                                      minHeight: 150,
                                    ),
                                    child: AspectRatio(
                                      aspectRatio: 3 / 4,
                                      child: getImageView(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.65,
                                        height: 300,
                                        fit: BoxFit.cover,
                                        finalUrl:
                                            (message.mediaUrl?.startsWith(
                                                  'http',
                                                ) ??
                                                false)
                                            ? message.mediaUrl!
                                            : 'http://43.205.117.97${message.mediaUrl ?? ''}',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (message.message.isNotEmpty &&
                                  message.message.toLowerCase() != 'photo')
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    message.message,
                                    style: MyTexts.bold14.copyWith(
                                      color: isMine
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                            ] else if (message.type == 'file') ...[
                              GestureDetector(
                                onTap: () {
                                  final fileUrl =
                                      (message.mediaUrl?.startsWith('http') ??
                                          false)
                                      ? message.mediaUrl!
                                      : 'http://43.205.117.97${message.mediaUrl ?? ''}';
                                  ChatUtils.openFile(fileUrl);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isMine
                                        ? Colors.white.withValues(alpha: 0.2)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        ChatUtils.getFileIcon(
                                          message.mediaUrl?.split('/').last ??
                                              message.message,
                                        ),
                                        size: 40,
                                        color: isMine
                                            ? Colors.white
                                            : MyColors.primary,
                                      ),
                                      const SizedBox(width: 12),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ChatUtils.extractFileName(
                                                message.mediaUrl ?? '',
                                              ),
                                              style: MyTexts.bold14.copyWith(
                                                color: isMine
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Tap to open',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: isMine
                                                    ? Colors.white70
                                                    : Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (message.message.isNotEmpty &&
                                  !ChatUtils.isFileNameOnly(message.message))
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    message.message,
                                    style: MyTexts.bold14.copyWith(
                                      color: isMine
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                            ] else
                              Text(
                                message.message,
                                style: MyTexts.bold16.copyWith(
                                  color: isMine ? Colors.white : Colors.black,
                                ),
                              ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  ChatUtils.formatTime(message.createdAt),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isMine
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ),
                                if (isMine) ...[
                                  const SizedBox(width: 4),
                                  Icon(
                                    isRead ? Icons.done_all : Icons.check,
                                    size: 14,
                                    color: isRead
                                        ? Colors.blue
                                        : Colors.white70,
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              color: MyColors.metricBackground,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add, color: MyColors.primary),
                      onPressed: () => _showAttachmentOptions(context),
                    ),
                    Expanded(
                      child: CommonTextField(
                        controller: controller.messageController,
                        hintText: "Type your message...",
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: MyColors.primary),
                      onPressed: () {
                        final text = controller.messageController.text.trim();
                        if (text.isNotEmpty) {
                          controller.onSendTap(text);
                          controller.messageController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
