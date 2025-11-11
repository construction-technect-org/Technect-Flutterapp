import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/controller/lead_dash_controller.dart';

class AnalysisSectionWidget extends GetView<LeadDashController> {
  const AnalysisSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Analysis',
          style: MyTexts.bold18.copyWith(color: MyColors.fontBlack),
        ),
        const Gap(16),
        Obx(() {
          final funnelData = controller.funnelData;
          final maxCount = funnelData
              .map((e) => e['count']! as int)
              .reduce((a, b) => a > b ? a : b);
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: MyColors.grayEA),
            ),
            child: Column(
              children: funnelData.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final widthPercentage = (item['count']! as int) / maxCount;

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index < funnelData.length - 1 ? 12 : 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${item['count']} ${item['label']}',
                            style: MyTexts.medium12.copyWith(
                              color: MyColors.fontBlack,
                            ),
                          ),
                        ],
                      ),
                      const Gap(4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          height: 24,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: (item['color']! as Color).withValues(
                              alpha: 0.2,
                            ),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: widthPercentage,
                            child: Container(
                              decoration: BoxDecoration(
                                color: item['color']! as Color,
                              ),
                            ),
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
