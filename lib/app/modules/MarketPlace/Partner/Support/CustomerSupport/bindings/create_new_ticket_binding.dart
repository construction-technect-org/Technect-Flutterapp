import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/controller/create_new_ticket_controller.dart';
import 'package:get/get.dart';

class CreateNewTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateNewTicketController>(() => CreateNewTicketController());
  }
}
