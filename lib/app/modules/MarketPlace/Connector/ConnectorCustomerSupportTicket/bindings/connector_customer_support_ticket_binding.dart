import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorCustomerSupportTicket/controllers/connector_customer_support_ticket_controller.dart';
import 'package:get/get.dart';

class ConnectorCustomerSupportTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorCustomerSupportTicketController>(() => ConnectorCustomerSupportTicketController());
  }
}
