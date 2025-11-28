import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/sales/controller/sales_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/sales/widget/sale_lead_status_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/sales/widget/sale_lead_item_Card.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/sales/widget/today_sale_card.dart';

class SaleLeadScreen extends GetView<SalesController> {
  const SaleLeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TodaySaleCard(),
        // const SizedBox(height: 18),
        // GestureDetector(
        //   onTap: () {
        //     Get.toNamed(
        //       Routes.Add_New_REQUIREMENT,
        //       arguments: {
        //         "onLeadCreate": () {
        //           controller.fetchAllLead();
        //           Get.back();
        //         },
        //       },
        //     );
        //   },
        //   child: Container(
        //     margin: const EdgeInsets.symmetric(horizontal: 20),
        //     padding: const EdgeInsets.symmetric(vertical: 11),
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(12),
        //       border: Border.all(color: MyColors.grayEA),
        //     ),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         const Icon(Icons.add, size: 22),
        //         const SizedBox(width: 8),
        //         Text('Add New Requirement', style: MyTexts.medium14),
        //       ],
        //     ),
        //   ),
        // ),
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
