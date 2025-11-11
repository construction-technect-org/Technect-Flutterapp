import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/AllChatList/model/all_chat_list_model.dart';

class ConnectorAllChatListServices {
  ApiManager apiManager = ApiManager();

  Future<AllChatListModel> allChatList() async {
    try {
      final bool isPartner = myPref.role.val == "connector";
      final String url = !isPartner ? APIConstants.merchantChatList : APIConstants.connectorChatList;
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
