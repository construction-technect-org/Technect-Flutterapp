import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/controller/accounts_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/widget/account_qualified_status_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/widget/account_lead_item_Card.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/widget/today_account_card.dart';

class AccountQualifiedScreen extends GetView<AccountsController> {
  const AccountQualifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TodayAccountCard(),
        const SizedBox(height: 10),
        const AccountQualifiedStatusWidget(),
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
