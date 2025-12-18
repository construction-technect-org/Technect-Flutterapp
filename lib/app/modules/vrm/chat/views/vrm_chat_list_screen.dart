import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/chat/controllers/vrm_chat_list_controller.dart';
import 'package:intl/intl.dart';

class VRMChatListScreen extends GetView<VRMChatListController> {
  const VRMChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: const CommonAppBar(title: Text("Chats"),isCenter: false,leadingWidth: 0,leading: SizedBox(), ),
      body: RefreshIndicator(
        backgroundColor: MyColors.primary,
        color: Colors.white,
        onRefresh: ()async{
          await controller.fetchChatList();
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if ((controller.chatListModel.value.data?.groups ?? []).isEmpty) {
            return Center(
              child: Text(
                "No conversations yet",
                style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            itemCount: (controller.chatListModel.value.data?.groups ?? []).length,
            separatorBuilder: (_, _) => const Divider(height: 1, color: MyColors.grayEA),
            itemBuilder: (context, index) {
              final chat = (controller.chatListModel.value.data?.groups ?? [])[index];
              final int unreadCount = chat.unreadCount ?? 0;

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 6),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: getImageView(finalUrl: APIConstants.bucketUrl + (chat.merchantLogo ?? ""),),
                ),
                title: Text(
                  chat.groupName ?? "",
                  style: MyTexts.bold16.copyWith(color: MyColors.primary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                subtitle: Row(
                  children: [
                    if (_isImageMessage(chat.lastMessage)) ...[
                      const Icon(Icons.image, size: 16, color: MyColors.fontBlack),
                      const SizedBox(width: 4),
                    ],
                    Expanded(
                      child: Text(
                        _getDisplayMessage(chat.lastMessage),
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
                      formattedChatTime(DateTime.tryParse(chat.lastMessageTime ?? '')),
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
                      "groupId": chat.groupId ?? 0,
                      "groupName": chat.groupName ?? "Unknown",
                      "groupImage": chat.merchantLogo ?? "Unknown",
                      "myUserID": chat.connectorId ?? 0,
                    },
                  );
                },
              );
            },
          );
        }),
      ),
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
