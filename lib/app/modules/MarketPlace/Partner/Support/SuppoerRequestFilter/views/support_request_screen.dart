import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/SuppoerRequestFilter/controller/support_request_controller.dart';

class SupportRequestScreen extends GetView<SupportRequestController> {
  const SupportRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: CommonAppBar(
            isCenter: false,
            title: const Text("Support Request"),
          ),
          body: Obx(() {
            if (controller.myTickets.isEmpty) {
              return Center(
                child: Text(
                  "No tickets found !!",
                  style: MyTexts.regular16.copyWith(color: Colors.black),
                ),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.myTickets.length,
                itemBuilder: (context, index) {
                  final ticket = controller.myTickets[index];
                  return Card(
                    color: MyColors.white,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: MyColors.americanSilver),
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
                                _getStatusBgColor(ticket.statusName ?? ""),
                                MyColors.white,
                                icon: _getStatusIcon(ticket.statusName ?? ""),
                              ),
                              SizedBox(width: 2.w),
                              _buildChip(
                                ticket.priorityName ?? "",
                                MyColors.white,
                                _getPriorityColor(ticket.priorityName ?? ""),
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
                            style: MyTexts.medium18.copyWith(
                              color: MyColors.fontBlack,
                              fontFamily: MyTexts.SpaceGrotesk,
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
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.8.h),
                          Text(
                            ticket.description ?? "",
                            style: MyTexts.regular14.copyWith(
                              color: MyColors.darkGray,
                              fontFamily: MyTexts.SpaceGrotesk,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Text(
                                "Created: ${ticket.createdAt?.toLocal().toString().split(' ')[0] ?? ""}",
                                style: MyTexts.bold15.copyWith(
                                  color: MyColors.darkGray,
                                  fontFamily: MyTexts.SpaceGrotesk,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "  ●  Updated: ${ticket.updatedAt?.toLocal().toString().split(' ')[0] ?? ""}",
                                style: MyTexts.bold15.copyWith(
                                  color: MyColors.darkGray,
                                  fontFamily: MyTexts.SpaceGrotesk,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "● Assigned to: ${ticket.assignedTo?.toString() ?? "Unassigned"}",
                            style: MyTexts.bold15.copyWith(
                              color: MyColors.darkGray,
                              fontFamily: MyTexts.SpaceGrotesk,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }

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
