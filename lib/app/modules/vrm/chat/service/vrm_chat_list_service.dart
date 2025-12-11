import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/chat/model/crm_chat_list_model.dart';

class VRMChatListServices {
  final ApiManager apiManager = ApiManager();

  Future<AllCRMGroupChatListModel> allChatList() async {
    try {
      const String url = APIConstants.vrmGroupChat;
      final response = await apiManager.get(url: url);

      return AllCRMGroupChatListModel.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching VRM chat list: $e');
    }
  }
}
