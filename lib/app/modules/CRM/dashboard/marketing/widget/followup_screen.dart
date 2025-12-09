import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/marketing/widget/lead_item_Card.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/marketing/widget/status_view_widget.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/marketing/widget/todays_leads_card.dart';

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
            children: controller.filteredFollowups.isEmpty
                ? [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
                      child: Text(
                        'No follow-ups available',
                        style: MyTexts.medium14.copyWith(color: MyColors.gray2E),
                      ),
                    ),
                  ]
                : controller.filteredFollowups
                      .map(
                        (l) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
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
