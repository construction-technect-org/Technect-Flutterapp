import 'package:construction_technect/app/modules/CRM/reminder/controller/reminder_controller.dart';
import 'package:get/get.dart';

class ReminderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetReminderController>(() => SetReminderController());
  }
}
