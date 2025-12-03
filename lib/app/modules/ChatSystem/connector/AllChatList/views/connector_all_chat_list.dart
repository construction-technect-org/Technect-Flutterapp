import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/AllChatList/controllers/controller_all_chat_list_controller.dart';
import 'package:intl/intl.dart';

class ConnectorAllChatListScreen extends GetView<ConnectorAllChatListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: const CommonAppBar(title: Text("Chats")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if ((controller.chatListModel.value.chats?.conversations ?? []).isEmpty) {
          return Center(
            child: Text(
              "No conversations yet",
              style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          itemCount: (controller.chatListModel.value.chats?.conversations ?? []).length,
          separatorBuilder: (_, _) => const Divider(height: 1, color: MyColors.grayEA),
          itemBuilder: (context, index) {
            final chat = (controller.chatListModel.value.chats?.conversations ?? [])[index];
            final int unreadCount = chat.chatInfo?.unreadCount ?? 0;

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 6),
              leading: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  APIConstants.bucketUrl + (chat.merchant?.profileImage ?? ""),
                ),
              ),
              title: Text(
                "${chat.merchant?.firstName ?? ""} ${chat.merchant?.lastName ?? ""}",
                style: MyTexts.bold16.copyWith(color: MyColors.primary),
              ),
              subtitle: Row(
                children: [
                  if (_isImageMessage(chat.chatInfo?.lastMessage)) ...[
                    const Icon(Icons.image, size: 16, color: MyColors.fontBlack),
                    const SizedBox(width: 4),
                  ],
                  Expanded(
                    child: Text(
                      _getDisplayMessage(chat.chatInfo?.lastMessage),
                      style: MyTexts.medium14.copyWith(
                        color: MyColors.fontBlack.withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formattedChatTime(DateTime.tryParse(chat.chatInfo?.lastMessageTime ?? '')),
                    style: MyTexts.medium14.copyWith(color: MyColors.black),
                  ),
                  if (unreadCount > 0)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: MyColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        unreadCount.toString(),
                        style: MyTexts.bold12.copyWith(color: Colors.white),
                      ),
                    ),
                ],
              ),
              onTap: () {
                Get.toNamed(
                  Routes.CONNECTOR_CHAT_SYSTEM,
                  arguments: {
                    "chatData": chat,
                    "onRefresh": () {
                      controller.fetchChatList();
                    },
                  },
                );
              },
            );
          },
        );
      }),
    );
  }

  bool _isImageMessage(String? message) {
    if (message == null || message.isEmpty) return false;
    // Check if message starts with common image indicators
    return message.toLowerCase().startsWith('image') ||
        message.toLowerCase().startsWith('photo') ||
        message.toLowerCase().startsWith('📷') ||
        message.contains('.jpg') ||
        message.contains('.jpeg') ||
        message.contains('.png') ||
        message.contains('.gif') ||
        message.contains('.webp') ||
        message.contains('/uploads/');
  }

  String _getDisplayMessage(String? message) {
    if (message == null || message.isEmpty) return '';

    // If it's an image message, return a friendly text
    if (_isImageMessage(message)) {
      return 'Photo';
    }

    return message;
  }

  String formattedChatTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final diff = now.difference(dateTime);

    final today = DateTime(now.year, now.month, now.day);
    final messageDay = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (today.difference(messageDay).inDays == 0) {
      return DateFormat('hh:mm a').format(dateTime);
    }

    if (today.difference(messageDay).inDays == 1) {
      return 'Yesterday';
    }

    if (diff.inDays < 7) {
      return DateFormat('EEEE').format(dateTime);
    }
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
}
