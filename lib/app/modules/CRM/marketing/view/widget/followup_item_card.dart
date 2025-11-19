import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/marketing/model/lead_model.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/lead_item_Card.dart';

class FollowupItemCard extends StatelessWidget {
  final LeadModel lead;
  final MarketingController controller;

  const FollowupItemCard({required this.lead, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: const Color(0xFFEFF6FF),
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
                      Container(color: Colors.grey.shade200, width: 80, height: 97),
                  errorWidget: (c, s, e) => Container(
                    color: Colors.grey.shade200,
                    width: 80,
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
                            style: MyTexts.medium13.copyWith(fontWeight: FontWeight.w700),
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
                    Text(
                      'Lead Id - ${lead.id}',
                      style: MyTexts.medium13.copyWith(color: MyColors.black),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Product Interested - ${lead.product}',
                      style: MyTexts.medium13.copyWith(color: MyColors.black),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Next Follow Up - N0V 14 , 3:00 PM',
                      style: MyTexts.medium13.copyWith(color: MyColors.black),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Status - ${lead.status.name.capitalizeFirst}',
                          style: MyTexts.medium14.copyWith(color: colorMap[lead.status]),
                        ),
                        if (lead.status == Status.completed)
                          Icon(Icons.done, size: 16, color: colorMap[lead.status])
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ActionButton(
                hPadding: 14,
                icon: Asset.call,
                label: 'Call',
                onTap: () async {
                  final Uri url = Uri(scheme: 'tel', path: "999999999");

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
              ActionButton(
                hPadding: 14,

                icon: Asset.clock,
                label: 'Reschedule',
                onTap: () =>
                    controller.setReminder(lead.id, DateTime.now().add(const Duration(days: 1))),
              ),
              ActionButton(
                hPadding: 14,

                icon: Asset.chat,
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
    Status.completed: Color(0xFF15B01A),
    Status.missed: Colors.red,
  };
}
