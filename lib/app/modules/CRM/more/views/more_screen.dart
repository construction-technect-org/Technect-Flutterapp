import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/more/controller/more_controller.dart';

class CRMMoreScreen extends StatelessWidget {
   CRMMoreScreen({super.key});
   final crmMoreController = Get.put<CRMMoreController>(CRMMoreController());
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
