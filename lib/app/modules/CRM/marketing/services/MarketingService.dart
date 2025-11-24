import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/model/lead_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/addService/service/add_constrcution_Service.dart';

class MarketingServices {
  final ApiManager _apiManager = ApiManager();

  Future<AllLeadModel> getAllLead({String? status}) async {
    try {
      // final data = {"status": status,};
      const String url = APIConstants.addLead;
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
    required String remindAt,
    required String leadID,
    String? assignTo,
    String? note,
    String? priority,
    bool? assignToMySelf,
  }) async {
    try {
      final body = {
        "reminder_at": remindAt,
        if (assignToMySelf == false) "team_member_id": assignTo,
        if (assignToMySelf == false) "team_member_note": note ?? "",
        if (assignToMySelf == false) "team_member_priority": (priority ?? "").toLowerCase(),
        if (assignToMySelf == true) "assign_to_self": assignToMySelf,
      };
      final response = await _apiManager.putObject(
        url: "${APIConstants.addLead}/$leadID/status",
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
