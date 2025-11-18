import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/marketing/model/lead_model.dart';

class FollowupItemCard extends StatelessWidget {
  final LeadModel lead;
  final MarketingController controller;
  const FollowupItemCard({required this.lead, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  width: 88,
                  height: 88,
                  fit: BoxFit.cover,
                  placeholder: (c, s) => Container(
                    color: Colors.grey.shade200,
                    width: 88,
                    height: 88,
                  ),
                  errorWidget: (c, s, e) => Container(
                    color: Colors.grey.shade200,
                    width: 88,
                    height: 88,
                    child: const Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(width: 12),
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
                      style: MyTexts.medium12.copyWith(color: MyColors.gray54),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Product Interested - ${lead.product}',
                      style: MyTexts.medium12.copyWith(color: MyColors.gray54),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Next Follow Up - N0V 14 , 3:00 PM',
                      style: MyTexts.medium12.copyWith(color: MyColors.gray54),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Status - ${lead.status.name.capitalizeFirst}',
                          style: MyTexts.medium12.copyWith(
                            color: colorMap[lead.status],
                          ),
                        ),
                        if (lead.status == Status.completed)
                          Icon(
                            Icons.done,
                            size: 16,
                            color: colorMap[lead.status],
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(height: 4),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF17345A),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Text(
                        'View Details',
                        style: MyTexts.medium10.copyWith(
                          color: Colors.white,
                          letterSpacing: 0.4,
                        ),
                      ),
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
                icon: Icons.call_outlined,
                label: 'Call',
                onTap: () => controller.assignTo(lead.id, 'User A'),
              ),
              _ActionButton(
                icon: Icons.schedule_outlined,
                label: 'Reschedule',
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
            ],
          ),
        ],
      ),
    );
  }

  static String _formatTime(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')} AM';
  static String _formatDate(DateTime d) => '${d.month}, ${d.day}';
  static const colorMap = {
    Status.pending: Colors.orange,
    Status.closed: Colors.orange,
    Status.completed: Colors.green,
    Status.missed: Colors.red,
  };
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
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
