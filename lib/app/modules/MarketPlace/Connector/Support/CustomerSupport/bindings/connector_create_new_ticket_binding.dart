import 'package:construction_technect/app/modules/MarketPlace/Connector/Support/AddSupportTickets/controller/connector_create_new_ticket_controller.dart';
import 'package:get/get.dart';

class ConnectorCreateNewTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorCreateNewTicketController>(
      () => ConnectorCreateNewTicketController(),
    );
  }
}
