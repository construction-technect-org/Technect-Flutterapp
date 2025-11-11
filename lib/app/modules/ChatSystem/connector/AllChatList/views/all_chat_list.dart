import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/AllChatList/controllers/all_chat_list_controller.dart';
import 'package:intl/intl.dart';

class ConnectorAllChatListScreen extends GetView<ConnectorAllChatListController> {
  const ConnectorAllChatListScreen({super.key});

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
          separatorBuilder: (_, __) => const Divider(height: 1, color: MyColors.grayEA),
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
              subtitle: Text(
                chat.chatInfo?.lastMessage ?? "",
                style: MyTexts.medium14.copyWith(color: MyColors.fontBlack.withValues(alpha: 0.7)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
                    "image": APIConstants.bucketUrl + (chat.merchant?.profileImage ?? ""),
                    "cId": chat.connectionId,
                    "name": "${chat.merchant?.firstName ?? ""} ${chat.merchant?.lastName ?? ""}",
                    "onRefresh": () {
                      controller.fetchWishList();
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
