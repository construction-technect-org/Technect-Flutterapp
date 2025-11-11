import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/controller/lead_dash_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/stat_card_widget.dart';

class TaskSectionWidget extends GetView<LeadDashController> {
  const TaskSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Task',
              style: MyTexts.bold18.copyWith(color: MyColors.fontBlack),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to calendar/task view
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: MyColors.grayEA),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: MyColors.fontBlack,
                ),
              ),
            ),
          ],
        ),
        const Gap(12),
        Obx(() {
          final totalTasks = controller.totalTasks.value;
          final completedTasks = controller.completedTasks.value;
          final upcomingTasks = controller.upcomingTasks.value;
          return Row(
            children: [
              Expanded(
                child: StatCardWidget(
                  title: 'Task',
                  value: totalTasks.toString(),
                ),
              ),
              const Gap(12),
              Expanded(
                child: StatCardWidget(
                  title: 'Completed',
                  value: completedTasks.toString(),
                ),
              ),
              const Gap(12),
              Expanded(
                child: StatCardWidget(
                  title: 'Up-coming',
                  value: upcomingTasks.toString(),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
