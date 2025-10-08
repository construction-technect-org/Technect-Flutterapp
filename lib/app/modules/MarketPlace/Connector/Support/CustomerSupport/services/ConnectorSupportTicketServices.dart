import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportMyTicketsModel.dart';

class ConnectorSupportTicketServices {
  ApiManager apiManager = ApiManager();

  /// Support My Tickets
  Future<SupportMyTicketsModel> supportMyTicketsModel({String? filter}) async {
    try {
      final qp = {if ((filter ?? "").isNotEmpty) "status": filter};

      final response = await apiManager.get(
        url: APIConstants.getConnectorSupportMyTickets,
        params: qp,
      );
      return SupportMyTicketsModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in sendOtp: $e , $st');
    }
  }
}
