import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/sales/controller/sales_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/sales/widget/sale_lead_item_Card.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/sales/widget/sale_status_view_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/sales/widget/today_sale_card.dart';

class SaleFollowupScreen extends GetView<SalesController> {
  const SaleFollowupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TodaySaleCard(),
        const SizedBox(height: 10),
        const SaleStatusViewWidget(),
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
                          child: SaleItemCard(lead: l, controller: controller),
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
