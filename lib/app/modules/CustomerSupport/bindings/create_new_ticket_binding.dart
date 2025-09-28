import 'package:get/get.dart';
import 'package:construction_technect/app/modules/CustomerSupport/controller/create_new_ticket_controller.dart';

class CreateNewTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateNewTicketController>(() => CreateNewTicketController());
  }
}
