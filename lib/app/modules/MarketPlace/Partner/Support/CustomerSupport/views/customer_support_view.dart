import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/home/ConnectorHome/views/connector_home_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/components/stat_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/controller/customer_support_controller.dart';
import 'package:gap/gap.dart';

class CustomerSupportView extends StatelessWidget {
  final CustomerSupportController controller = Get.put(CustomerSupportController());

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
                  controller.searchTickets(value ?? "");
                },
                borderRadius: 22,
                hintText: 'Search',
                // suffixIcon: SvgPicture.asset(
                //   Asset.filterIcon,
                //   height: 20,
                //   width: 20,
                // ),
                prefixIcon: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
              ),
            ),
            SizedBox(height: 1.h),
            Expanded(
              child: RefreshIndicator(
                backgroundColor: MyColors.primary,
                color: Colors.white,
                onRefresh: () async {
                  controller.clearSearch();
                  await controller.fetchMyTickets();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
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
                                          "${controller.supportMyTickets.value.data?.statistics?.openTickets ?? 0}",
                                      icon: SvgPicture.asset(
                                        Asset.warning,
                                        height: 20,
                                        width: 20,
                                      ),
                                      iconBackground: MyColors.red.withValues(alpha: 0.2),
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
                                          "${controller.supportMyTickets.value.data?.statistics?.inProgressTickets ?? 0}",
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
                                          "${controller.supportMyTickets.value.data?.statistics?.resolvedTickets ?? 0}",
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
                                          "${controller.supportMyTickets.value.data?.statistics?.avgResponse ?? 0}",
                                      icon: const Icon(
                                        Icons.watch_later_outlined,
                                        size: 30,
                                        color: MyColors.primary,
                                      ),
                                      iconBackground: MyColors.lightBlue.withValues(
                                        alpha: 0.2,
                                      ),
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
                                        Get.toNamed(Routes.CREATE_NEW_TICKET);
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
                        if (controller.supportMyTickets.value.data?.tickets?.isEmpty ??
                            true) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child: Center(
                              child: Text(
                                "No tickets found !!",
                                style: MyTexts.regular16.copyWith(color: Colors.black),
                              ),
                            ),
                          );
                        }

                        return (controller.filteredTickets.isEmpty &&
                                controller.searchQuery.value.isNotEmpty)
                            ? Padding(
                                padding: const EdgeInsets.only(top: 100.0),
                                child: Column(
                                  children: [
                                    const Gap(20),
                                    const Icon(
                                      Icons.support_agent,
                                      size: 64,
                                      color: MyColors.grey,
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      'No tickets found',
                                      style: MyTexts.medium18.copyWith(
                                        color: MyColors.fontBlack,
                                      ),
                                    ),
                                    SizedBox(height: 0.5.h),
                                    Text(
                                      'Try searching with different keywords',
                                      style: MyTexts.regular14.copyWith(
                                        color: MyColors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(16),
                                itemCount: controller.filteredTickets.length,
                                itemBuilder: (context, index) {
                                  final ticket = controller.filteredTickets[index];

                                  return Card(
                                    color: MyColors.white,
                                    margin: const EdgeInsets.only(bottom: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: const BorderSide(
                                        color: MyColors.americanSilver,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              _buildChip(
                                                ticket.ticketNumber ?? "",
                                                MyColors.white,
                                                MyColors.black,
                                                borderColor: MyColors.americanSilver,
                                              ),
                                              SizedBox(width: 2.w),
                                              _buildChip(
                                                ticket.statusName ?? "",
                                                _getStatusBgColor(
                                                  ticket.statusName ?? "",
                                                ),
                                                MyColors.white,
                                                icon: _getStatusIcon(
                                                  ticket.statusName ?? "",
                                                ),
                                              ),
                                              SizedBox(width: 2.w),
                                              _buildChip(
                                                ticket.priorityName ?? "",
                                                MyColors.white,
                                                _getPriorityColor(
                                                  ticket.priorityName ?? "",
                                                ),
                                                borderColor: _getPriorityColor(
                                                  ticket.priorityName ?? "",
                                                ),
                                                icon: _getPriorityIcon(
                                                  ticket.priorityName ?? "",
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 1.h),
                                          Text(
                                            (ticket.subject ?? "").capitalizeFirst ?? "-",
                                            style: MyTexts.medium16
                                                .copyWith(
                                              color: MyColors.fontBlack,
                                              fontFamily:
                                              MyTexts.Roboto,
                                            ),
                                          ),
                                          SizedBox(height: 1.h),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.person_outline,
                                                size: 18,
                                                color: MyColors.darkGray,
                                              ),
                                              SizedBox(width: 0.4.w),
                                              Text(
                                                ticket.userMobile ?? "",
                                                style: MyTexts.regular14.copyWith(
                                                  color: MyColors.darkGray,
                                                  fontFamily: MyTexts.Roboto
                                                ),
                                              ),
                                              SizedBox(width: 3.w),
                                              const Icon(
                                                Icons.category,
                                                size: 16,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(width: 1.w),
                                              Text(
                                                ticket.categoryName ?? "",
                                                style: MyTexts.regular14.copyWith(
                                                  color: MyColors.darkGray,
                                                    fontFamily: MyTexts.Roboto

                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 0.8.h),
                                          Text(
                                            ticket.description ?? "",
                                            style: MyTexts.regular14.copyWith(
                                              color: MyColors.darkGray,
                                              fontFamily: MyTexts.Roboto,
                                            ),
                                          ),
                                          SizedBox(height: 1.h),
                                          Row(
                                            children: [
                                              Text(
                                                "Created: ${ticket.createdAt?.toLocal().toString().split(' ')[0] ?? ""}",
                                                style: MyTexts.bold14.copyWith(
                                                  color: MyColors.darkGray,
                                                  fontFamily: MyTexts.Roboto,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                "  ●  Updated: ${ticket.updatedAt?.toLocal().toString().split(' ')[0] ?? ""}",
                                                style: MyTexts.bold14.copyWith(
                                                  color: MyColors.darkGray,
                                                  fontFamily: MyTexts.Roboto,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "● Assigned to: ${ticket.assignedTo?.toString() ?? "Unassigned"}",
                                            style: MyTexts.bold14.copyWith(
                                              color: MyColors.darkGray,
                                              fontFamily: MyTexts.Roboto,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Status color handling
  Color _getStatusBgColor(String status) {
    switch (status) {
      case "In Progress":
        return MyColors.warning;
      case "Open":
        return MyColors.red;
      default:
        return Colors.red;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case "In Progress":
      case "Open":
        return MyColors.white;
      default:
        return MyColors.fontBlack;
    }
  }

  /// Priority color handling
  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Medium":
        return MyColors.warning;
      case "High":
        return MyColors.red;
      default:
        return MyColors.fontBlack;
    }
  }

  /// Get icon for status
  Widget? _getStatusIcon(String status) {
    switch (status) {
      case "In Progress":
        return Image.asset(Asset.inprog, width: 14, height: 14);
      case "Open":
        return Image.asset(
          Asset.operations,
          width: 14,
          height: 14,
          color: MyColors.white,
        );
      default:
        return null;
    }
  }

  /// Get icon for priority
  Widget? _getPriorityIcon(String priority) {
    switch (priority) {
      case "Medium":
        return Image.asset(Asset.management, width: 14, height: 14);
      case "High":
        return Image.asset(Asset.operations, width: 14, height: 14);
      default:
        return null;
    }
  }

  Widget _buildChip(
    String text,
    Color bgColor,
    Color textColor, {
    Color? borderColor,
    Widget? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor ?? Colors.transparent),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon, const SizedBox(width: 4)],
          Text(text, style: MyTexts.bold14.copyWith(color: textColor)),
        ],
      ),
    );
  }
}
