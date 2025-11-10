import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/task/controller/task_controller.dart';

class CRMTaskScreen extends StatelessWidget {
  CRMTaskScreen({super.key});

  final controller = Get.put<CRMTaskController>(CRMTaskController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
