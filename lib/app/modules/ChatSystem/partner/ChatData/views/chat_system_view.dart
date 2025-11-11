import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/ChatData/controllers/chat_system_controller.dart';
import 'package:construction_technect/app/modules/ChatSystem/partner/ChatData/controllers/chat_system_controller.dart';
import 'package:intl/intl.dart';

class ChatSystemView extends StatelessWidget {
   ChatSystemView({super.key});

  final TextEditingController messageController = TextEditingController();

  final ChatSystemController controller = Get.put(
    ChatSystemController(),
  );


   String _formatTime(DateTime dateTime) {
     final now = DateTime.now();
     final today = DateTime(now.year, now.month, now.day);
     final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

     if (messageDate == today) {
       // Today: show time only (e.g., "10:45 AM")
       return DateFormat('h:mm a').format(dateTime);
     } else if (messageDate == today.subtract(const Duration(days: 1))) {
       // Yesterday
       return 'Yesterday';
     } else if (now.difference(dateTime).inDays < 7) {
       // Within last week: show day name (e.g., "Monday")
       return DateFormat('EEEE').format(dateTime);
     } else {
       // Older: show date (e.g., "11/05/2025")
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
            CircleAvatar(
              backgroundImage: NetworkImage(controller.image),
            ),
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
            // 🔹 Message List
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
                          color:
                          isMine ? MyColors.primary : MyColors.veryPaleBlue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
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

            // 🔹 Input Area
            Container(
              color: MyColors.metricBackground,
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
