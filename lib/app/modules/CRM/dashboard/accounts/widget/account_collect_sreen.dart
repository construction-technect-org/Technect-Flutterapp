import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/accounts/controller/accounts_controller.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/accounts/widget/account_lead_item_Card.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/accounts/widget/today_account_card.dart';

class AccountCollectScreen extends GetView<AccountsController> {
  const AccountCollectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TodayAccountCard(),
        const Gap(15),
        // const SearchSortWidget(),
        // const Gap(20),
        Obx(() {
          if (controller.filteredProspect.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
              child: Center(
                child: Text(
                  "No Collect found",
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
                    child: AccountItemCard(lead: l, controller: controller),
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
