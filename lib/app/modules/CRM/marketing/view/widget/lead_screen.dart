import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/add_new_lead_button.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/lead_item_Card.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/todays_leads_card.dart';

class LeadScreen extends GetView<MarketingController> {
  const LeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AddNewLeadButton(
          onTap: () {
            Get.toNamed(Routes.ADD_LEAD);
          },
        ),
        const SizedBox(height: 18),
        const TodaysLeadsCard(),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Lead Details', style: MyTexts.medium18),
        ),
        Obx(
          () => Column(
            children: controller.leads
                .map(
                  (l) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: LeadItemCard(lead: l, controller: controller),
                  ),
                )
                .toList(),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
