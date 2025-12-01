import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/controller/accounts_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/widget/account_lead_item_Card.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/widget/account_status_view_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/widget/today_account_card.dart';

class AccountOutstandingScreen extends GetView<AccountsController> {
  const AccountOutstandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TodayAccountCard(),
        const SizedBox(height: 18),
        GestureDetector(
          onTap: () {
            // Get.toNamed(
            //   Routes.Add_New_REQUIREMENT,
            //   arguments: {
            //     "onLeadCreate": () {
            //       controller.fetchAllLead();
            //       Get.back();
            //     },
            //   },
            // );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: MyColors.grayEA),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add, size: 22),
                const SizedBox(width: 8),
                Text('Add New Bill', style: MyTexts.medium14),
              ],
            ),
          ),
        ),
        const Gap(8),
        const AccountStatusViewWidget(),
        Obx(
          () => Column(
            children: controller.filteredFollowups.isEmpty
                ? [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
                      child: Text(
                        'No Out Standing Bills available',
                        style: MyTexts.medium14.copyWith(color: MyColors.gray2E),
                      ),
                    ),
                  ]
                : controller.filteredFollowups
                      .map(
                        (l) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: AccountItemCard(lead: l, controller: controller),
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
