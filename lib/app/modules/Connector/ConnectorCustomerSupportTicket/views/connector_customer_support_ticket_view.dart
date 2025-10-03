import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorCustomerSupportTicket/controllers/connector_customer_support_ticket_controller.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorCustomerSupportTicket/views/connector_ticket_list_view.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorHome/views/connector_home_view.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorSupportRequest/views/connector_support_request_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/components/stat_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/views/creat_new_ticket.dart';
import 'package:gap/gap.dart';

class ConnectorCustomerSupportTicketView extends StatelessWidget {
  final ConnectorCustomerSupportTicketController controller = Get.put(
    ConnectorCustomerSupportTicketController(),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(
          isCenter: false,
          leading: const SizedBox(),
          leadingWidth: 0,
          title: const Text("SUPPORT TICKETS"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: CommonTextField(
                onChange: (value) {},
                borderRadius: 22,
                hintText: 'Search',
                suffixIcon: SvgPicture.asset(Asset.filterIcon, height: 20, width: 20),
                prefixIcon: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
              ),
            ),
            SizedBox(height: 1.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HearderText(text: "Customer Support Ticket"),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ConnectorSupportRequestView(), // your new screen
                                      ),
                                    );
                                  },
                                  child: StatCard(
                                    title: 'Open Tickets',
                                    value: '04',
                                    icon: SvgPicture.asset(
                                      Asset.warning,
                                      height: 20,
                                      width: 20,
                                    ),
                                    iconBackground: MyColors.red.withValues(alpha: 0.2),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: StatCard(
                                  title: 'In Progress',
                                  value: '02',
                                  icon: const Icon(
                                    Icons.watch_later_outlined,
                                    size: 30,
                                    color: MyColors.warning,
                                  ),
                                  iconBackground: MyColors.warning.withValues(alpha: 0.2),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Expanded(
                                child: StatCard(
                                  title: 'Resolved',
                                  value: '04',
                                  icon: const Icon(
                                    Icons.check_circle_rounded,
                                    size: 30,
                                    color: MyColors.green,
                                  ),
                                  iconBackground: MyColors.green.withValues(alpha: 0.2),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: StatCard(
                                  title: 'Avg Response',
                                  value: '02',
                                  icon: const Icon(
                                    Icons.watch_later_outlined,
                                    size: 30,
                                    color: MyColors.primary,
                                  ),
                                  iconBackground: MyColors.lightBlue.withValues(
                                    alpha: 0.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.CONNECTOR_REQUEST_DEMO);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(
                                      double.infinity,
                                      50,
                                    ), // Width: max, Height: 60

                                    side: const BorderSide(color: MyColors.primary),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ), // Rounded corners
                                    ),
                                  ),
                                  child: Text(
                                    "Request a Demo",
                                    style: MyTexts.medium16.copyWith(
                                      color: MyColors.primary,
                                      fontFamily: MyTexts.Roboto,
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(20),
                              Expanded(
                                child: Center(
                                  child: RoundedButton(
                                    onTap: () {
                                      Get.to(CreatNewTicket());
                                    },
                                    buttonName: '',
                                    borderRadius: 12,
                                    height: 48,
                                    verticalPadding: 0,
                                    horizontalPadding: 0,
                                    child: Center(
                                      child: Text(
                                        '+ Create New Ticket',
                                        style: MyTexts.medium16.copyWith(
                                          color: MyColors.white,
                                          fontFamily: MyTexts.Roboto,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ConnectorTicketListView(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
