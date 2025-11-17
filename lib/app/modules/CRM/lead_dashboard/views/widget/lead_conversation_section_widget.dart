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
        const Gap(16),
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
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: MyColors.yellow.withValues(alpha: 0.25),
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
                        const Gap(16),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Location',
                                    style: MyTexts.regular14.copyWith(
                                      color: MyColors.custom('9E9E9E'),
                                    ),
                                  ),
                                  const Gap(4),
                                  Text(
                                    conversation['location'] ?? '',
                                    style: MyTexts.medium16.copyWith(
                                      color: MyColors.fontBlack,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Product',
                                    style: MyTexts.regular14.copyWith(
                                      color: MyColors.custom('9E9E9E'),
                                    ),
                                  ),
                                  const Gap(4),
                                  Text(
                                    conversation['product'] ?? '',
                                    style: MyTexts.medium16.copyWith(
                                      color: MyColors.fontBlack,
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
              }),
              if (leadConversations.length > 2)
                GestureDetector(
                  onTap: () {
                    // TODO: navigate to full conversation list
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'See more',
                      style: MyTexts.medium14.copyWith(
                        color: MyColors.primary,
                        decoration: TextDecoration.none,
                      ),
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
