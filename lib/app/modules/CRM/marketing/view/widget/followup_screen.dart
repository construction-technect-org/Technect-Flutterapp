import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/lead_item_Card.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/status_view_widget.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/todays_leads_card.dart';

class FollowupScreen extends GetView<MarketingController> {
  const FollowupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TodaysLeadsCard(),
        const SizedBox(height: 10),
        const StatusViewWidget(),
        Obx(
          () => Column(
            children: controller.allFollowUpList.isEmpty
                ? [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        'No follow-ups available',
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.gray54,
                        ),
                      ),
                    ),
                  ]
                : controller.allFollowUpList
                      .map(
                        (l) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: LeadItemCard(
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
