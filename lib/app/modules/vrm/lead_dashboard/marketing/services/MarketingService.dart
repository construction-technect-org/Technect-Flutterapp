import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/addService/service/add_constrcution_Service.dart';
import 'package:construction_technect/app/modules/vrm/lead_dashboard/marketing/model/lead_model.dart';

class MarketingServices {
  final ApiManager _apiManager = ApiManager();

  Future<AllLeadModel> getAllLead({String? status, required bool isMarketing}) async {
    try {
      // final data = {"status": status,};
      final String url = isMarketing == true ? APIConstants.crmLead : APIConstants.crmSalesLead;
      debugPrint('Calling API: $url');
      // final response = await _apiManager.get(url: url, params: data);
      final response = await _apiManager.get(url: url);
      debugPrint('Response: $response');
      return AllLeadModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching products: $e');
    }
  }

  Future<ApiResponse> updateLeadStatus({
    required String leadID,
    String? assignTo,
    String? remindAt,
    String? status,
    String? note,
    String? priority,
    String? lastConversation,
    String? nextConversation,
    bool? assignToMySelf,
  }) async {
    try {
      final body = {
        if ((remindAt ?? "").isNotEmpty) "reminder_at": remindAt,
        if ((assignTo ?? "").isNotEmpty) "team_member_id": assignTo,
        if ((note ?? "").isNotEmpty) "team_member_note": note ?? "",
        if ((status ?? "").isNotEmpty) "status": status ?? "",
        if ((lastConversation ?? "").isNotEmpty) "last_conversation": lastConversation ?? "",
        if ((nextConversation ?? "").isNotEmpty) "next_conversation": nextConversation ?? "",
        if ((priority ?? "").isNotEmpty) "team_member_priority": (priority ?? "").toLowerCase(),
        if (assignToMySelf == true) "assign_to_self": assignToMySelf,
      };
      final response = await _apiManager.putObject(
        url: "${APIConstants.crmLead}/$leadID/status",
        body: body,
      );

      final data = response;
      final success = data["success"] ?? false;
      final message = data["message"] ?? "No message from server";

      return ApiResponse(success: success, message: message);
    } catch (e, st) {
      throw Exception('Error in updateProduct: $e , $st');
    }
  }
}
