import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/marketing/widget/lead_item_Card.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/marketing/widget/qualified_status_widget.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/marketing/widget/todays_leads_card.dart';

class QualifiedScreen extends GetView<MarketingController> {
  const QualifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TodaysLeadsCard(),
        const SizedBox(height: 10),
        const QualifiedStatusWidget(),
        Obx(
          () => Column(
            children: controller.filteredQualified.isEmpty
                ? [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
                      child: Text(
                        'No qualified lead available',
                        style: MyTexts.medium14.copyWith(color: MyColors.gray2E),
                      ),
                    ),
                  ]
                : controller.filteredQualified
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
