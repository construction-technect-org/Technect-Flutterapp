import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/controller/lead_dash_controller.dart';

class PipelineSectionWidget extends GetView<LeadDashController> {
  const PipelineSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pipeline',
          style: MyTexts.bold18.copyWith(color: MyColors.fontBlack),
        ),
        const Gap(16),
        Obx(() {
          final pipelineData = controller.pipelineData;
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: MyColors.grayEA),
            ),
            child: Column(
              children: pipelineData.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index < pipelineData.length - 1 ? 16 : 0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: item['color']! as Color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Gap(12),
                      Text(
                        item['count'].toString(),
                        style: MyTexts.bold16.copyWith(
                          color: MyColors.fontBlack,
                        ),
                      ),
                      const Gap(8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: (item['color']! as Color).withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item['label']! as String,
                          style: MyTexts.medium14.copyWith(
                            color: item['color']! as Color,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        }),
      ],
    );
  }
}
