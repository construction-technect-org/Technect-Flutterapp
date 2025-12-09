import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/AllChatList/model/all_chat_list_model.dart';

class VRMChatListServices {
  final ApiManager apiManager = ApiManager();

  Future<ConnectorAllChatListModel> allChatList() async {
    try {
      const String url = APIConstants.connectorChatList;
      final response = await apiManager.get(url: url);

      return ConnectorAllChatListModel.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching VRM chat list: $e');
    }
  }
}
