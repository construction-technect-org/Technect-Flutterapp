import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/partner/AllChatList/model/all_chat_list_model.dart';

class AllChatListServices {
  ApiManager apiManager = ApiManager();

  Future<AllChatListModel> allChatList() async {
    try {
      const String url =  APIConstants.merchantChatList ;
      debugPrint('Calling API: $url');
      final response = await apiManager.get(url: url);
      debugPrint('Response: $response');

      return AllChatListModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching chat: $e');
    }
  }
}
