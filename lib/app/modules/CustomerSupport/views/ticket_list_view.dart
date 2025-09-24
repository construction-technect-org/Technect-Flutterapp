import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CustomerSupport/controller/customer_support_controller.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportMyTicketsModel.dart';

/// Ticket Model
class Ticket {
  final String id;
  final String status;
  final String priority;
  final String title;
  final String company;
  final String email;
  final String description;
  final String createdDate;
  final String updatedDate;
  final String assignedTo;

  Ticket({
    required this.id,
    required this.status,
    required this.priority,
    required this.title,
    required this.company,
    required this.email,
    required this.description,
    required this.createdDate,
    required this.updatedDate,
    required this.assignedTo,
  });
}

/// Ticket List
class TicketListView extends StatelessWidget {
  final CustomerSupportController controller =
      Get.find<CustomerSupportController>();

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

  List<Ticket> convertSupportTicketsToTickets(
    List<SupportMyTickets> myTickets,
  ) {
    return myTickets.map((t) {
      return Ticket(
        id: t.ticketNumber,
        status: t.statusName,
        priority: t.priorityName,
        title: t.subject,
        company: t.userMobile, // or merchant name if available
        email: t.categoryName, // or user email if available
        description: t.description,
        createdDate: t.createdAt.toLocal().toString().split(' ')[0],
        updatedDate: t.updatedAt.toLocal().toString().split(' ')[0],
        assignedTo: t.assignedTo ?? "Unassigned",
      );
    }).toList();
  }

  TicketListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingMyTickets.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final tickets = convertSupportTicketsToTickets(controller.myTickets);

      // 🔍 Apply search filter here
      final filteredTickets = tickets.where((t) {
        final query = controller.searchQuery.value.toLowerCase();
        return t.title.toLowerCase().contains(query);
      }).toList();

      if (filteredTickets.isEmpty) {
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
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: filteredTickets.length,
        itemBuilder: (context, index) {
          final ticket = filteredTickets[index];

          // --- your existing Card code ---
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
                        ticket.id,
                        MyColors.white,
                        MyColors.black,
                        borderColor: MyColors.americanSilver,
                      ),
                      SizedBox(width: 2.w),
                      _buildChip(
                        ticket.status,
                        _getStatusBgColor(ticket.status),
                        MyColors.white,
                        icon: _getStatusIcon(ticket.status),
                      ),
                      SizedBox(width: 2.w),
                      _buildChip(
                        ticket.priority,
                        MyColors.white,
                        _getPriorityColor(ticket.priority),
                        borderColor: _getPriorityColor(ticket.priority),
                        icon: _getPriorityIcon(ticket.priority),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    ticket.title.capitalizeFirst??"-",
                    style: MyTexts.medium18.copyWith(color: MyColors.fontBlack,fontFamily: MyTexts.Roboto),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 18,
                          color: MyColors.gray6B
                      ),
                      SizedBox(width: 0.4.w),
                      Text(
                        ticket.company,
                        style: MyTexts.regular14.copyWith(
                          color: MyColors.gray6B
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
                        ticket.email,
                        style: MyTexts.regular14.copyWith(
                          color: MyColors.darkGray,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.8.h),
                  Text(
                    ticket.description,
                    style: MyTexts.regular14.copyWith(color: MyColors.darkGray,fontFamily: MyTexts.Roboto),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Text(
                        "Created: ${ticket.createdDate}",
                        style: MyTexts.bold15.copyWith(color: MyColors.darkGray,fontFamily: MyTexts.Roboto),
                      ),
                      const Spacer(),
                      Text(
                        "  ●  Updated: ${ticket.updatedDate}",
                        style: MyTexts.bold15.copyWith(color: MyColors.darkGray,fontFamily: MyTexts.Roboto),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "● Assigned to: ${ticket.assignedTo}",
                    style: MyTexts.bold15.copyWith(color: MyColors.darkGray,fontFamily: MyTexts.Roboto),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
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



