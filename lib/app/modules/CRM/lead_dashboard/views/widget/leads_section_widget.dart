import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/controller/lead_dash_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/stat_card_widget.dart';

class LeadsSectionWidget extends GetView<LeadDashController> {
  const LeadsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(
              'Leads',
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
          final totalLeads = controller.totalLeads.value;
          final inboundLeads = controller.inboundLeads.value;
          final outboundLeads = controller.outboundLeads.value;
          return Row(
            children: [
              Expanded(
                child: StatCardWidget(
                  title: 'Total Leads',
                  value: totalLeads.toString(),
                ),
              ),
              const Gap(12),
              Expanded(
                child: StatCardWidget(
                  title: 'Inbound Leads',
                  value: inboundLeads.toString(),
                ),
              ),
              const Gap(12),
              Expanded(
                child: StatCardWidget(
                  title: 'Outbound Leads',
                  value: outboundLeads.toString(),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
