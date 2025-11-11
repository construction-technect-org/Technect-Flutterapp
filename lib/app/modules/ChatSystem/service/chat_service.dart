import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/model/chat_model.dart';

class ChatServices {
  ApiManager apiManager = ApiManager();

  Future<ChatListModel> allChatList({required int cId}) async {
    try {
      final String url = "${APIConstants.messages}$cId";
      debugPrint('Calling API: $url');
      final response = await apiManager.get(url: url);
      debugPrint('Response: $response');

      return ChatListModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching chat: $e');
    }
  }
}
