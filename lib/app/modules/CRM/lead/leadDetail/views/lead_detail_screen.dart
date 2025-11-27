import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead/leadDetail/components/pipeline_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead/leadDetail/controller/lead_detail_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/marketing/model/lead_model.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/marketing/widget/priority_dropdown.dart';
import 'package:intl/intl.dart';

class LeadDetailScreen extends GetView<LeadDetailController> {
  const LeadDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Asset.categoryBg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  isCenter: false,
                  title: const Text("Lead Details"),
                  leading: GestureDetector(
                    onTap: Get.back,
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

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _topLeadCard(),
                          if (controller.lead.assignedToSelf == false &&
                              controller.lead.leadStage != "lead") ...[
                            const Gap(16),
                            _topTeamMemberCard(),
                          ],
                          const Gap(16),
                          Text("Status", style: MyTexts.medium16),
                          const Gap(9),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 11,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFB9B9B9),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    Get.find<MarketingController>()
                                        .activeFilter
                                        .value,
                                    style: MyTexts.medium15.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.keyboard_arrow_down_rounded),
                              ],
                            ),
                          ),
                          const Gap(20),
                          Text(
                            "Status Pipeline Representation",
                            style: MyTexts.medium16,
                          ),
                          const Gap(20),
                          PipelineView(
                            currentStage: getCurrentPipelineStage(
                              controller.lead,
                            ),
                            currentSubStage: getCurrentPipelineSubStage(
                              controller.lead,
                            ),
                          ),
                          const Gap(24),
                          _requirementSection(),
                          const Gap(24),
                          _conversationSection(),
                          const Gap(20),
                          buildNote(),
                          const Gap(20),
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

  Container buildNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFFFFCF5),
        border: Border.all(color: MyColors.grayDC),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notes : ",
            style: MyTexts.medium12.copyWith(color: const Color(0xFF737272)),
          ),
          const Gap(8),
          Text(
            "${controller.lead.notes}",
            style: const TextStyle(color: Colors.black),
          ),
          const Gap(8),
        ],
      ),
    );
  }

  Widget _topLeadCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.grayD6),
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFFFFFFF), Color(0xFFFFFBCC)],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: getImageView(
              finalUrl:
                  APIConstants.bucketUrl +
                  (controller.lead.connectorProfileImage ?? ""),
              height: 90,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Connector - ',
                              style: MyTexts.regular14.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: controller.lead.connectorName ?? '',
                              style: MyTexts.medium14.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(4),
                    Text(
                      '${_formatTime(DateTime.parse(controller.lead.createdAt ?? ""))}, ${_formatDate(DateTime.parse(controller.lead.createdAt ?? ""))}',
                      style: MyTexts.regular12.copyWith(color: MyColors.black),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
                const Gap(3),
                Text(
                  'Lead Id - ${controller.lead.leadId}',
                  style: MyTexts.regular13.copyWith(color: MyColors.black),
                ),
                const Gap(3),
                Text(
                  'Product Interested - ${controller.lead.productName}',
                  style: MyTexts.regular13.copyWith(color: MyColors.black),
                ),
                const Gap(3),
                Row(
                  children: [
                    SvgPicture.asset(Asset.location, height: 14, width: 14),
                    const SizedBox(width: 3),
                    Text(
                      '${controller.lead.radius} km away',
                      style: MyTexts.regular13.copyWith(color: MyColors.black),
                    ),
                  ],
                ),
                // const Gap(8),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8),
                //     color: MyColors.veryPaleBlue,
                //   ),
                //   child: Text(
                //     (controller.lead.status ?? "").capitalize.toString(),
                //     style: MyTexts.medium13.copyWith(color: Colors.black),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _topTeamMemberCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.grayD6),
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFFFFFFF), Color(0xFFE6EDFF)],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: getImageView(
                  finalUrl:
                      APIConstants.bucketUrl +
                      (controller.lead.assignedTeamMember?.profilePhoto ?? ""),
                  height: 90,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 3),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Team : ',
                                  style: MyTexts.regular14.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "${controller.lead.assignedTeamMember?.firstName ?? ""} ${controller.lead.assignedTeamMember?.lastName ?? ""}",
                                  style: MyTexts.medium14.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${_formatTime(DateTime.parse(controller.lead.createdAt ?? ""))}, ${_formatDate(DateTime.parse(controller.lead.createdAt ?? ""))}',
                          style: MyTexts.regular12.copyWith(
                            color: MyColors.black,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Team Id : ${controller.lead.assignedTeamMember?.id ?? ""}',
                                style: MyTexts.regular13.copyWith(
                                  color: MyColors.black,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Designation : ${controller.lead.assignedTeamMember?.roleTitle}',
                                style: MyTexts.regular13.copyWith(
                                  color: MyColors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Conversation Ration : 4/10 ',
                                style: MyTexts.regular13.copyWith(
                                  color: MyColors.black,
                                ),
                              ),
                              const SizedBox(height: 6),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(4),
          if ((controller.lead.teamMemberPriority ?? "").isNotEmpty)
            PriorityDropdown(
              isEnable: false,
              value: (controller.lead.teamMemberPriority ?? "").capitalizeFirst
                  .toString(),
              onChanged: (v) {},
            ),
        ],
      ),
    );
  }

  Widget _pipelineSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.grayEA),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _pipelineTile("45", "Leads", const Color(0xFFF9D0CB)),
          _pipelineTile("23", "Followup", const Color(0xFFFDEBC8)),
          _pipelineTile("12", "Prospect", const Color(0xFFC2D3FF)),
          _pipelineTile("8", "Qualified", const Color(0xFFC3E7C2)),
        ],
      ),
    );
  }

  Widget _pipelineTile(String count, String label, Color dotColor) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              height: 14,
              width: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotColor,
              ),
            ),
            Container(width: 2, height: 50, color: dotColor),
          ],
        ),
        const Gap(18),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: MyColors.grayD6),
            ),
            child: Row(
              children: [
                Text(count, style: MyTexts.bold20),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: dotColor.withValues(alpha: 0.4),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    label,
                    style: MyTexts.regular14.copyWith(color: MyColors.gray54),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _requirementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Requirement", style: MyTexts.medium16),
            // const Spacer(),
            // GestureDetector(child: SvgPicture.asset(Asset.edit)),
          ],
        ),
        const Gap(16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.grayD6),
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFF3F8FF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _reqText("Product : ${controller.lead.productName}"),
              _reqText("Quantity : ${controller.lead.quantity}"),
              _reqText("Location : ${controller.lead.siteLocation}"),
              _reqText(
                "Delivery Date : ${controller.lead.estimateDeliveryDate}",
              ),
              // const Gap(10),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              //   decoration: BoxDecoration(
              //     color: const Color(0xFFE7EAFF),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: const Row(
              //     children: [
              //       Icon(Icons.picture_as_pdf, color: Colors.red),
              //       Gap(16),
              //       Text("Adobe.pdf"),
              //       Spacer(),
              //       Icon(Icons.visibility, size: 18),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _reqText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text, style: MyTexts.medium15),
    );
  }

  Widget _conversationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Conversation", style: MyTexts.medium16),
        const Gap(14),
        _conversationCard("Last", controller.lead.lastConversation ?? "-"),
        const Gap(14),
        _conversationCard("Next", controller.lead.nextConversation ?? "-"),
      ],
    );
  }

  Widget _conversationCard(String title, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.grayE6),
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF3F8FF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: MyTexts.regular14),
          const Gap(6),
          Text(
            "Sent : $text",
            style: MyTexts.medium14.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }

  static String _formatTime(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')} AM';

  static String _formatDate(DateTime d) {
    return DateFormat('MMM d').format(d);
  }

  int getCurrentPipelineStage(Leads lead) {
    switch (lead.leadStage) {
      case "lead":
        return 0;
      case "follow_up":
        return 1;
      case "prospect":
        return 2;
      case "qualified":
        return 3;
      default:
        return 0;
    }
  }

  int getCurrentPipelineSubStage(Leads lead) {
    switch (lead.leadStage) {
      case "lead":
        if (lead.status == "new") return 0;
        return 0;
      case "follow_up":
        if (lead.status == "pending") return 0;
        if (lead.status == "fresh") return 1;
        if (lead.status == "missed") return 2;
        return 0;

      case "prospect":
        if (lead.status == "fresh") return 0;
        if (lead.status == "reached_out") return 1;
        if (lead.status == "on_hold") return 3;
        if (lead.status == "pending") return 2;
        return 0;

      case "qualified":
        if (lead.status == "pending") return 0;
        if (lead.status == "qualified") return 1;
        if (lead.status == "lost") return 2;
        return 0;

      default:
        return 0;
    }
  }
}
