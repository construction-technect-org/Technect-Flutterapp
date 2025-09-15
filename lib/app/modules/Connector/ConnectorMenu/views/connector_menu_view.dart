import 'package:construction_technect/app/core/utils/imports.dart';

class ConnectorMenuView extends StatelessWidget {
  const ConnectorMenuView({super.key});

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
            SizedBox(height: 1.h),
            _buildMenuItem(
              'Wish list',
              false,
              customIcon: SvgPicture.asset(Asset.wishlistIcon),
              onTap: () {
                // Get.to(() => ProductManagementView());
              },
            ),
            SizedBox(height: 1.h),
            _buildMenuItem(
              'Connection Inbox',
              true,
              customIcon: Image.asset(Asset.vectorIcon, height: 24, width: 24),
              onTap: () {
                //  Get.toNamed(Routes.CONNECTION_INBOX);
              },
            ),
            SizedBox(height: 1.h),
            _buildMenuItem(
              'Support Ticket',
              true,
              customIcon: SvgPicture.asset(Asset.suportTicket),
              onTap: () {
                // Get.to(() => CustomerSupportView());
              },
            ),
            SizedBox(height: 1.h),
            _buildMenuItem(
              'Settings',
            customIcon: SvgPicture.asset(Asset.settingsIcon, height: 24, width: 24),

              false,
              onTap: () {
                //  Get.to(() => const SettingView());
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
    IconData? icon, // 👈 Material icons
    Widget? customIcon, // 👈 Images/SVGs
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
            if (customIcon != null) ...[
              Stack(
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      isDestructive == true ? MyColors.red : MyColors.fontBlack,
                      BlendMode.srcIn,
                    ),
                    child: customIcon,
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
            ] else if (icon != null) ...[
              Icon(
                icon,
                size: 24,
                color: isDestructive == true ? MyColors.red : MyColors.primary,
              ),
            ] else ...[
              Stack(
                children: [
                  SvgPicture.asset(
                    Asset.menuSettingIcon,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      isDestructive == true ? MyColors.red : MyColors.fontBlack,
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
            ],

            SizedBox(width: 4.w),
            Text(
              title,
              style: MyTexts.medium16.copyWith(
                color: isDestructive == true ? MyColors.red : MyColors.fontBlack,
                fontWeight: highlight == true ? FontWeight.w600 : FontWeight.w800,
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          onPressed: onConfirm,
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
