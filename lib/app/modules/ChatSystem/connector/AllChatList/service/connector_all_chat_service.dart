import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/AllChatList/model/all_chat_list_model.dart';

class ConnectorAllChatListServices {
  ApiManager apiManager = ApiManager();

  Future<ConnectorAllChatListModel> allChatList() async {
    try {
      const String url = APIConstants.connectorChatList;
      final response = await apiManager.get(url: url);

      return ConnectorAllChatListModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error fetching chat: $e');
    }
  }
}
