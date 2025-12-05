import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/task/controller/task_controller.dart';

class CRMTaskScreen extends StatelessWidget {
  CRMTaskScreen({super.key});

  final controller = Get.put<CRMTaskController>(CRMTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: const CommonAppBar(leading: SizedBox(), leadingWidth: 0, title: Text("Task")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: MyColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(Icons.construction, size: 40, color: MyColors.primary),
            ),
            const SizedBox(height: 24),
            Text(
              'Coming Soon!',
              style: MyTexts.bold20.copyWith(color: MyColors.fontBlack),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Task feature is under development',
              style: MyTexts.regular14.copyWith(color: MyColors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Stay tuned for exciting updates!',
              style: MyTexts.regular12.copyWith(color: MyColors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
