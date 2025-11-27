import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/marketing/model/lead_model.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/priority_dropdown.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetTeamListModel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class LeadItemCard extends StatelessWidget {
  final Leads lead;
  final MarketingController controller;

  LeadItemCard({required this.lead, required this.controller});

  @override
  Widget build(BuildContext context) {
    final String leadStatus = lead.leadStage ?? "";
    final String status = lead.status ?? "";
    final bool isFollowUpSwipable = leadStatus == "follow_up" && status == "pending";
    final bool isQualifiedSwipable = status == "pending" && leadStatus == "qualified" && controller.activeFilter.value == "Qualified";
    final bool isProspectSwipable =
        leadStatus == "prospect" &&
        (status == "fresh" || status == "reached_out") &&
        controller.activeFilter.value == "Prospect";

    return isQualifiedSwipable
        ? Slidable(
            key: UniqueKey(),
            startActionPane: ActionPane(
              motion: const BehindMotion(),
              extentRatio: 0.25,
              dragDismissible: false,
              children: [
                SlidableAction(
                  backgroundColor: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  onPressed: (_) async {
                    await controller.updateStatusLeadToFollowUp(
                      leadID: lead.id.toString(),
                      status: "lost",
                    );
                  },
                  label: "Lost",
                ),
              ],
            ),

            endActionPane: ActionPane(
              motion: const BehindMotion(),
              extentRatio: 0.25,
              dragDismissible: false,
              children: [
                SlidableAction(
                  backgroundColor: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                  onPressed: (_) async {
                    await controller.updateStatusLeadToFollowUp(
                      leadID: lead.id.toString(),
                      status: "qualified",
                    );
                  },
                  label: "Qualified",
                ),
              ],
            ),

            child: _card(context, status, leadStatus),
          )
        : isProspectSwipable
        ? Slidable(
            key: UniqueKey(),
            startActionPane: ActionPane(
              motion: const BehindMotion(),
              extentRatio: 0.25,
              dragDismissible: false,
              children: [
                SlidableAction(
                  backgroundColor: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  onPressed: (_) async {
                    await controller.updateStatusLeadToFollowUp(
                      leadID: lead.id.toString(),
                      status: "on_hold",
                    );
                  },
                  label: "On Hold",
                ),
              ],
            ),

            endActionPane: ActionPane(
              motion: const BehindMotion(),
              extentRatio: 0.25,
              dragDismissible: false,
              children: [
                SlidableAction(
                  backgroundColor: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                  onPressed: (_) async {
                    await controller.updateStatusLeadToFollowUp(
                      leadID: lead.id.toString(),
                      status: status == "fresh" ? "reached_out" : "converted",
                    );
                  },
                  label: status == "fresh" ? "Reached Out" : "Converted",
                ),
              ],
            ),

            child: _card(context, status, leadStatus),
          )
        : isFollowUpSwipable
        ? Slidable(
            key: UniqueKey(),

            startActionPane: ActionPane(
              motion: const BehindMotion(),
              extentRatio: 0.25,
              dragDismissible: false,
              children: [
                SlidableAction(
                  backgroundColor: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  onPressed: (_) async {
                    await controller.updateStatusLeadToFollowUp(
                      leadID: lead.id.toString(),
                      status: "missed",
                    );
                  },
                  label: "Missed",
                ),
              ],
            ),

            endActionPane: ActionPane(
              motion: const BehindMotion(),
              extentRatio: 0.25,
              dragDismissible: false,
              children: [
                SlidableAction(
                  backgroundColor: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                  onPressed: (_) async {
                    await controller.updateStatusLeadToFollowUp(
                      leadID: lead.id.toString(),
                      status: "completed",
                    );
                  },
                  label: "Completed",
                ),
              ],
            ),

            child: _card(context, status, leadStatus),
          )
        : _card(context, status, leadStatus);
  }

  Widget _card(BuildContext context, String status, String leadStatus) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.LEAD_DETAIL, arguments: {"lead": lead});
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFFFFBCC)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MyColors.grayD6),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: getImageView(
                finalUrl: APIConstants.bucketUrl + (lead.image ?? ""),
                width: 80,
                height: 97,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 3),
                            RichText(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Connector - ',
                                    style: MyTexts.regular14.copyWith(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: lead.connectorName ?? '',
                                    style: MyTexts.medium14.copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Lead Id - ${lead.leadId}',
                              style: MyTexts.regular13.copyWith(color: MyColors.black),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Product Interested - ${lead.productName}',
                              style: MyTexts.regular13.copyWith(color: MyColors.black),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                SvgPicture.asset(Asset.location, height: 14, width: 14),
                                const SizedBox(width: 3),
                                Text(
                                  '${lead.radius} km away',
                                  style: MyTexts.regular13.copyWith(color: MyColors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if(lead.assignedToSelf==false)
                          if (leadStatus != "lead") ...[
                            CircleAvatar(
                              radius: 14,
                              backgroundImage:
                                  (lead.assignedTeamMember?.profilePhoto ?? "").isNotEmpty
                                  ? NetworkImage(
                                      APIConstants.bucketUrl +
                                          (lead.assignedTeamMember?.profilePhoto ?? ""),
                                    )
                                  : const AssetImage(Asset.appLogo),
                            ),
                            const Gap(3),
                            Text(
                              "${lead.assignedTeamMember?.firstName ?? ""} ${lead.assignedTeamMember?.lastName ?? ""}",
                              style: MyTexts.medium13,
                            ),
                          ] else ...[
                            const Gap(3),
                          ],

                          Text(
                            '${_formatTime(DateTime.parse(lead.createdAt ?? ""))}, ${_formatDate(DateTime.parse(lead.createdAt ?? ""))}',
                            style: MyTexts.regular12.copyWith(color: MyColors.black),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(6),
                  if (leadStatus == "lead") ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: MyColors.veryPaleBlue,
                          ),
                          child: Text(
                            "Lead",
                            style: MyTexts.medium13.copyWith(color: Colors.black),
                          ),
                        ),
                        GestureDetector(
                          onTapDown: (details) {
                            openAssignPopupMenu(
                              context,
                              details.globalPosition,
                              Get.find<CommonController>().teamList,
                              () {},
                            );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(Asset.explore, width: 65),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Asset.userPlus,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                    height: 12,
                                  ),
                                  const Gap(4),
                                  Text(
                                    "Assign",
                                    style: MyTexts.medium12.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ] else if (controller.activeFilter.value == "Follow Up") ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: MyColors.paleRed,
                          ),
                          child: Text(
                            "FollowUp",
                            style: MyTexts.medium13.copyWith(color: Colors.black),
                          ),
                        ),
                        GestureDetector(
                          onTapDown: (details) {
                            _openConversationMenu(context, details.globalPosition, lead);
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(Asset.explore, width: 65),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Asset.userPlus,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                    height: 12,
                                  ),
                                  const Gap(4),
                                  Text(
                                    "Contact",
                                    style: MyTexts.medium12.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ] else if (controller.activeFilter.value == "Prospect") ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFB3FDCE),
                          ),
                          child: Text(
                            "Prospect",
                            style: MyTexts.medium13.copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ] else if (controller.activeFilter.value == "Qualified") ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: status == "pending"
                                ? MyColors.red
                                : status == "lost"
                                ? MyColors.red
                                : MyColors.green,
                          ),
                          child: Text(
                            status == "pending" ? "Unqualified" : status.capitalizeFirst.toString(),
                            style: MyTexts.medium13.copyWith(color: Colors.white),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(Asset.chat, height: 18),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatTime(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')} AM';

  static String _formatDate(DateTime d) {
    return DateFormat('MMM d').format(d);
  }

  void openAssignPopupMenu(
    BuildContext context,
    Offset position,
    List<TeamListData> teamList,
    VoidCallback onAssignToMe,
  ) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, 0, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      items: [
        PopupMenuItem(
          enabled: false,
          child: Container(
            width: 280,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (teamList.isEmpty)
                  GestureDetector(
                    onTap: onAssignToMe,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "You don't have any team members",
                            style: MyTexts.medium14.copyWith(color: MyColors.gray54),
                          ),
                          const Gap(10),
                          RoundedButton(
                            buttonName: "Assign to me only",
                            height: 34,
                            width: 120,
                            style: MyTexts.medium14.copyWith(color: Colors.white),
                            onTap: () {
                              Get.back();
                              Get.toNamed(
                                Routes.SetReminder,
                                arguments: {
                                  "leadID": lead.id ?? "",
                                  "assignTo": 0,
                                  "assignToSelf": true,
                                  "priority": "",
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                if (teamList.isNotEmpty)
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: teamList.length,
                      itemBuilder: (_, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: _assignItemCard(context, teamList[i]),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _assignItemCard(BuildContext context, TeamListData item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.profilePhotoUrl ?? "",
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Image.asset(Asset.appLogo, width: 32, height: 32),
              ),
            ),
            const SizedBox(width: 8),
            Text("${item.firstName ?? ""} ${item.lastName ?? ""}", style: MyTexts.medium13),
            const Gap(10),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            _openTeamBottomSheet(context, item);
          },
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              Image.asset(Asset.explore, width: 65),
              Row(
                children: [
                  SvgPicture.asset(
                    Asset.userPlus,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    height: 12,
                  ),
                  const Gap(4),
                  Text("Assign", style: MyTexts.medium12.copyWith(color: MyColors.white)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  RxBool isDropdownOpen = false.obs;

  void _openTeamBottomSheet(BuildContext context, TeamListData item) {
    Get.bottomSheet(
      Container(
        height: isDropdownOpen.value == true ? 270 : 230,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: GestureDetector(
          onTap: hideKeyboard,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Gap(10),
                  Text("Team", style: MyTexts.bold20),
                  const Spacer(),
                  GestureDetector(
                    onTap: Get.back,
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: MyColors.grayF7,
                      child: Icon(Icons.close, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: AlignmentGeometry.topCenter,
                    end: AlignmentGeometry.bottomCenter,
                    colors: [Colors.white, Color(0xFFFFFBCC)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: MyColors.grayD6),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(34),
                          child: CachedNetworkImage(
                            imageUrl: APIConstants.bucketUrl + (item.profilePhotoUrl ?? ""),
                            width: 65,
                            height: 65,
                            fit: BoxFit.cover,
                            placeholder: (c, s) =>
                                Container(color: Colors.grey.shade200, width: 65, height: 65),
                            errorWidget: (c, s, e) => Container(
                              color: Colors.grey.shade200,
                              width: 65,
                              height: 65,
                              child: Image.asset(Asset.appLogo),
                            ),
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
                                            style: MyTexts.regular14.copyWith(color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: "${item.firstName ?? ""} ${item.lastName ?? ""}",
                                            style: MyTexts.medium14.copyWith(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${_formatTime(DateTime.parse(item.createdAt ?? ""))}, ${_formatDate(DateTime.parse(item.createdAt ?? ""))}',
                                    style: MyTexts.regular12.copyWith(color: MyColors.black),
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
                                          'Team Id : ${item.id ?? ""}',
                                          style: MyTexts.regular13.copyWith(color: MyColors.black),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          'Designation : ${item.roleTitle}',
                                          style: MyTexts.regular13.copyWith(color: MyColors.black),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Conversation Ration : 4/10 ',
                                          style: MyTexts.regular13.copyWith(color: MyColors.black),
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
                    Row(
                      children: [
                        Obx(() {
                          return GestureDetector(
                            onTap: () => isDropdownOpen.value = true,
                            child: PriorityDropdown(
                              value: controller.selectedPriority.value,
                              onChanged: (v) {
                                controller.selectedPriority.value = v;
                                isDropdownOpen.value = false;
                              },
                            ),
                          );
                        }),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.toNamed(
                              Routes.SetReminder,
                              arguments: {
                                "leadID": lead.id ?? "",
                                "assignTo": item.id ?? "",
                                "priority": controller.selectedPriority.value,
                                "assignToSelf": false,
                              },
                            );
                          },
                          child: Stack(
                            alignment: AlignmentGeometry.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(12),
                                child: Image.asset(
                                  Asset.explore,
                                  width: 98,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Asset.calendar,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                    height: 12,
                                  ),
                                  const Gap(4),
                                  Text(
                                    "Set Reminder",
                                    style: MyTexts.medium12.copyWith(color: MyColors.white),
                                  ),
                                ],
                              ),
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
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _openConversationMenu(BuildContext context, Offset position, Leads lead) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx + 1, position.dy + 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Last Conversation", style: MyTexts.medium15),
              SvgPicture.asset(Asset.chat),
            ],
          ),
          onTap: () {
            Future.delayed(Duration.zero, () {
              _openLastConversationSheet(lead);
            });
          },
        ),
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Next Conversation", style: MyTexts.medium15),
              SvgPicture.asset(Asset.chat),
            ],
          ),
          onTap: () {
            Future.delayed(Duration.zero, () {
              _openNextConversationSheet(lead);
            });
          },
        ),
      ],
    );
  }

  final lastFormKey = GlobalKey<FormState>();

  void _openLastConversationSheet(Leads lead) {
    final TextEditingController lastController = TextEditingController(
      text: lead.lastConversation ?? "",
    );

    Get.bottomSheet(
      GestureDetector(
        onTap: hideKeyboard,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
          ),
          child: Form(
            key: lastFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text("Add Conversation", style: MyTexts.medium18),
                    const Spacer(),
                    GestureDetector(
                      onTap: Get.back,
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: MyColors.grayF7,
                        child: Icon(Icons.close, color: Colors.black),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Last Conversation", style: MyTexts.bold15),
                    _userInfo(lead),
                  ],
                ),

                const SizedBox(height: 10),

                CommonTextField(
                  controller: lastController,
                  maxLine: 5,
                  hintText: "Typing.....",
                  bgColor: const Color(0xFFE8F1FF),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Please enter last conversation";
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        buttonName: "Cancel",
                        onTap: () {
                          Get.back();
                        },
                        height: 40,
                        borderColor: MyColors.primary,
                        color: Colors.transparent,
                        fontColor: MyColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RoundedButton(
                        buttonName: "Save",
                        onTap: () {
                          if (lastFormKey.currentState!.validate()) {
                            controller.updateStatusLeadToFollowUp(
                              leadID: lead.id.toString(),
                              lastConversation: lastController.text,
                              onSuccess: () {
                                Get.back();
                                SnackBars.successSnackBar(
                                  content: 'Last conversation added successfully',
                                );
                              },
                            );
                          }
                        },
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  final GlobalKey<FormState> nextFormKey = GlobalKey<FormState>();

  void _openNextConversationSheet(Leads lead) {
    final TextEditingController nextController = TextEditingController(
      text: lead.nextConversation ?? "",
    );
    Get.bottomSheet(
      GestureDetector(
        onTap: hideKeyboard,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
          ),
          child: Form(
            key: nextFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text("Add Conversation", style: MyTexts.medium18),
                    const Spacer(),
                    GestureDetector(
                      onTap: Get.back,
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: MyColors.grayF7,
                        child: Icon(Icons.close, color: Colors.black),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Next Conversation", style: MyTexts.bold15),
                    _userInfo(lead),
                  ],
                ),

                const SizedBox(height: 10),

                CommonTextField(
                  controller: nextController,
                  maxLine: 5,
                  hintText: "Typing.....",
                  bgColor: const Color(0xFFFFF9BD),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Please enter next conversation";
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        buttonName: "Cancel",
                        onTap: () {
                          Get.back();
                        },
                        height: 40,
                        borderColor: MyColors.primary,
                        color: Colors.transparent,
                        fontColor: MyColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RoundedButton(
                        buttonName: "Save",
                        onTap: () {
                          if (nextFormKey.currentState!.validate()) {
                            controller.updateStatusLeadToFollowUp(
                              leadID: lead.id.toString(),
                              nextConversation: nextController.text,
                              onSuccess: () {
                                Get.back();
                                SnackBars.successSnackBar(
                                  content: 'Next conversation added successfully',
                                );
                              },
                            );
                          }
                        },
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _userInfo(Leads lead) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage: (lead.assignedTeamMember?.profilePhoto ?? "").isNotEmpty
              ? NetworkImage(APIConstants.bucketUrl + (lead.assignedTeamMember?.profilePhoto ?? ""))
              : const AssetImage(Asset.appLogo),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${lead.assignedTeamMember?.firstName ?? ""} ${lead.assignedTeamMember?.lastName ?? ""}",
              style: MyTexts.medium14,
            ),
            Text(lead.assignedTeamMember?.roleTitle ?? "", style: MyTexts.regular13),
          ],
        ),
      ],
    );
  }

  Widget _whiteButton(String label, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(label, style: MyTexts.medium14),
      ),
    );
  }

  Widget _whiteIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 8),
            Text(label, style: MyTexts.medium14),
          ],
        ),
      ),
    );
  }
}
