import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/Prospect_status_widget.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/followup_item_card.dart';
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
            children: controller.followups.isEmpty
                ? [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        'No Prospect available',
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.gray54,
                        ),
                      ),
                    ),
                  ]
                : controller.followups
                      .map(
                        (l) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: FollowupItemCard(
                            lead: l,
                            controller: controller,
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
