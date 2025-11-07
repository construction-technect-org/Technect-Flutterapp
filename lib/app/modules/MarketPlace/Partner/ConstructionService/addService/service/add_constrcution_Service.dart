import 'package:construction_technect/app/core/utils/imports.dart';

class AddServiceService {
  final ApiManager apiManager = ApiManager();

  Future<ApiResponse> createService({
    required Map<String, dynamic> fields,
    Map<String, String>? files,
  }) async {
    try {
      final response = await apiManager.postMultipart(
        url: APIConstants.addService,
        fields: fields,
        files: files,
      );

      final success = response["success"] ?? false;
      final message = response["message"] ?? "No message from server";

      return ApiResponse(success: success, message: message);
    } catch (e, st) {
      debugPrint("❌ Error in createService: $e\n$st");
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse> updateService({
    required int serviceId,
    required Map<String, dynamic> fields,
    Map<String, String>? files,
  }) async {
    try {
      final response = await apiManager.putMultipart(
        url: "${APIConstants.updateService}$serviceId",
        fields: fields,
        files: files,
      );

      final success = response["success"] ?? false;
      final message = response["message"] ?? "No message from server";

      return ApiResponse(success: success, message: message);
    } catch (e, st) {
      debugPrint("❌ Error in updateService: $e\n$st");
      return ApiResponse(success: false, message: e.toString());
    }
  }
}

class ApiResponse {
  final bool success;
  final String? message;
  ApiResponse({required this.success, this.message});
}
