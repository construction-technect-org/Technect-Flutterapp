import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorHome/views/connector_home_view.dart';
import 'package:construction_technect/app/modules/CustomerSupport/controller/customer_support_controller.dart';
import 'package:construction_technect/app/modules/CustomerSupport/views/creat_new_ticket.dart';
import 'package:construction_technect/app/modules/CustomerSupport/views/ticket_list_view.dart';
import 'package:construction_technect/app/modules/ProductManagement/components/stat_card.dart';
import 'package:gap/gap.dart';

class CustomerSupportView extends StatelessWidget {
  final CustomerSupportController controller = Get.put(
    CustomerSupportController(),
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
                onChange: (value) {
                  controller.searchQuery.value = value ?? "";
                },
                borderRadius: 22,
                hintText: 'Search',
                suffixIcon: SvgPicture.asset(
                  Asset.filterIcon,
                  height: 20,
                  width: 20,
                ),
                prefixIcon: SvgPicture.asset(
                  Asset.searchIcon,
                  height: 16,
                  width: 16,
                ),
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
                                child: Obx(() {
                                  return StatCard(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.SUPPORT_REQUEST,
                                        arguments: {"status": "open"},
                                      );
                                    },
                                    title: 'Open Tickets',
                                    value:
                                        "${controller.statistics.value.openTickets ?? 0}",
                                    icon: SvgPicture.asset(
                                      Asset.warning,
                                      height: 20,
                                      width: 20,
                                    ),
                                    iconBackground: MyColors.red.withValues(
                                      alpha: 0.2,
                                    ),
                                  );
                                }),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Obx(() {
                                  return StatCard(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.SUPPORT_REQUEST,
                                        arguments: {"status": "inprogress"},
                                      );
                                    },
                                    title: 'In Progress',
                                    value:
                                        "${controller.statistics.value.inProgressTickets ?? 0}",
                                    icon: const Icon(
                                      Icons.watch_later_outlined,
                                      size: 30,
                                      color: MyColors.warning,
                                    ),
                                    iconBackground: MyColors.warning.withValues(
                                      alpha: 0.2,
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return StatCard(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.SUPPORT_REQUEST,
                                        arguments: {"status": "resolved"},
                                      );
                                    },
                                    title: 'Resolved',
                                    value:
                                        "${controller.statistics.value.resolvedTickets ?? 0}",
                                    icon: const Icon(
                                      Icons.check_circle_rounded,
                                      size: 30,
                                      color: MyColors.green,
                                    ),
                                    iconBackground: MyColors.green.withValues(
                                      alpha: 0.2,
                                    ),
                                  );
                                }),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Obx(() {
                                  return StatCard(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.SUPPORT_REQUEST,
                                        arguments: {"status": "resolved"},
                                      );
                                    },
                                    title: 'Avg Response',
                                    value:
                                        "${controller.statistics.value.avgResponse ?? 0}",
                                    icon: const Icon(
                                      Icons.watch_later_outlined,
                                      size: 30,
                                      color: MyColors.primary,
                                    ),
                                    iconBackground: MyColors.lightBlue
                                        .withValues(alpha: 0.2),
                                  );
                                }),
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
                                    side: const BorderSide(
                                      color: MyColors.primary,
                                    ),
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
                    Obx(() {
                      if (controller.isLoadingMyTickets.value) {
                        return const Center(child: Padding(
                          padding: EdgeInsets.only(top: 70.0),
                          child: CircularProgressIndicator(),
                        ));
                      } else {
                        return TicketListView(list: controller.myTickets);
                      }
                    })
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

class RequestDemoDialog extends StatefulWidget {
  const RequestDemoDialog({super.key});

  @override
  State<RequestDemoDialog> createState() => _RequestDemoDialogState();
}

class _RequestDemoDialogState extends State<RequestDemoDialog> {
  String? selectedOption;
  final TextEditingController emailController = TextEditingController();
  final CustomerSupportController controller = Get.put(
    CustomerSupportController(),
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MyColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Request Demo",
                    style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: MyColors.red),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Video placeholder
              Container(
                height: 159,
                decoration: BoxDecoration(
                  color: MyColors.progressRemaining,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.play_circle_fill,
                    size: 48,
                    color: MyColors.white,
                  ),
                ),
              ),

              // Dropdown
              SizedBox(height: 2.h),
              Row(
                children: [
                  Text(
                    'Request Demo for',
                    style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                  ),
                  Text(
                    '*',
                    style: MyTexts.light16.copyWith(color: MyColors.red),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              CommonDropdown<String>(
                hintText: "Select Main Category",
                items: controller.mainCategories,
                selectedValue: controller.selectedMainCategory,
                // pass Rx directly
                itemLabel: (item) => item,
                onChanged: controller.isEdit
                    ? null
                    : (value) {
                        controller.onMainCategorySelected(value);
                      },
                enabled: !controller.isEdit,
              ),

              SizedBox(height: 2.h),
              // Price
              Row(
                children: [
                  Text(
                    'Company Email',
                    style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                  ),
                  Text(
                    '*',
                    style: MyTexts.light16.copyWith(color: MyColors.red),
                  ),
                ],
              ),

              SizedBox(height: 1.h),
              CustomTextField(controller: emailController, onChanged: (p0) {}),
              SizedBox(height: 2.h),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        // Submit logic here
                        Navigator.pop(context);
                      },
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(color: MyColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
