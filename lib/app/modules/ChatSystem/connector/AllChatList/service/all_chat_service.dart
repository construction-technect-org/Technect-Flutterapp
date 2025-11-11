import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/AllChatList/model/all_chat_list_model.dart';

class ConnectorAllChatListServices {
  ApiManager apiManager = ApiManager();

  Future<ConnectorAllChatListModel> allChatList() async {
    try {
      const String url =  APIConstants.connectorChatList;
      debugPrint('Calling API: $url');
      final response = await apiManager.get(url: url);
      debugPrint('Response: $response');

      return ConnectorAllChatListModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching chat: $e');
    }
  }
}
