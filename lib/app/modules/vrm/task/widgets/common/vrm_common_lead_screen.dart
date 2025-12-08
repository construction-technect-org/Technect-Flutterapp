import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/model/vrm_lead_model.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/vrm_lead_item_card.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_today_card.dart';

class VrmCommonLeadScreen extends StatelessWidget {
  final String filterName;
  final int totalCount;
  final List<VrmLead> leads;
  final String emptyMessage;
  final Widget? todayCard;
  final Widget? addButton;
  final Widget? statusWidget;
  final double? topSpacing;

  const VrmCommonLeadScreen({
    super.key,
    required this.filterName,
    required this.totalCount,
    required this.leads,
    required this.emptyMessage,
    this.todayCard,
    this.addButton,
    this.statusWidget,
    this.topSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        todayCard ?? VrmCommonTodayCard(filterName: filterName, totalCount: totalCount),
        SizedBox(height: topSpacing ?? 18),
        if (addButton != null) addButton!,
        if (addButton != null) const Gap(8),
        if (statusWidget != null) statusWidget!,
        if (statusWidget != null) const Gap(8),
        if (leads.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
            child: Center(
              child: Text(emptyMessage, style: MyTexts.medium14.copyWith(color: MyColors.gray2E)),
            ),
          )
        else
          Column(
            children: leads
                .map(
                  (l) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: VrmLeadItemCard(lead: l),
                  ),
                )
                .toList(),
          ),
        const SizedBox(height: 24),
      ],
    );
  }
}
