import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/more/analysis/controller/analysis_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Report/views/report_view.dart';

class ReportChart extends GetView<AnalysisController> {
  const ReportChart({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(myPref.role.val);
    }
    return Obx(() {
      if (!controller.isReport.value) {
        final analysis = controller.analysisModel.value;
        return myPref.role.val == "partner"
            ? Column(
                children: [
                  if (analysis.productAnalytics != null)
                    ReportGraph(
                      title: "Products Analysis",
                      labels: analysis.productAnalytics!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.productAnalytics!.monthlyBreakdown!
                            .map((e) => e.productsAdded ?? 0)
                            .toList(),
                        analysis.productAnalytics!.monthlyBreakdown!
                            .map((e) => e.activeProducts ?? 0)
                            .toList(),
                        analysis.productAnalytics!.monthlyBreakdown!
                            .map((e) => e.rejectedProducts ?? 0)
                            .toList(),
                      ],
                      colors: const [MyColors.primary, MyColors.green, Colors.red],
                      legends: const ["Products Added", "Active Products", "Rejected Products"],
                    ),
                  const Gap(10),
                  if (analysis.serviceAnalytics != null)
                    ReportGraph(
                      title: "Services Analysis",
                      labels: analysis.serviceAnalytics!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.serviceAnalytics!.monthlyBreakdown!
                            .map((e) => e.servicesAdded ?? 0)
                            .toList(),
                        analysis.serviceAnalytics!.monthlyBreakdown!
                            .map((e) => e.activeServices ?? 0)
                            .toList(),
                        analysis.serviceAnalytics!.monthlyBreakdown!
                            .map((e) => e.rejectedServices ?? 0)
                            .toList(),
                      ],
                      colors: const [MyColors.primary, MyColors.green, Colors.red],
                      legends: const ["Services Added", "Active Services", "Rejected Services"],
                    ),
                  const Gap(10),
                  if (analysis.teamAnalytics != null)
                    ReportGraph(
                      title: "Team Analysis",
                      labels: analysis.teamAnalytics!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.teamAnalytics!.monthlyBreakdown!
                            .map((e) => e.teamMembersAdded ?? 0)
                            .toList(),
                        analysis.teamAnalytics!.monthlyBreakdown!
                            .map((e) => e.availableTeamMembers ?? 0)
                            .toList(),
                      ],
                      colors: const [MyColors.primary, MyColors.green],
                      legends: const ["Added Member", "Active Member"],
                    ),
                  const Gap(10),

                  if (analysis.roleAnalytics != null)
                    ReportGraph(
                      title: "Role Analysis",
                      labels: analysis.roleAnalytics!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.roleAnalytics!.monthlyBreakdown!
                            .map((e) => e.rolesCreated ?? 0)
                            .toList(),
                        analysis.roleAnalytics!.monthlyBreakdown!
                            .map((e) => e.activeRoles ?? 0)
                            .toList(),
                      ],
                      colors: const [MyColors.primary, MyColors.green],
                      legends: const ["Role Created", "Active Role"],
                    ),
                  const Gap(10),
                  if (analysis.supportTicketAnalytics != null)
                    ReportGraph(
                      title: "Support Ticket Analysis",
                      labels: analysis.supportTicketAnalytics!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.supportTicketAnalytics!.monthlyBreakdown!
                            .map((e) => e.openTickets ?? 0)
                            .toList(),
                        analysis.supportTicketAnalytics!.monthlyBreakdown!
                            .map((e) => e.closedTickets ?? 0)
                            .toList(),
                        analysis.supportTicketAnalytics!.monthlyBreakdown!
                            .map((e) => e.resolvedTickets ?? 0)
                            .toList(),
                      ],
                      colors: const [Colors.orange, Colors.red, MyColors.green],
                      legends: const ["Open Tickets", "Closed Tickets", "Resoled Tickets"],
                    ),
                  const Gap(20),
                ],
              )
            : Column(
                children: [
                  if (analysis.wishlist != null)
                    ReportGraph(
                      title: "WishList Analysis",
                      labels: analysis.wishlist!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.wishlist!.monthlyBreakdown!.map((e) => e.itemsAdded ?? 0).toList(),
                      ],
                      colors: const [MyColors.primary, MyColors.green, Colors.red],
                      legends: const ["Item Added"],
                    ),
                  const Gap(10),
                  if (analysis.productConnections != null)
                    ReportGraph(
                      title: "Product Connections Analysis",
                      labels: analysis.productConnections!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.productConnections!.monthlyBreakdown!
                            .map((e) => e.connectionsCreated ?? 0)
                            .toList(),
                      ],
                      colors: const [MyColors.primary],
                      legends: const ["Product Connections Created"],
                    ),
                  const Gap(10),
                  if (analysis.serviceConnections != null)
                    ReportGraph(
                      title: "Service Connections Analysis",
                      labels: analysis.serviceConnections!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.serviceConnections!.monthlyBreakdown!
                            .map((e) => e.serviceConnectionsCreated ?? 0)
                            .toList(),
                      ],
                      colors: const [MyColors.green],
                      legends: const ["Service Connections Created"],
                    ),
                  const Gap(10),
                  if (analysis.serviceRequirements != null)
                    ReportGraph(
                      title: "Service Requirements Analysis",
                      labels: analysis.serviceRequirements!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.serviceRequirements!.monthlyBreakdown!
                            .map((e) => e.requirementsCreated ?? 0)
                            .toList(),
                        analysis.serviceRequirements!.monthlyBreakdown!
                            .map((e) => e.pendingRequirements ?? 0)
                            .toList(),
                        analysis.serviceRequirements!.monthlyBreakdown!
                            .map((e) => e.fulfilledRequirements ?? 0)
                            .toList(),
                        analysis.serviceRequirements!.monthlyBreakdown!
                            .map((e) => e.cancelledRequirements ?? 0)
                            .toList(),
                      ],
                      colors: const [MyColors.primary, Colors.orange, MyColors.green, Colors.red],
                      legends: const [
                        "Requirements Created",
                        "Pending Requirements",
                        "Fulfilled Requirements",
                        "Cancelled Requirements",
                      ],
                    ),
                  const Gap(10),
                  if (analysis.productRequirements != null)
                    ReportGraph(
                      title: "Product Requirements Analysis",
                      labels: analysis.productRequirements!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.productRequirements!.monthlyBreakdown!
                            .map((e) => e.requirementsCreated ?? 0)
                            .toList(),
                        analysis.productRequirements!.monthlyBreakdown!
                            .map((e) => e.pendingRequirements ?? 0)
                            .toList(),
                        analysis.productRequirements!.monthlyBreakdown!
                            .map((e) => e.fulfilledRequirements ?? 0)
                            .toList(),
                        analysis.productRequirements!.monthlyBreakdown!
                            .map((e) => e.cancelledRequirements ?? 0)
                            .toList(),
                      ],
                      colors: const [MyColors.primary, Colors.orange, MyColors.green, Colors.red],
                      legends: const [
                        "Requirements Created",
                        "Pending Requirements",
                        "Fulfilled Requirements",
                        "Cancelled Requirements",
                      ],
                    ),
                  const Gap(10),
                  if (analysis.connectorSupportTickets != null)
                    ReportGraph(
                      title: "Support Ticket Analysis",
                      labels: analysis.connectorSupportTickets!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.connectorSupportTickets!.monthlyBreakdown!
                            .map((e) => e.openTickets ?? 0)
                            .toList(),
                        analysis.connectorSupportTickets!.monthlyBreakdown!
                            .map((e) => e.closedTickets ?? 0)
                            .toList(),
                        analysis.connectorSupportTickets!.monthlyBreakdown!
                            .map((e) => e.resolvedTickets ?? 0)
                            .toList(),
                      ],
                      colors: const [Colors.orange, Colors.red, MyColors.green],
                      legends: const ["Open Tickets", "Closed Tickets", "Resolved Tickets"],
                    ),

                  const Gap(20),
                ],
              );
      }
      return const SizedBox();
    });
  }
}
