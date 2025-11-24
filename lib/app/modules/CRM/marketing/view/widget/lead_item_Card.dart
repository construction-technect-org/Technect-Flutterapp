import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/marketing/model/lead_model.dart';
import 'package:intl/intl.dart';

class LeadItemCard extends StatelessWidget {
  final Leads lead;
  final MarketingController controller;

  const LeadItemCard({required this.lead, required this.controller});

  @override
  Widget build(BuildContext context) {
    final String status = lead.status ?? "";
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.LEAD_DETAIL, arguments: {"lead": lead});
      },
      child: Container(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: lead.image ?? "",
                width: 80,
                height: 97,
                fit: BoxFit.cover,
                placeholder: (c, s) =>
                    Container(color: Colors.grey.shade200, width: 80, height: 97),
                errorWidget: (c, s, e) => Container(
                  color: Colors.grey.shade200,
                  width: 80,
                  height: 97,
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
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${_formatTime(DateTime.parse(lead.createdAt ?? ""))}, ${_formatDate(DateTime.parse(lead.createdAt ?? ""))}',
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
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                if (status == "new")
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: MyColors.veryPaleBlue,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Lead",
                                          style: MyTexts.medium13.copyWith(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (status == "follow up")
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: MyColors.paleRed,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "FollowUp",
                                          style: MyTexts.medium13.copyWith(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                const Spacer(),
                                if (status == "new")
                                  GestureDetector(
                                    onTap: () {
                                      _openTeamBottomSheet();
                                    },
                                    child: Stack(
                                      alignment: AlignmentGeometry.center,
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
                                              style: MyTexts.medium12.copyWith(
                                                color: MyColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                if (status == "follow up")
                                  GestureDetector(
                                    onTapDown: (TapDownDetails details) {
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
                                              style: MyTexts.medium12.copyWith(
                                                color: MyColors.white,
                                              ),
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

  void openAssignPopup(BuildContext context, Offset position) {
    final TextEditingController searchCtrl = TextEditingController();

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      items: [
        PopupMenuItem(
          enabled: false, // so menu doesn't close on tap
          child: StatefulBuilder(
            builder: (context, setState) {
              final List<String> names = [
                "Akash",
                "Swathi",
                "Bhuvana",
                "Chanadan",
                "Darshan",
              ];

              // Filter based on search
              final filtered = names
                  .where((e) =>
                  e.toLowerCase().contains(searchCtrl.text.toLowerCase()))
                  .toList();

              return Container(
                width: 250, // control popup width
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SEARCH BOX
                    TextField(
                      controller: searchCtrl,
                      decoration: InputDecoration(
                        hintText: "Search",
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (v) => setState(() {}),
                    ),

                    const SizedBox(height: 10),

                    // LIST
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 250),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filtered.length,
                        itemBuilder: (_, i) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 18,
                                      backgroundImage:
                                      AssetImage("assets/user.png"),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(filtered[i],
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Call your assign method here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  child: const Text("Assign"),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }


  void _openTeamBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: GestureDetector(
          onTap: hideKeyboard,
          child: Column(
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _teamCard(
                        image: "https://picsum.photos/200/300",
                        name: "Name",
                        designation: "Designation",
                        ratio: "Conversation Ration",
                      ),
                      const SizedBox(height: 20),
                      _teamCard(
                        image: "https://picsum.photos/200/400",
                        name: "Name",
                        designation: "Designation",
                        ratio: "Conversation Ration",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _teamCard({
    required String image,
    required String name,
    required String designation,
    required String ratio,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F8FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MyColors.grayEA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(image, height: 70, width: 70, fit: BoxFit.cover),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name :", style: MyTexts.medium14),
                    const Gap(7),
                    Text("Designation :", style: MyTexts.medium14),
                    const Gap(7),
                    Text("Conversation Ration :", style: MyTexts.medium14),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF142243),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text("Assign", style: MyTexts.bold14.copyWith(color: Colors.white)),
                  ),
                  const Gap(8),
                  SvgPicture.asset(Asset.calendar),
                  const Gap(8),
                  SvgPicture.asset(Asset.chat),
                ],
              ),
            ],
          ),

          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.white),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("  Priority  ", style: MyTexts.medium14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green.shade700,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("High", style: MyTexts.medium13.copyWith(color: Colors.white)),
                      const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const CommonTextField(hintText: "Note:Typing....", maxLine: 3),
        ],
      ),
    );
  }

  void _openAddConversationBottomSheet(BuildContext context, Leads lead) {
    final TextEditingController lastController = TextEditingController();
    final TextEditingController nextController = TextEditingController();

    Get.bottomSheet(
      GestureDetector(
        onTap: hideKeyboard,
        child: Container(
          height: Get.height * 0.75,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
          ),
          child: SingleChildScrollView(
            child: Column(
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
                    const SizedBox(width: 8),
                    _userInfo(lead),
                  ],
                ),
                const SizedBox(height: 10),

                CommonTextField(
                  controller: lastController,
                  maxLine: 5,
                  hintText: "Typing.....",
                  bgColor: const Color(0xFFE8F1FF),
                ),

                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _whiteButton(
                        "Save",
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(child: _whiteButton("Cancel", onTap: Get.back)),
                  ],
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Next Conversation", style: MyTexts.bold15),
                    const SizedBox(width: 8),
                    _userInfo(lead),
                  ],
                ),
                const SizedBox(height: 10),

                CommonTextField(
                  controller: nextController,
                  maxLine: 5,
                  hintText: "Typing.....",
                  bgColor: const Color(0xFFFFF9BD),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: _whiteIconButton(
                        icon: Icons.access_time,
                        label: "Set Reminder",
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: _whiteButton("Save", onTap: () {})),
                    const SizedBox(width: 10),
                    Expanded(child: _whiteButton("Cancel", onTap: Get.back)),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
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
              _openAddConversationBottomSheet(context, lead);
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
              _openAddConversationBottomSheet(context, lead);
            });
          },
        ),
      ],
    );
  }

  Widget _userInfo(Leads lead) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundImage: (lead.image ?? "").isNotEmpty
                  ? NetworkImage(lead.image ?? "")
                  : const AssetImage(Asset.appLogo),
            ),
            const SizedBox(width: 8),
            Text(lead.connectorName ?? "", style: MyTexts.medium14),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          "${_formatTime(DateTime.parse(lead.createdAt ?? ""))}, ${_formatDate(DateTime.parse(lead.createdAt ?? ""))}}",
          style: MyTexts.medium12.copyWith(color: Colors.black54),
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

class ActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final double? hPadding;
  final VoidCallback onTap;

  const ActionButton({required this.icon, required this.label, required this.onTap, this.hPadding});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: hPadding ?? 6, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 12,
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
            const SizedBox(width: 8),
            Text(label, style: MyTexts.regular12),
          ],
        ),
      ),
    );
  }
}
