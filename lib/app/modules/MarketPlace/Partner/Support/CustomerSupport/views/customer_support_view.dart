import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/components/stat_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/controller/customer_support_controller.dart';

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
        body: Stack(
          children: [
            const CommonBgImage(),
            Column(
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text('Customer Support'),
                  isCenter: true,
                  leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.black.withOpacity(0.05),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
                    ),
                  ),
                  actions: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.black.withOpacity(0.05),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert, color: Colors.black),
                      ),
                    ),
                    const Gap(8),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Financial Year",
                        style: MyTexts.medium16.copyWith(color: MyColors.black),
                      ),
                      Container(
                        width: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: MyColors.greyFour),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Select Year",
                              style: MyTexts.regular14.copyWith(color: MyColors.grey),
                            ),
                            const Icon(Icons.calendar_today_outlined, size: 16, color: MyColors.grey),
                          ],
                        ),
                      ),
                    ],
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
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Obx(() {
                                        return StatCard(
                                          title: 'Total Ticket',
                                          value:
                                              "${controller.supportMyTickets.value.data?.statistics?.openTickets ?? 0}",
                                          gradient: const LinearGradient(
                                            colors: [Color(0xFFB5E8ED), Color(0xFFFDFDFD)],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        );
                                      }),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Obx(() {
                                        return StatCard(
                                          title: 'Total Active Ticket',
                                          value:
                                              "${controller.supportMyTickets.value.data?.statistics?.inProgressTickets ?? 0}",
                                          gradient: const LinearGradient(
                                            colors: [Color(0xFFC7F9C7), Color(0xFFFDFDFD)],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                const Gap(12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Obx(() {
                                        return StatCard(
                                          title: 'Total Pending Ticket',
                                          value:
                                              "${controller.supportMyTickets.value.data?.statistics?.resolvedTickets ?? 0}",
                                          gradient: const LinearGradient(
                                            colors: [Color(0xFFF9C7F9), Color(0xFFFDFDFD)],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        );
                                      }),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Obx(() {
                                        return StatCard(
                                          title: 'Total Closed Tickets',
                                          value:
                                              "${controller.supportMyTickets.value.data?.statistics?.closedTickets ?? 0}",
                                          gradient: const LinearGradient(
                                            colors: [Color(0xFFFDF9C7), Color(0xFFFDFDFD)],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                const Gap(24),
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
                                            width: 1.5,
                                          ),
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: Text(
                                          "Request a Demo",
                                          style: MyTexts.bold16.copyWith(color: MyColors.primary),
                                        ),
                                      ),
                                    ),
                                    const Gap(12),
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          // TODO: Implement Schedule a Meet
                                        },
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                            color: MyColors.primary,
                                            width: 1.5,
                                          ),
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: Text(
                                          "Schedule a Meet",
                                          style: MyTexts.bold16.copyWith(color: MyColors.primary),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(24),
                              ],
                            ),
                          ),
                          Obx(() {
                            if (controller.supportMyTickets.value.data?.tickets?.isEmpty ?? true) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 80),
                                child: Center(
                                  child: Text(
                                    "No tickets found !!",
                                    style: MyTexts.medium15.copyWith(color: Colors.black),
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
                                          style: MyTexts.regular14.copyWith(color: MyColors.grey),
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

                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: MyColors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: MyColors.black.withOpacity(0.04),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Row(
                                                children: [
                                                  const CircleAvatar(
                                                    radius: 20,
                                                    backgroundImage: AssetImage(Asset.profil),
                                                  ),
                                                  const Gap(12),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          (ticket.subject ?? "").capitalizeFirst ??
                                                              "-",
                                                          style: MyTexts.bold16.copyWith(
                                                            color: MyColors.black,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Ticket No. - #${ticket.ticketNumber ?? ''}",
                                                          style: MyTexts.regular12.copyWith(
                                                            color: MyColors.primary,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Gap(8),
                                                  const Icon(
                                                    Icons.share_outlined,
                                                    size: 20,
                                                    color: MyColors.grey,
                                                  ),
                                                  const Gap(12),
                                                  const Icon(
                                                    Icons.more_vert,
                                                    size: 20,
                                                    color: MyColors.grey,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(height: 1, color: MyColors.grayEA),
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.calendar_month_outlined,
                                                        size: 16,
                                                        color: MyColors.grey,
                                                      ),
                                                      const Gap(6),
                                                      Text(
                                                        _formatDate(ticket.createdAt),
                                                        style: MyTexts.regular14.copyWith(
                                                          color: MyColors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    ticket.priorityName ?? "",
                                                    style: MyTexts.bold14.copyWith(
                                                      color: MyColors.red,
                                                    ),
                                                  ),
                                                ],
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

  String _formatDate(DateTime? date) {
    if (date == null) return "-";
    // Format: 2nd Jan 2025
    final day = date.day;
    String suffix = 'th';
    if (day == 1 || day == 21 || day == 31) {
      suffix = 'st';
    } else if (day == 2 || day == 22)
      suffix = 'nd';
    else if (day == 3 || day == 23)
      suffix = 'rd';

    final months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return "$day$suffix ${months[date.month - 1]} ${date.year}";
  }
}
