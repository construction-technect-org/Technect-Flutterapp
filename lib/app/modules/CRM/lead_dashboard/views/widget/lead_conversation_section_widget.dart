import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/controller/lead_dash_controller.dart';

class LeadConversationSectionWidget extends GetView<LeadDashController> {
  const LeadConversationSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lead conversation',
          style: MyTexts.bold18.copyWith(color: MyColors.fontBlack),
        ),
        const Gap(12),
        Obx(() {
          final leadConversations = controller.leadConversations;
          return Column(
            children: [
              ...leadConversations.take(2).map((conversation) {
                return GestureDetector(
                  onTap: () => Get.toNamed(Routes.Requ_DetailS),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: MyColors.grayEA),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: MyColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              conversation['id'] ?? '',
                              style: MyTexts.bold16.copyWith(
                                color: MyColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                conversation['location'] ?? '',
                                style: MyTexts.medium14.copyWith(
                                  color: MyColors.fontBlack,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                conversation['product'] ?? '',
                                style: MyTexts.regular12.copyWith(
                                  color: MyColors.custom('545454'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              if (leadConversations.length > 2)
                GestureDetector(
                  onTap: () {
                    // Navigate to see more
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'See more',
                      style: MyTexts.medium14.copyWith(color: MyColors.primary),
                    ),
                  ),
                ),
            ],
          );
        }),
      ],
    );
  }
}
