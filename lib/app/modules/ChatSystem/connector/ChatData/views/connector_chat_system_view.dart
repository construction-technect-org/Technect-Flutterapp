import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/ChatData/controllers/connector_chat_system_controller.dart';
import 'package:construction_technect/app/modules/ChatSystem/widgets/chat_image_viewer.dart';
import 'package:intl/intl.dart';

class ConnectorChatSystemView extends StatelessWidget {
  final ConnectorChatSystemController controller = Get.put(
    ConnectorChatSystemController(),
  );
  final TextEditingController messageController = TextEditingController();

  String _formatTime(DateTime dateTime) {
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
                            if (message.type == 'image')
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
                              )
                            else
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
                                  _formatTime(message.createdAt),
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
                    Expanded(
                      child: CommonTextField(
                        controller: messageController,
                        hintText: "Type your message...",
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.image, color: MyColors.primary),
                      onPressed: () async {
                        await controller.sendImageFromGallery();
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: MyColors.primary,
                      ),
                      onPressed: () async {
                        await controller.sendImageFromCamera();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: MyColors.primary),
                      onPressed: () {
                        final text = messageController.text.trim();
                        if (text.isNotEmpty) {
                          controller.onSendTap(text);
                          messageController.clear();
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
