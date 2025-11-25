import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/prospect_status_widget.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/lead_item_Card.dart';
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
        Obx(() {
          if (controller.filteredProspect.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
              child: Center(
                child: Text(
                  "No prospect lead found",
                  style: MyTexts.medium14.copyWith(color: MyColors.gray2E),
                ),
              ),
            );
          }

          return Column(
            children: controller.filteredProspect
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
