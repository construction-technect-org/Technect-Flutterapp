import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/marketing/model/lead_model.dart';

class LeadItemCard extends StatelessWidget {
  final LeadModel lead;
  final MarketingController controller;

  const LeadItemCard({required this.lead, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.LEAD_DETAIL);
      },
      child: Container(
        decoration: BoxDecoration(
          // color: const Color(0xFFEFF6FF),
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: lead.avatarUrl,
                    width: 80,
                    height: 97,
                    fit: BoxFit.cover,
                    placeholder: (c, s) =>
                        Container(color: Colors.grey.shade200, width: 71, height: 97),
                    errorWidget: (c, s, e) => Container(
                      color: Colors.grey.shade200,
                      width: 71,
                      height: 97,
                      child: const Icon(Icons.person),
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
                            child: Text(
                              'Connector - ${lead.connector}',
                              style: MyTexts.medium12.copyWith(fontWeight: FontWeight.w700),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${_formatTime(lead.dateTime)}, ${_formatDate(lead.dateTime)}',
                            style: MyTexts.medium12.copyWith(color: MyColors.black),
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
                                  'Lead Id - ${lead.id}',
                                  style: MyTexts.medium12.copyWith(color: MyColors.black),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Product Interested - ${lead.product}',
                                  style: MyTexts.medium12.copyWith(color: MyColors.black),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    SvgPicture.asset(Asset.location, height: 14, width: 14),
                                    const SizedBox(width: 3),
                                    Text(
                                      '${lead.distanceKm} km away',
                                      style: MyTexts.medium12.copyWith(color: MyColors.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: MyColors.primary,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Lead",
                                        style: MyTexts.medium13.copyWith(color: Colors.white),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(20),
                          SvgPicture.asset(Asset.message),
                          const Gap(20),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ActionButton(
                  icon: Asset.userPlus,
                  label: 'Assign To',
                  onTap: () {
                    _openTeamBottomSheet();
                  },
                ),
                _ActionButton(
                  icon: Asset.chat,
                  label: 'Add Conversation',
                  onTap: () => controller.chatNow(lead.id),
                ),
                _ActionButton(
                  icon: Asset.clock,
                  label: 'Set a Reminder',
                  onTap: () =>
                      controller.setReminder(lead.id, DateTime.now().add(const Duration(days: 1))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _formatTime(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')} AM';

  static String _formatDate(DateTime d) => '${d.month}, ${d.day}';

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
}

class _ActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon, height: 12),
            const SizedBox(width: 8),
            Text(label, style:MyTexts.regular12),
          ],
        ),
      ),
    );
  }
}
