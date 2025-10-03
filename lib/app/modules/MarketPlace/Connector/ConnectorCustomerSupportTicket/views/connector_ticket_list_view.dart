import 'package:construction_technect/app/core/utils/imports.dart';

/// Ticket Model
class ConnectorTicket {
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

  ConnectorTicket({
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

/// Ticket List View with static data
class ConnectorTicketListView extends StatelessWidget {
  ConnectorTicketListView({super.key});

  // Static list of tickets
  final List<ConnectorTicket> tickets = [
    ConnectorTicket(
      id: "T-001",
      status: "Open",
      priority: "Medium",
      title: "Steel bar specifications question",
      company: "John Construction Co.",
      email: "john@constructionco.com",
      description:
          "We ordered 50 bags of cement last week but haven't received them yet. When can we expect delivery?",
      createdDate: "2024-01-15",
      updatedDate: "2024-01-15",
      assignedTo: "Sarah Johnson",
    ),
    ConnectorTicket(
      id: "T-002",
      status: "In Progress",
      priority: "High",
      title: "Concrete mix issue",
      company: "BuildRight Ltd.",
      email: "support@buildright.com",
      description:
          "The concrete mix delivered does not meet the specified grade. Please advise on next steps.",
      createdDate: "2024-01-10",
      updatedDate: "2024-01-12",
      assignedTo: "Mark Lee",
    ),
    // Add more static tickets here if needed
  ];

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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index];

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
                      _getStatusTextColor(ticket.status),
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
                  ticket.title,
                  style: MyTexts.medium18.copyWith(
                    color: MyColors.fontBlack,
                    fontFamily: MyTexts.Roboto,
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
                      ticket.company,
                      style: MyTexts.regular14.copyWith(
                        color: MyColors.darkGray,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    const Icon(
                      Icons.email_outlined,
                      size: 16,
                      color: MyColors.darkGray,
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
                  style: MyTexts.regular14.copyWith(
                    color: MyColors.darkGray,
                    fontFamily: MyTexts.Roboto,
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Text(
                      "Created: ${ticket.createdDate}",
                      style: MyTexts.bold15.copyWith(
                        color: MyColors.darkGray,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "● Updated: ${ticket.updatedDate}",
                      style: MyTexts.bold15.copyWith(
                        color: MyColors.darkGray,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "● Assigned to: ${ticket.assignedTo}",
                  style: MyTexts.bold15.copyWith(
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
