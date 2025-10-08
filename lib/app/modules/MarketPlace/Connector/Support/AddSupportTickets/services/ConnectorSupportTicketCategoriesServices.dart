import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportTicketCategoriesModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportTicketCreateModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportTicketPrioritiesModel.dart';

class ConnectorSupportTicketCategoriesServices {
  ApiManager apiManager = ApiManager();

  /// Category
  Future<SupportTicketCategoriesModel> supportTicketCategories() async {
    try {
      final response = await apiManager.get(
        url: APIConstants.getConnectorSupportTicketCategories,
      );
      return SupportTicketCategoriesModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in sendOtp: $e , $st');
    }
  }

  /// Priorities
  Future<SupportTicketPrioritiesModel> supportTicketPriorities() async {
    try {
      final response = await apiManager.get(
        url: APIConstants.getConnectorSupportTicketPriorities,
      );
      return SupportTicketPrioritiesModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in sendOtp: $e , $st');
    }
  }

  /// Support Ticket Create
  Future<SupportTicketCreateModel> supportTicketCreate({
    required String categoryId,
    required String priorityId,
    required String subject,
    required String description,
  }) async {
    try {
      final response = await apiManager.postObject(
        url: APIConstants.ConnectorSupportTicketCreate,
        body: {
          "category_id": categoryId,
          "priority_id": priorityId,
          "subject": subject,
          "description": description,
        },
      );
      return SupportTicketCreateModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in login: $e , $st');
    }
  }
}
