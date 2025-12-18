import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/chat/model/crm_chat_list_model.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/ChatData/model/group_chat_info_model.dart';

class CRMChatListServices {
  final ApiManager apiManager = ApiManager();

  Future<AllCRMGroupChatListModel> allChatList() async {
    try {
      const String url = APIConstants.crmGroupChat;
      final response = await apiManager.get(url: url);

      return AllCRMGroupChatListModel.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching VRM chat list: $e');
    }
  }

  Future<GroupChatInfoModel> groupChatInfo({required int gId}) async {
    try {
      final String url = "${APIConstants.crmGroupChat}/$gId";
      final response = await apiManager.get(url: url);

      return GroupChatInfoModel.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching VRM chat list: $e');
    }
  }
}
