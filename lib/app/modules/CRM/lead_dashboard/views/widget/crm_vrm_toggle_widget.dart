import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/controller/lead_dash_controller.dart';

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
            _pillButton(
              title: "CRM",
              isSelected: isCRMSelected,
              onTap: () => controller.toggleCRMVRM(true),
            ),
            const SizedBox(width: 2),
            _pillButton(
              title: "VRM",
              isSelected: !isCRMSelected,
              onTap: () => controller.toggleCRMVRM(false),
            ),
          ],
        ),
      );
    });
  }

  Widget _pillButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E305C) : Colors.transparent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF1E305C),
          ),
        ),
      ),
    );
  }
}
