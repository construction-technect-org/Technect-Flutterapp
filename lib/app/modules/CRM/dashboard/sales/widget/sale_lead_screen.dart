import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/sales/controller/sales_controller.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/sales/widget/sale_lead_item_Card.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/sales/widget/sale_lead_status_widget.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/sales/widget/today_sale_card.dart';

class SaleLeadScreen extends GetView<SalesController> {
  const SaleLeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TodaySaleCard(),
        const Gap(8),
        const SaleLeadStatusWidget(),
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
                    child: SaleItemCard(lead: l, controller: controller),
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
