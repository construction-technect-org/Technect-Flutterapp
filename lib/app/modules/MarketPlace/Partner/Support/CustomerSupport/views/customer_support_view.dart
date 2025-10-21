import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/components/stat_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/controller/customer_support_controller.dart';
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
        body: Stack(
          children: [
            const CommonBgImage(),
            Column(
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text('Customer Support'),
                  isCenter: false,
                  leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CommonTextField(
                    onChange: (value) {
                      controller.searchTickets(value ?? "");
                    },
                    borderRadius: 22,
                    hintText: 'Search',
                    prefixIcon: SvgPicture.asset(
                      Asset.searchIcon,
                      height: 16,
                      width: 16,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                            Asset.info
                                            ,height: 24,width: 24,
                                          ),
                                          iconBackground: const Color(
                                            0xFFE53D26,
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
                                              arguments: {
                                                "status": "inprogress",
                                              },
                                            );
                                          },
                                          title: 'In Progress',
                                          value:
                                              "${controller.supportMyTickets.value.data?.statistics?.inProgressTickets ?? 0}",
                                          icon: Icon(
                                            Icons.watch_later_outlined,
                                            size: 28,
                                            color: MyColors.white,
                                          ),
                                          iconBackground: const Color(
                                            0xFFF5AC19,
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
                                          icon: SvgPicture.asset(Asset.check,height: 24,width: 24,),
                                          iconBackground: const Color(
                                            0xFF069900,
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
                                              arguments: {"status": "closed"},
                                            );
                                          },
                                          title: 'Closed',
                                          value:
                                              "${controller.supportMyTickets.value.data?.statistics?.closedTickets ?? 0}",
                                          icon: Icon(
                                            Icons.watch_later_outlined,
                                            size: 28,
                                            color: MyColors.white,
                                          ),
                                          iconBackground: const Color(
                                            0xFF0F1A36,
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
                                          Get.toNamed(Routes.REQUEST_DEMO);
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
                                          style: MyTexts.medium15.copyWith(
                                            color: MyColors.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Gap(20),
                                    Expanded(
                                      child: Center(
                                        child: RoundedButton(
                                          onTap: () {
                                            Get.toNamed(
                                              Routes.CREATE_NEW_TICKET,
                                            );
                                          },
                                          buttonName: '',
                                          borderRadius: 12,
                                          height: 40,
                                          verticalPadding: 0,
                                          horizontalPadding: 0,
                                          child: Center(
                                            child: Text(
                                              '+ Create New Ticket',
                                              style: MyTexts.medium15.copyWith(
                                                color: MyColors.white,
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
                            if (controller
                                    .supportMyTickets
                                    .value
                                    .data
                                    ?.tickets
                                    ?.isEmpty ??
                                true) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 80),
                                child: Center(
                                  child: Text(
                                    "No tickets found !!",
                                    style: MyTexts.medium15.copyWith(
                                      color: Colors.black,
                                    ),
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(16),
                                    itemCount:
                                        controller.filteredTickets.length,
                                    itemBuilder: (context, index) {
                                      final ticket =
                                          controller.filteredTickets[index];

                                      return Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: MyColors.grayF7,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: MyColors.grayEA.withValues(
                                                alpha: 0.32,
                                              ),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Row(
                                                  //   children: [
                                                  //     _buildChip(
                                                  //       ticket.ticketNumber ??
                                                  //           "",
                                                  //       MyColors.white,
                                                  //       MyColors.black,
                                                  //       borderColor: MyColors
                                                  //           .americanSilver,
                                                  //     ),
                                                  //     SizedBox(width: 2.w),
                                                  //     _buildChip(
                                                  //       ticket.statusName ??
                                                  //           "",
                                                  //       _getStatusBgColor(
                                                  //         ticket.statusName ??
                                                  //             "",
                                                  //       ),
                                                  //       MyColors.white,
                                                  //       icon: _getStatusIcon(
                                                  //         ticket.statusName ??
                                                  //             "",
                                                  //       ),
                                                  //     ),
                                                  //     SizedBox(width: 2.w),
                                                  //     _buildChip(
                                                  //       ticket.priorityName ??
                                                  //           "",
                                                  //       MyColors.white,
                                                  //       _getPriorityColor(
                                                  //         ticket.priorityName ??
                                                  //             "",
                                                  //       ),
                                                  //       borderColor:
                                                  //       _getPriorityColor(
                                                  //         ticket.priorityName ??
                                                  //             "",
                                                  //       ),
                                                  //       icon: _getPriorityIcon(
                                                  //         ticket.priorityName ??
                                                  //             "",
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  // Text(
                                                  //   "Category - ${(ticket.categoryName ?? "")
                                                  //       .capitalizeFirst ??
                                                  //       "-"}"
                                                  //   ,
                                                  //   style: MyTexts.medium16
                                                  //       .copyWith(
                                                  //     color: MyColors
                                                  //         .black,
                                                  //
                                                  //   ),
                                                  // ),
                                                  SizedBox(height: 0.8.h),
                                                  Text(
                                                    (ticket.subject ?? "")
                                                            .capitalizeFirst ??
                                                        "-",
                                                    style: MyTexts.medium15
                                                        .copyWith(
                                                          color:
                                                              MyColors.gray2E,
                                                        ),
                                                  ),
                                                  SizedBox(height: 0.8.h),
                                                  Text(
                                                    ticket.description ?? "",
                                                    style: MyTexts.medium14
                                                        .copyWith(
                                                          color:
                                                              MyColors.darkGray,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 6,
                                                  ),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(16),
                                                  bottomRight: Radius.circular(
                                                    16,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                ticket.categoryName ?? "",
                                                style: MyTexts.medium15
                                                    .copyWith(
                                                      color: MyColors.black,
                                                    ),
                                              ),
                                            ),
                                            const Gap(8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 6,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: _getPriorityColor(
                                                  ticket.priorityName ?? "",
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                      topRight: Radius.circular(
                                                        8,
                                                      ),
                                                      // topLeft: Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(16),
                                                    ),
                                              ),
                                              child: Text(
                                                ticket.priorityName ?? "",
                                                style: MyTexts.medium14
                                                    .copyWith(
                                                      color: MyColors.gray54,
                                                    ),
                                              ),
                                            ),
                                          ],
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
        return const Color(0xFFE6EDFF);
      case "High":
        return const Color(0xFFFCECE9);
      case "Low":
        return const Color(0xFFFEF7E8);
      default:
        return const Color(0xFFFCECE9);
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
