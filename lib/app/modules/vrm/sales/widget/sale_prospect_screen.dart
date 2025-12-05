import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/sales/controller/sales_controller.dart';
import 'package:construction_technect/app/modules/vrm/sales/widget/sale_lead_item_Card.dart';
import 'package:construction_technect/app/modules/vrm/sales/widget/sale_prospect_status_widget.dart';
import 'package:construction_technect/app/modules/vrm/sales/widget/today_sale_card.dart';

class SaleProspectScreen extends GetView<SalesController> {
  const SaleProspectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TodaySaleCard(),
        const SizedBox(height: 10),
        const SaleProspectStatusWidget(),
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
