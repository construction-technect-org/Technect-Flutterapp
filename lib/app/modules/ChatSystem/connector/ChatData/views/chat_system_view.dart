import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/ChatData/controllers/chat_system_controller.dart';

class ConnectorChatSystemView extends StatefulWidget {
  const ConnectorChatSystemView({super.key});

  @override
  State<ConnectorChatSystemView> createState() => _ConnectorChatSystemViewState();
}

class _ConnectorChatSystemViewState extends State<ConnectorChatSystemView> {
  late ConnectorChatSystemController controller;
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(ConnectorChatSystemController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black),
          onPressed: Get.back,
        ),
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text(
                                message.message,
                                style: MyTexts.bold16.copyWith(
                                  color: isMine ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                            if (isMine) ...[
                              const SizedBox(width: 6),
                              Icon(
                                isRead ? Icons.done_all : Icons.check,
                                size: 16,
                                color: isRead ? Colors.blue : Colors.white70,
                              ),
                            ],
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
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
