import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/mainDashboard/controller/lead_dash_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/mainDashboard/views/widget/pill_button.dart';

class CRMVRMToggleWidget extends GetView<LeadDashController> {
  const CRMVRMToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isCRMSelected = controller.isCRMSelected.value;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PillButton(
              title: "CRM",
              isSelected: isCRMSelected,
              onTap: () => controller.toggleCRMVRM(true),
            ),
            const SizedBox(width: 2),
            PillButton(
              title: "VRM",
              isSelected: !isCRMSelected,
              onTap: () => controller.toggleCRMVRM(false),
            ),
          ],
        ),
      );
    });
  }
}
