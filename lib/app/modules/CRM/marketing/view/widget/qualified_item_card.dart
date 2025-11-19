import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/marketing/model/lead_model.dart';

class QualifiedItemCard extends StatelessWidget {
  final LeadModel lead;
  final MarketingController controller;
  const QualifiedItemCard({required this.lead, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.LEAD_DETAIL);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
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
                    width: 71,
                    height: 97,
                    fit: BoxFit.cover,
                    placeholder: (c, s) => Container(
                      color: Colors.grey.shade200,
                      width: 71,
                      height: 97,
                    ),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Connector - ${lead.connector}',
                              style: MyTexts.medium12.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${_formatTime(lead.dateTime)}, ${_formatDate(lead.dateTime)}',
                            style: MyTexts.medium12.copyWith(
                              color: MyColors.gray54,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),

                      const SizedBox(height: 3),
                      Text(
                        'Lead Id - ${lead.id}',
                        style: MyTexts.medium12.copyWith(
                          color: MyColors.gray54,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Product Interested - ${lead.product}',
                        style: MyTexts.medium12.copyWith(
                          color: MyColors.gray54,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Lead Score (24)',
                        style: MyTexts.medium12.copyWith(
                          color: MyColors.gray54,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14),
                          const SizedBox(width: 3),
                          Text(
                            '${lead.distanceKm} km away',
                            style: MyTexts.medium12.copyWith(
                              color: MyColors.gray54,
                            ),
                          ),
                        ],
                      ),

                      // const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'Qualification Reason',
                            style: MyTexts.medium12.copyWith(
                              color: MyColors.gray54,
                            ),
                          ),
                          const SizedBox(width: 3),

                          Container(
                            decoration: BoxDecoration(
                              color: MyColors.greenBtn,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Verified',
                                  style: MyTexts.medium12.copyWith(
                                    color: Colors.white,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                const Icon(
                                  Icons.done,
                                  size: 12,
                                  color: Colors.white,
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

            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ActionButton(
                  icon: Icons.person_add_alt_1_outlined,
                  label: 'Assign To',
                  onTap: () => controller.assignTo(lead.id, 'User A'),
                ),
                _ActionButton(
                  icon: Icons.schedule_outlined,
                  label: 'Set a Reminder',
                  onTap: () => controller.setReminder(
                    lead.id,
                    DateTime.now().add(const Duration(days: 1)),
                  ),
                ),
                _ActionButton(
                  icon: Icons.chat_bubble_outline,
                  label: 'Chat Now',
                  onTap: () => controller.chatNow(lead.id),
                ),
                _ActionButton(
                  icon: Icons.done,
                  label: ' Move to Final Stage',
                  onTap: () => controller.chatNow(lead.id),
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
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

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
            Icon(icon, size: 12),
            const Gap(5),
            Text(label, style: const TextStyle(fontSize: 8)),
          ],
        ),
      ),
    );
  }
}
