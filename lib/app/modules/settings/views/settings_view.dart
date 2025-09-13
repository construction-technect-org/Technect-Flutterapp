import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CustomerSupport/views/customer_support_view.dart';
import 'package:construction_technect/app/modules/ProductManagement/views/product_management_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        
        backgroundColor: MyColors.white,
        elevation: 0,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(Asset.menuIcon, width: 24, height: 24),
        ),
        title: Text('Menu', style: MyTexts.regular20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.sw),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            _buildMenuItem(
              'Service Management',
              false,
              onTap: () {
                Get.toNamed(Routes.SERVICE_MANAGEMENT);
              },
            ),
            SizedBox(height: 1.h),
            _buildMenuItem(
              'Product Management',
              false,
              onTap: () {
                Get.to(() => ProductManagementView());
              },
            ),
            SizedBox(height: 1.h),
            _buildMenuItem('Approval Inbox', true),
            SizedBox(height: 1.h),
            _buildMenuItem(
              'Role Management',
              false,
              onTap: () {
                Get.toNamed(Routes.ROLE_MANAGEMENT);
              },
            ),
            SizedBox(height: 1.h),
            _buildMenuItem('Support Ticket', true,
             onTap: () {
                Get.to(() => CustomerSupportView());
              },

            ),
            SizedBox(height: 1.h),
            _buildMenuItem(
              'Settings',
              false,
              onTap: () {
                Get.toNamed(Routes.PROFILE);
              },
            ),
            SizedBox(height: 1.h),
            _buildMenuItem(
              'Log Out',
              false,
              isDestructive: false,
              icon: Icons.logout, // 👈 Material icon
              onTap: () {
                _showConfirmDialog(
                  context,
                  title: "Log Out",
                  message: "Are you sure you want to log out?",
                  confirmText: "Log Out",
                  onConfirm: () {
                    myPref.logout();
                    Get.offAllNamed(Routes.LOGIN);
                  },
                );
              },
            ),

            SizedBox(height: 1.h),

            // ❌ Delete Account (highlighted)
            _buildMenuItem(
              'Delete Account',
              false,
              isDestructive: false,
              highlight: true,
              icon: Icons.delete_forever, // 👈 Material delete icon
              onTap: () {
                _showConfirmDialog(
                  context,
                  title: "Delete Account",
                  message:
                      "This action cannot be undone. Are you sure you want to delete your account permanently?",
                  confirmText: "Delete",
                  onConfirm: () {
                    // TODO: Implement delete account logic
                    Get.back(); // Close dialog
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    bool hasNotification, {
    VoidCallback? onTap,
    bool? isDestructive,
    bool? highlight,
    IconData? icon, // 👈 optional icon
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: MyColors.menuTile,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 24,
                color: isDestructive == true ? MyColors.red : MyColors.primary,
              ),
            ],

            if (icon == null)
              Stack(
                children: [
                  SvgPicture.asset(
                    Asset.menuSettingIcon,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      MyColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  if (hasNotification)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),

            SizedBox(width: 4.w),
            Text(
              title,
              style: MyTexts.medium16.copyWith(
                color: isDestructive == true ? MyColors.red : MyColors.primary,
                fontWeight: highlight == true
                    ? FontWeight.w600
                    : FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Modern Confirmation Dialog
void _showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmText,
  required VoidCallback onConfirm,
}) {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      titlePadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: MyTexts.medium16.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),

      // ===== Message =====
      content: Text(
        message,
        style: MyTexts.regular16.copyWith(color: Colors.black87, height: 1.4),
      ),

      // ===== Actions =====
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey.shade400),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          onPressed: () => Get.back(),
          child: const Text("Cancel", style: TextStyle(color: Colors.black87)),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.logout, size: 18, color: Colors.white),
          label: Text(confirmText, style: const TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          onPressed: onConfirm,
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
