import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportMyTicketsModel.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportTicketCategoriesModel.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportTicketCreateModel.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportTicketPrioritiesModel.dart';

class SupportTicketCategoriesServices {
  ApiManager apiManager = ApiManager();

  /// Category
  Future<SupportTicketCategoriesModel> supportTicketCategories() async {
    try {
      final response = await apiManager.get(url: APIConstants.getSupportTicketCategories);
      return SupportTicketCategoriesModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in sendOtp: $e , $st');
    }
  }

  /// Priorities
  Future<SupportTicketPrioritiesModel> supportTicketPriorities() async {
    try {
      final response = await apiManager.get(url: APIConstants.getSupportTicketPriorities);
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
        url: APIConstants.SupportTicketCreat,
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


  /// Support My Tickets
  Future<SupportMyTicketsModel> supportMyTicketsModel({String? filter}) async {
    try {
      final qp={
        if((filter??"").isNotEmpty)
        "status":filter
      };

      final response = await apiManager.get(url: APIConstants.getSupportMyTickets,params:qp );
      return SupportMyTicketsModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in sendOtp: $e , $st');
    }
  }
}
