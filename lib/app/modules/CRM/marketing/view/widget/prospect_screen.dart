import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/Prospect_status_widget.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/prospect_item_card.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/todays_leads_card.dart';

class ProspectScreen extends GetView<MarketingController> {
  const ProspectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TodaysLeadsCard(),
        const SizedBox(height: 10),
        const ProspectStatusWidget(),
        const SizedBox(height: 5),
        Obx(
          () => Column(
            children: controller.prospectLeads.isEmpty
                ? [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        'No Prospect available',
                        style: MyTexts.medium16.copyWith(color: MyColors.gray54),
                      ),
                    ),
                  ]
                : controller.prospectLeads
                      .map(
                        (l) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ProspectItemCard(
                            lead: l,
                            controller: controller,
                            status: controller.activeProspectStatusFilter.value,
                          ),
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
