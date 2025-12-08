import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/vrm/marketing/widget/add_new_lead_button.dart';
import 'package:construction_technect/app/modules/vrm/marketing/widget/lead_item_Card.dart';
import 'package:construction_technect/app/modules/vrm/marketing/widget/lead_status_widget.dart';
import 'package:construction_technect/app/modules/vrm/marketing/widget/todays_leads_card.dart';

class LeadScreen extends GetView<MarketingController> {
  const LeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TodaysLeadsCard(),
        const SizedBox(height: 18),
        AddNewLeadButton(
          onTap: () {
            Get.toNamed(
              Routes.ADD_LEAD,
              arguments: {
                "onLeadCreate": () {
                  controller.fetchAllLead();
                  Get.back();
                },
              },
            );
          },
        ),
        const Gap(8),
        const LeadStatusWidget(),
        Obx(() {
          if (controller.filteredLead.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
              child: Center(
                child: Text(
                  "No lead found",
                  style: MyTexts.medium14.copyWith(color: MyColors.gray2E),
                ),
              ),
            );
          }

          return Column(
            children: controller.filteredLead
                .map(
                  (l) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: LeadItemCard(lead: l, controller: controller),
                  ),
                )
                .toList(),
          );
        }),

        const SizedBox(height: 24),
      ],
    );
  }
}
